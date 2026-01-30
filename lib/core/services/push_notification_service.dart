// lib/core/services/push_notification_service.dart

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Handler para mensajes en background (debe ser función top-level)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // No inicializar Firebase aquí - ya está inicializado
  if (kDebugMode) {
    debugPrint('[PushNotification] Background message: ${message.messageId}');
  }
}

/// Servicio para manejo de Push Notifications con Firebase Cloud Messaging
///
/// Funcionalidades:
/// - Recibir notificaciones en foreground, background y terminated
/// - Mostrar notificaciones locales personalizadas
/// - Manejar taps en notificaciones
/// - Obtener y gestionar FCM token
///
/// USO:
/// ```dart
/// // Inicializar en main.dart
/// await PushNotificationService.initialize();
///
/// // Obtener token para enviar desde servidor
/// final token = await PushNotificationService.getToken();
///
/// // Escuchar cambios de token
/// PushNotificationService.onTokenRefresh.listen((token) {
///   // Enviar nuevo token al servidor
/// });
/// ```
class PushNotificationService {
  static FirebaseMessaging? _messaging;
  static FlutterLocalNotificationsPlugin? _localNotifications;

  // Callback para manejar taps en notificaciones
  static void Function(Map<String, dynamic> data)? onNotificationTap;

  /// Obtiene la instancia de FirebaseMessaging
  static FirebaseMessaging get messaging {
    _messaging ??= FirebaseMessaging.instance;
    return _messaging!;
  }

  /// Obtiene la instancia de notificaciones locales
  static FlutterLocalNotificationsPlugin get localNotifications {
    _localNotifications ??= FlutterLocalNotificationsPlugin();
    return _localNotifications!;
  }

  /// Canal de notificaciones para Android (alta prioridad)
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'blincar_high_importance',
    'Blincar Notificaciones',
    description: 'Notificaciones importantes de viajes y pagos',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  /// Inicializa el servicio de notificaciones
  static Future<void> initialize() async {
    // Registrar handler de background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Solicitar permisos
    await _requestPermissions();

    // Configurar notificaciones locales
    await _setupLocalNotifications();

    // Crear canal de Android
    await _createNotificationChannel();

    // Configurar handlers de mensajes
    _setupMessageHandlers();

    _debugLog('Push Notifications inicializadas');
  }

  /// Solicita permisos de notificación
  static Future<bool> _requestPermissions() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final authorized = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    _debugLog('Permisos: ${settings.authorizationStatus}');
    return authorized;
  }

  /// Configura notificaciones locales
  static Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Crea el canal de notificaciones en Android
  static Future<void> _createNotificationChannel() async {
    final androidPlugin = localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(_channel);
    }
  }

  /// Configura los handlers de mensajes FCM
  static void _setupMessageHandlers() {
    // Mensaje recibido en foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Usuario toca notificación (app en background)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Verificar si la app se abrió desde una notificación
    _checkInitialMessage();
  }

  /// Maneja mensajes en foreground
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _debugLog('Foreground message: ${message.notification?.title}');

    final notification = message.notification;
    if (notification != null) {
      await _showLocalNotification(
        title: notification.title ?? 'Blincar',
        body: notification.body ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Maneja cuando el usuario toca una notificación
  static void _handleMessageOpenedApp(RemoteMessage message) {
    _debugLog('Message opened app: ${message.data}');
    onNotificationTap?.call(message.data);
  }

  /// Verifica si la app se abrió desde una notificación
  static Future<void> _checkInitialMessage() async {
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _debugLog('Initial message: ${initialMessage.data}');
      // Dar tiempo a que la app se inicialice
      Future.delayed(const Duration(seconds: 1), () {
        onNotificationTap?.call(initialMessage.data);
      });
    }
  }

  /// Muestra notificación local
  static Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
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

    await localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Callback cuando el usuario toca una notificación local
  static void _onNotificationTap(NotificationResponse response) {
    _debugLog('Notification tap: ${response.payload}');

    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        onNotificationTap?.call(data);
      } catch (e) {
        _debugLog('Error parsing payload: $e');
      }
    }
  }

  // ========================================
  // API PÚBLICA
  // ========================================

  /// Obtiene el FCM token actual
  static Future<String?> getToken() async {
    try {
      final token = await messaging.getToken();
      _debugLog('FCM Token: ${token?.substring(0, 20)}...');
      return token;
    } catch (e) {
      _debugLog('Error obteniendo token: $e');
      return null;
    }
  }

  /// Stream de cambios de token
  static Stream<String> get onTokenRefresh => messaging.onTokenRefresh;

  /// Suscribe a un tema (ej: 'promotions', 'news')
  static Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    _debugLog('Subscrito a: $topic');
  }

  /// Desuscribe de un tema
  static Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
    _debugLog('Desuscrito de: $topic');
  }

  /// Elimina el token FCM (útil en logout)
  static Future<void> deleteToken() async {
    await messaging.deleteToken();
    _debugLog('Token eliminado');
  }

  /// Log interno solo en modo debug
  static void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[PushNotification] $message');
    }
  }
}
