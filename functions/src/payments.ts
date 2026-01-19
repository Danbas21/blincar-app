// functions/src/payments.ts

import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import Stripe from 'stripe';

// Inicializar Stripe con tu SECRET KEY
const stripe = new Stripe(functions.config().stripe.secret_key, {
    apiVersion: '2024-11-20.acacia',
});

/**
 * Crea un Payment Intent para procesar un pago
 * 
 * CRITICO: Esta funcion DEBE verificar que el userId corresponda
 * al usuario autenticado para evitar fraudes
 */
export const createPaymentIntent = functions.https.onCall(
    async (data, context) => {
        // 🔐 SEGURIDAD: Verificar autenticacion
        if (!context.auth) {
            throw new functions.https.HttpsError(
                'unauthenticated',
                'Usuario no autenticado'
            );
        }

        // Verificar que el usuario solo pueda crear pagos para si mismo
        if (context.auth.uid !== data.userId) {
            throw new functions.https.HttpsError(
                'permission-denied',
                'No autorizado'
            );
        }

        try {
            const { amount, currency, userId, metadata } = data;

            // Validaciones
            if (!amount || amount <= 0) {
                throw new functions.https.HttpsError(
                    'invalid-argument',
                    'Monto invalido'
                );
            }

            if (!currency) {
                throw new functions.https.HttpsError(
                    'invalid-argument',
                    'Moneda requerida'
                );
            }

            // Crear Payment Intent
            const paymentIntent = await stripe.paymentIntents.create({
                amount,
                currency: currency.toLowerCase(),
                metadata: {
                    ...metadata,
                    userId,
                    firebase_uid: context.auth.uid,
                    timestamp: new Date().toISOString(),
                },
                // Habilitar metodos de pago automaticos (incluye 3D Secure)
                automatic_payment_methods: {
                    enabled: true,
                },
            });

            // 📝 OPCIONAL: Guardar registro en Firestore para auditoria
            await admin.firestore()
                .collection('payment_intents')
                .doc(paymentIntent.id)
                .set({
                    userId,
                    amount,
                    currency,
                    status: paymentIntent.status,
                    createdAt: admin.firestore.FieldValue.serverTimestamp(),
                });

            // Retornar datos necesarios para el cliente
            return {
                id: paymentIntent.id,
                client_secret: paymentIntent.client_secret,
                amount: paymentIntent.amount,
                currency: paymentIntent.currency,
                status: paymentIntent.status,
            };
        } catch (error: any) {
            console.error('Error creating payment intent:', error);

            if (error instanceof functions.https.HttpsError) {
                throw error;
            }

            throw new functions.https.HttpsError(
                'internal',
                'Error al crear el payment intent',
                error
            );
        }
    }
);

/**
 * Webhook para escuchar eventos de Stripe
 * 
 * IMPORTANTE: Debes configurar este webhook en el Dashboard de Stripe
 */
export const stripeWebhook = functions.https.onRequest(async (req, res) => {
    const sig = req.headers['stripe-signature'];

    if (!sig) {
        res.status(400).send('Missing signature');
        return;
    }

    let event: Stripe.Event;

    try {
        event = stripe.webhooks.constructEvent(
            req.rawBody,
            sig,
            functions.config().stripe.webhook_secret
        );
    } catch (err: any) {
        console.error('Webhook signature verification failed:', err.message);
        res.status(400).send(`Webhook Error: ${err.message}`);
        return;
    }

    // Manejar diferentes tipos de eventos
    switch (event.type) {
        case 'payment_intent.succeeded':
            const paymentIntent = event.data.object as Stripe.PaymentIntent;
            await handlePaymentSuccess(paymentIntent);
            break;

        case 'payment_intent.payment_failed':
            const failedPayment = event.data.object as Stripe.PaymentIntent;
            await handlePaymentFailure(failedPayment);
            break;

        default:
            console.log(`Unhandled event type: ${event.type}`);
    }

    res.json({ received: true });
});

async function handlePaymentSuccess(paymentIntent: Stripe.PaymentIntent) {
    const userId = paymentIntent.metadata.userId;

    if (!userId) {
        console.error('No userId in payment intent metadata');
        return;
    }

    // Actualizar el estado del pago en Firestore
    await admin.firestore()
        .collection('payment_intents')
        .doc(paymentIntent.id)
        .update({
            status: 'succeeded',
            succeededAt: admin.firestore.FieldValue.serverTimestamp(),
        });

    // TODO: Aqui puedes actualizar el estado del viaje, enviar notificaciones, etc.
    console.log(`Payment succeeded for user ${userId}`);
}

async function handlePaymentFailure(paymentIntent: Stripe.PaymentIntent) {
    const userId = paymentIntent.metadata.userId;

    if (!userId) {
        console.error('No userId in payment intent metadata');
        return;
    }

    await admin.firestore()
        .collection('payment_intents')
        .doc(paymentIntent.id)
        .update({
            status: 'failed',
            failedAt: admin.firestore.FieldValue.serverTimestamp(),
            failureReason: paymentIntent.last_payment_error?.message,
        });

    console.log(`Payment failed for user ${userId}`);
}