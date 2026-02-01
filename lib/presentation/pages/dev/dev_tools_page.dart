// lib/presentation/pages/dev/dev_tools_page.dart

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/firebase_seeder.dart';
import '../../../core/services/push_notification_service.dart';

/// Página temporal para herramientas de desarrollo
///
/// ⚠️ SOLO PARA DEMO - Eliminar en producción
class DevToolsPage extends StatefulWidget {
  const DevToolsPage({super.key});

  @override
  State<DevToolsPage> createState() => _DevToolsPageState();
}

class _DevToolsPageState extends State<DevToolsPage> {
  bool _isLoading = false;
  String _status = 'Listo para cargar datos';
  String? _fcmToken;
  String _fcmDiagnostic = '';
  bool _isDiagnosing = false;

  @override
  void initState() {
    super.initState();
    _loadFcmToken();
  }

  Future<void> _loadFcmToken() async {
    final token = await PushNotificationService.getToken();
    setState(() {
      _fcmToken = token;
    });
  }

  /// Diagnostica el estado de FCM en Firebase
  Future<void> _diagnoseFcm() async {
    setState(() {
      _isDiagnosing = true;
      _fcmDiagnostic = 'Diagnosticando...';
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final buffer = StringBuffer();

      // 1. Check user
      if (user == null) {
        buffer.writeln('ERROR: No hay usuario autenticado');
        setState(() {
          _fcmDiagnostic = buffer.toString();
          _isDiagnosing = false;
        });
        return;
      }
      buffer.writeln('Usuario: ${user.uid}');
      buffer.writeln('Email: ${user.email ?? "N/A"}');

      // 2. Check FCM token local
      final localToken = await PushNotificationService.getToken();
      if (localToken == null) {
        buffer.writeln('ERROR: No hay token FCM local');
      } else {
        buffer.writeln('Token local: ${localToken.substring(0, 20)}...');
      }

      // 3. Check FCM token in Firebase
      final database = FirebaseDatabase.instance;
      final tokenSnapshot = await database
          .ref('blincar/users/${user.uid}/fcmToken')
          .get();

      if (tokenSnapshot.exists) {
        final firebaseToken = tokenSnapshot.value as String;
        buffer.writeln('Token en Firebase: ${firebaseToken.substring(0, 20)}...');
        if (localToken == firebaseToken) {
          buffer.writeln('TOKENS COINCIDEN');
        } else {
          buffer.writeln('TOKENS NO COINCIDEN');
        }
      } else {
        buffer.writeln('ERROR: Token NO guardado en Firebase');
        buffer.writeln('Guardando token ahora...');

        // Save token to Firebase
        if (localToken != null) {
          await database.ref('blincar/users/${user.uid}/fcmToken').set(localToken);
          await database.ref('blincar/fcm_tokens/${user.uid}').set({
            'token': localToken,
            'userId': user.uid,
            'updatedAt': ServerValue.timestamp,
          });
          buffer.writeln('Token guardado exitosamente');
        }
      }

      // 4. Check fcm_tokens collection
      final fcmTokensSnapshot = await database
          .ref('blincar/fcm_tokens/${user.uid}')
          .get();
      if (fcmTokensSnapshot.exists) {
        buffer.writeln('Entrada en fcm_tokens: SI');
      } else {
        buffer.writeln('Entrada en fcm_tokens: NO');
      }

      setState(() {
        _fcmDiagnostic = buffer.toString();
        _isDiagnosing = false;
      });
    } catch (e) {
      setState(() {
        _fcmDiagnostic = 'Error: $e';
        _isDiagnosing = false;
      });
    }
  }

  /// Crea un viaje de prueba para verificar Cloud Functions
  Future<void> _testCloudFunction() async {
    setState(() {
      _isDiagnosing = true;
      _fcmDiagnostic = 'Creando viaje de prueba...';
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _fcmDiagnostic = 'ERROR: No hay usuario autenticado';
          _isDiagnosing = false;
        });
        return;
      }

      final database = FirebaseDatabase.instance;
      final tripId = 'test_${DateTime.now().millisecondsSinceEpoch}';

      // Create trip with pending status
      await database.ref('blincar/trips/$tripId').set({
        'userId': user.uid,
        'status': 'pending',
        'createdAt': ServerValue.timestamp,
      });

      setState(() {
        _fcmDiagnostic = 'Viaje creado: $tripId\nCambiando a assigned...';
      });

      await Future.delayed(const Duration(seconds: 2));

      // Change status to assigned (this should trigger the Cloud Function)
      await database.ref('blincar/trips/$tripId').update({
        'status': 'assigned',
        'driverName': 'Conductor de Prueba',
      });

      setState(() {
        _fcmDiagnostic = 'Viaje actualizado a "assigned".\n\n'
            'Si la Cloud Function funciona, deberías recibir una notificación.\n\n'
            'Revisa logs en:\n'
            'Firebase Console > Functions > Logs';
        _isDiagnosing = false;
      });
    } catch (e) {
      setState(() {
        _fcmDiagnostic = 'Error: $e';
        _isDiagnosing = false;
      });
    }
  }

  Future<void> _seedDatabase() async {
    setState(() {
      _isLoading = true;
      _status = 'Cargando datos en Firebase...';
    });

    try {
      final seeder = FirebaseSeeder();
      final success = await seeder.seedDatabase();

      setState(() {
        _isLoading = false;
        _status = success
            ? '✅ Datos cargados exitosamente!\n\nVehículos, conductores y paquetes disponibles.'
            : '❌ Error al cargar datos. Revisa los logs.';
      });

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Firebase seed completado'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '❌ Error: $e';
      });
    }
  }

  /// Envía una notificación de prueba
  Future<void> _sendTestNotification({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'blincar_high_importance',
      'Blincar Notificaciones',
      channelDescription: 'Notificaciones importantes de viajes y pagos',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await PushNotificationService.localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: jsonEncode(data),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('📤 Notificación enviada: $title'),
          backgroundColor: AppTheme.primaryLightColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          '🛠️ Dev Tools',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.warningColor),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber, color: AppTheme.warningColor),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Solo para DEMO - Eliminar en producción',
                      style: TextStyle(
                        color: AppTheme.warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ========== SECCIÓN: NOTIFICACIONES ==========
            _buildSectionTitle('🔔 Probar Notificaciones'),
            const SizedBox(height: 8),
            const Text(
              'Toca un botón para enviar una notificación.\nLuego toca la notificación para probar la navegación.',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            // Grid de botones de notificación
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildNotificationButton(
                  icon: Icons.directions_car,
                  label: 'Viaje Completado',
                  color: AppTheme.successColor,
                  onTap: () => _sendTestNotification(
                    title: '🚗 Viaje Completado',
                    body: 'Tu viaje a Polanco ha terminado. ¡Gracias por viajar con Blincar!',
                    data: {'type': 'trip_completed', 'tripId': 'test_trip_001'},
                  ),
                ),
                _buildNotificationButton(
                  icon: Icons.payment,
                  label: 'Pago Confirmado',
                  color: AppTheme.primaryLightColor,
                  onTap: () => _sendTestNotification(
                    title: '💳 Pago Confirmado',
                    body: 'Tu pago de \$185.50 MXN ha sido procesado exitosamente.',
                    data: {'type': 'payment_confirmed'},
                  ),
                ),
                _buildNotificationButton(
                  icon: Icons.calendar_today,
                  label: 'Nueva Reservación',
                  color: Colors.purple,
                  onTap: () => _sendTestNotification(
                    title: '📅 Reservación Confirmada',
                    body: 'Tu reservación para mañana a las 10:00 AM está lista.',
                    data: {'type': 'new_reservation', 'reservationId': 'res_001'},
                  ),
                ),
                _buildNotificationButton(
                  icon: Icons.warning,
                  label: 'Alerta Pánico',
                  color: AppTheme.errorColor,
                  onTap: () => _sendTestNotification(
                    title: '🚨 ALERTA DE PÁNICO',
                    body: 'Un usuario ha activado el botón de pánico.',
                    data: {'type': 'panic_alert'},
                  ),
                ),
                _buildNotificationButton(
                  icon: Icons.local_taxi,
                  label: 'Conductor Llegó',
                  color: AppTheme.accentColor,
                  onTap: () => _sendTestNotification(
                    title: '🚕 Tu conductor ha llegado',
                    body: 'Carlos está esperándote en la puerta principal.',
                    data: {'type': 'driver_arrived', 'tripId': 'test_trip_002'},
                  ),
                ),
                _buildNotificationButton(
                  icon: Icons.notifications,
                  label: 'General',
                  color: Colors.grey,
                  onTap: () => _sendTestNotification(
                    title: '📢 Mensaje de Blincar',
                    body: 'Tienes nuevas promociones disponibles.',
                    data: {'type': 'general'},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // FCM Token
            if (_fcmToken != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FCM Token:',
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      _fcmToken!,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            const Divider(color: AppTheme.dividerColor),
            const SizedBox(height: 24),

            // ========== SECCIÓN: DIAGNÓSTICO FCM ==========
            _buildSectionTitle('🔍 Diagnóstico FCM'),
            const SizedBox(height: 8),
            const Text(
              'Verifica que el token FCM esté guardado en Firebase para que las Cloud Functions puedan enviar notificaciones.',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isDiagnosing ? null : _diagnoseFcm,
                    icon: _isDiagnosing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.search),
                    label: const Text('Diagnosticar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isDiagnosing ? null : _testCloudFunction,
                    icon: const Icon(Icons.cloud),
                    label: const Text('Test Cloud'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            if (_fcmDiagnostic.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.dividerColor),
                ),
                child: SelectableText(
                  _fcmDiagnostic,
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),
            const Divider(color: AppTheme.dividerColor),
            const SizedBox(height: 24),

            // ========== SECCIÓN: FIREBASE SEED ==========
            _buildSectionTitle('🌱 Firebase Seed Data'),
            const SizedBox(height: 8),
            const Text(
              'Carga datos de prueba en Firebase:\n'
              '• 7 vehículos\n'
              '• 3 conductores\n'
              '• 6 paquetes de servicio',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            // Botón de seed
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _seedDatabase,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Icon(Icons.upload),
              label: Text(_isLoading ? 'Cargando...' : '🌱 Cargar Seed Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryLightColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryLightColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Estado',
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _status,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Warning adicional
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '⚠️ Esto eliminará datos existentes en Firebase',
                style: TextStyle(
                  color: AppTheme.errorColor,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.textPrimaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildNotificationButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
