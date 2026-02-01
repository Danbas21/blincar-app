/**
 * Firebase Cloud Functions para Blincar
 *
 * Maneja notificaciones push cuando cambia el estado de los viajes
 */

import { setGlobalOptions } from "firebase-functions";
import { onValueUpdated } from "firebase-functions/v2/database";
import { onCall } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";

// Inicializar Firebase Admin
admin.initializeApp();

// Configuración global
setGlobalOptions({ maxInstances: 10, region: "us-central1" });

/**
 * Escucha cambios en el estado del viaje y envía notificaciones
 *
 * Trigger: Cuando cambia /blincar/trips/{tripId}
 */
export const onTripStatusChanged = onValueUpdated(
  {
    ref: "/blincar/trips/{tripId}",
    region: "us-central1",
  },
  async (event) => {
    const tripId = event.params.tripId;
    const beforeData = event.data.before.val();
    const afterData = event.data.after.val();

    if (!beforeData || !afterData) {
      logger.warn("No hay datos del viaje");
      return;
    }

    const previousStatus = beforeData.status;
    const newStatus = afterData.status;

    // Si el estado no cambió, no hacer nada
    if (previousStatus === newStatus) {
      return;
    }

    logger.info(`Trip ${tripId}: ${previousStatus} -> ${newStatus}`);

    const userId = afterData.userId;
    if (!userId) {
      logger.warn("No se encontró userId en el viaje");
      return;
    }

    // Obtener token FCM del usuario
    const userTokenSnapshot = await admin
      .database()
      .ref(`blincar/users/${userId}/fcmToken`)
      .get();

    let fcmToken = userTokenSnapshot.val();

    // Si no está en users, buscar en fcm_tokens
    if (!fcmToken) {
      const tokensSnapshot = await admin
        .database()
        .ref("fcm_tokens")
        .orderByChild("userId")
        .equalTo(userId)
        .limitToFirst(1)
        .get();

      if (tokensSnapshot.exists()) {
        const tokens = tokensSnapshot.val();
        const firstKey = Object.keys(tokens)[0];
        fcmToken = tokens[firstKey]?.token;
      }
    }

    if (!fcmToken) {
      logger.warn(`No se encontró token FCM para usuario ${userId}`);
      return;
    }

    // Crear mensaje según el nuevo estado
    let notification: { title: string; body: string } | null = null;
    let data: Record<string, string> = {
      tripId,
      type: newStatus,
    };

    switch (newStatus) {
      case "assigned":
        notification = {
          title: "✅ Conductor Asignado",
          body: `${afterData.driverName || "Tu conductor"} está en camino`,
        };
        data.driverName = afterData.driverName || "";
        data.driverPhone = afterData.driverPhone || "";
        data.vehiclePlate = afterData.vehiclePlate || "";
        break;

      case "driver_arrived":
        notification = {
          title: "📍 Conductor Llegó",
          body: `${afterData.driverName || "Tu conductor"} está esperándote`,
        };
        break;

      case "in_progress":
        notification = {
          title: "🚀 Viaje Iniciado",
          body: "Tu viaje ha comenzado. ¡Buen viaje!",
        };
        break;

      case "completed":
        notification = {
          title: "✅ Viaje Completado",
          body: `Viaje finalizado - Total: $${afterData.totalPrice?.toFixed(0) || "0"} MXN`,
        };
        break;

      case "cancelled":
        notification = {
          title: "❌ Viaje Cancelado",
          body: afterData.cancelReason || "Tu viaje ha sido cancelado",
        };
        break;

      default:
        // No enviar notificación para otros estados
        return;
    }

    if (notification) {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: notification.title,
            body: notification.body,
          },
          data,
          android: {
            priority: "high",
            notification: {
              channelId: "trip_updates",
              priority: "high",
              defaultSound: true,
              defaultVibrateTimings: true,
            },
          },
          apns: {
            payload: {
              aps: {
                sound: "default",
                badge: 1,
              },
            },
          },
        });

        logger.info(`Notificación enviada a ${userId}: ${notification.title}`);

        // Guardar notificación en la base de datos
        await admin.database().ref(`blincar/notifications/${userId}`).push({
          title: notification.title,
          body: notification.body,
          type: newStatus,
          tripId,
          read: false,
          createdAt: admin.database.ServerValue.TIMESTAMP,
        });
      } catch (error) {
        logger.error("Error enviando notificación:", error);
      }
    }
  }
);

/**
 * Función para notificar cuando el conductor está cerca
 * Se puede llamar manualmente o por trigger de ubicación
 */
export const notifyDriverNearby = onValueUpdated(
  {
    ref: "/blincar/trips/{tripId}/driverDistanceMeters",
    region: "us-central1",
  },
  async (event) => {
    const tripId = event.params.tripId;
    const previousDistance = event.data.before.val();
    const currentDistance = event.data.after.val();

    // Si el conductor está a menos de 200 metros y antes estaba más lejos
    if (currentDistance <= 200 && previousDistance > 200) {
      const tripSnapshot = await admin
        .database()
        .ref(`blincar/trips/${tripId}`)
        .get();
      const tripData = tripSnapshot.val();

      if (!tripData || tripData.status !== "assigned") {
        return;
      }

      const userId = tripData.userId;
      const userTokenSnapshot = await admin
        .database()
        .ref(`blincar/users/${userId}/fcmToken`)
        .get();

      const fcmToken = userTokenSnapshot.val();
      if (!fcmToken) {
        return;
      }

      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: "🚗 Conductor Cerca",
            body: `${tripData.driverName || "Tu conductor"} está a ${currentDistance} metros`,
          },
          data: {
            tripId,
            type: "driver_nearby",
            distance: String(currentDistance),
          },
          android: {
            priority: "high",
            notification: {
              channelId: "trip_updates",
              priority: "high",
              defaultSound: true,
            },
          },
        });

        logger.info(`Notificación "conductor cerca" enviada para trip ${tripId}`);
      } catch (error) {
        logger.error("Error enviando notificación de proximidad:", error);
      }
    }
  }
);

/**
 * Envía email de recuperación de contraseña personalizado por idioma
 *
 * Callable Function: Se llama desde Flutter con email y locale
 *
 * @param data.email - Email del usuario
 * @param data.locale - Idioma preferido ('es' o 'en')
 */
export const sendPasswordResetEmail = onCall(
  {
    region: "us-central1",
    cors: true,
  },
  async (request) => {
    const { email, locale = "es" } = request.data;

    // Validar parámetros
    if (!email || typeof email !== "string") {
      throw new Error("Email es requerido");
    }

    // Validar formato de email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      throw new Error("Email inválido");
    }

    try {
      // Configurar el idioma del email según el locale
      const languageCode = locale === "es" ? "es" : "en";

      // NOTA: Firebase Admin SDK no puede enviar emails directamente
      // Usamos el método de cliente que SÍ funciona con permisos estándar
      // Para esto, retornamos éxito y el cliente Flutter usará el método nativo

      // Verificar que el usuario existe
      try {
        await admin.auth().getUserByEmail(email);
      } catch (error) {
        throw new Error(
          locale === "es" ? "Usuario no encontrado" : "User not found"
        );
      }

      // Templates de email según idioma (para futura implementación con servicio de email)
      /* const templates = {
        es: {
          subject: "🔐 Recupera tu contraseña de Blincar",
          body: `
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #001138; color: #ffffff;">
              <div style="text-align: center; margin-bottom: 30px;">
                <h1 style="color: #00C6FF; margin: 0;">Blincar</h1>
              </div>

              <div style="background-color: #001f52; border-radius: 10px; padding: 30px;">
                <h2 style="color: #ffffff; margin-top: 0;">Recuperación de Contraseña</h2>

                <p style="color: #c7d0dd; font-size: 16px; line-height: 1.6;">
                  Hola,
                </p>

                <p style="color: #c7d0dd; font-size: 16px; line-height: 1.6;">
                  Recibimos una solicitud para restablecer la contraseña de tu cuenta de Blincar.
                </p>

                <div style="text-align: center; margin: 30px 0;">
                  <a href="${resetLink}"
                     style="display: inline-block; background: linear-gradient(90deg, #00C6FF 0%, #001580 100%);
                            color: #ffffff; text-decoration: none; padding: 15px 40px;
                            border-radius: 25px; font-weight: bold; font-size: 16px;">
                    Restablecer Contraseña
                  </a>
                </div>

                <p style="color: #c7d0dd; font-size: 14px; line-height: 1.6;">
                  O copia y pega este enlace en tu navegador:
                </p>

                <p style="color: #00C6FF; font-size: 12px; word-break: break-all; background-color: #001138; padding: 10px; border-radius: 5px;">
                  ${resetLink}
                </p>

                <p style="color: #c7d0dd; font-size: 14px; line-height: 1.6; margin-top: 30px;">
                  <strong>⚠️ Nota importante:</strong> Este enlace expirará en 1 hora.
                </p>

                <p style="color: #c7d0dd; font-size: 14px; line-height: 1.6;">
                  Si no solicitaste este cambio, ignora este correo. Tu contraseña permanecerá sin cambios.
                </p>

                <hr style="border: none; border-top: 1px solid #003366; margin: 30px 0;">

                <p style="color: #8899aa; font-size: 12px; text-align: center;">
                  Este es un correo automático, por favor no respondas a este mensaje.
                </p>
              </div>
            </div>
          `,
        },
        en: {
          subject: "🔐 Reset your Blincar password",
          body: `
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #001138; color: #ffffff;">
              <div style="text-align: center; margin-bottom: 30px;">
                <h1 style="color: #00C6FF; margin: 0;">Blincar</h1>
              </div>

              <div style="background-color: #001f52; border-radius: 10px; padding: 30px;">
                <h2 style="color: #ffffff; margin-top: 0;">Password Recovery</h2>

                <p style="color: #c7d0dd; font-size: 16px; line-height: 1.6;">
                  Hello,
                </p>

                <p style="color: #c7d0dd; font-size: 16px; line-height: 1.6;">
                  We received a request to reset your Blincar account password.
                </p>

                <div style="text-align: center; margin: 30px 0;">
                  <a href="${resetLink}"
                     style="display: inline-block; background: linear-gradient(90deg, #00C6FF 0%, #001580 100%);
                            color: #ffffff; text-decoration: none; padding: 15px 40px;
                            border-radius: 25px; font-weight: bold; font-size: 16px;">
                    Reset Password
                  </a>
                </div>

                <p style="color: #c7d0dd; font-size: 14px; line-height: 1.6;">
                  Or copy and paste this link into your browser:
                </p>

                <p style="color: #00C6FF; font-size: 12px; word-break: break-all; background-color: #001138; padding: 10px; border-radius: 5px;">
                  ${resetLink}
                </p>

                <p style="color: #c7d0dd; font-size: 14px; line-height: 1.6; margin-top: 30px;">
                  <strong>⚠️ Important note:</strong> This link will expire in 1 hour.
                </p>

                <p style="color: #c7d0dd; font-size: 14px; line-height: 1.6;">
                  If you didn't request this change, please ignore this email. Your password will remain unchanged.
                </p>

                <hr style="border: none; border-top: 1px solid #003366; margin: 30px 0;">

                <p style="color: #8899aa; font-size: 12px; text-align: center;">
                  This is an automated email, please do not reply to this message.
                </p>
              </div>
            </div>
          `,
        },
      }; */

      // Usuario existe, retornar éxito
      // El cliente Flutter usará el método nativo sendPasswordResetEmail
      logger.info(
        `Password reset requested for ${email} with locale: ${languageCode}`
      );

      return {
        success: true,
        userExists: true,
        locale: languageCode,
        message:
          locale === "es"
            ? "Usuario verificado. Procede con el envío del email."
            : "User verified. Proceed with email sending.",
      };
    } catch (error: unknown) {
      logger.error("Error verifying user for password reset:", error);

      // Mapear errores de Firebase
      const errorMessage =
        error instanceof Error ? error.message : String(error);

      if (
        errorMessage.includes("user-not-found") ||
        errorMessage.includes("Usuario no encontrado") ||
        errorMessage.includes("User not found")
      ) {
        return {
          success: false,
          userExists: false,
          message:
            locale === "es" ? "Usuario no encontrado" : "User not found",
        };
      }

      throw new Error(
        locale === "es"
          ? "Error al verificar usuario"
          : "Error verifying user"
      );
    }
  }
);
