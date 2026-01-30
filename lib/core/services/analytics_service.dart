// lib/core/services/analytics_service.dart

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Servicio de analytics para tracking de eventos y comportamiento de usuarios
///
/// Funcionalidades:
/// - Tracking de pantallas visitadas
/// - Eventos personalizados (login, registro, viaje, pago, etc.)
/// - Propiedades de usuario para segmentación
///
/// USO:
/// ```dart
/// // Registrar pantalla
/// AnalyticsService.logScreenView('home');
///
/// // Registrar evento
/// AnalyticsService.logEvent('trip_requested', {'origin': 'CDMX'});
///
/// // Registrar login
/// AnalyticsService.logLogin('google');
/// ```
class AnalyticsService {
  static FirebaseAnalytics? _instance;
  static FirebaseAnalyticsObserver? _observer;

  /// Obtiene la instancia de Analytics
  static FirebaseAnalytics get instance {
    _instance ??= FirebaseAnalytics.instance;
    return _instance!;
  }

  /// Observer para tracking automático de navegación
  static FirebaseAnalyticsObserver get observer {
    _observer ??= FirebaseAnalyticsObserver(analytics: instance);
    return _observer!;
  }

  /// Inicializa Analytics
  static Future<void> initialize() async {
    if (kDebugMode) {
      // En debug, deshabilitamos para no contaminar datos
      await instance.setAnalyticsCollectionEnabled(false);
      _debugLog('Analytics deshabilitado (modo debug)');
      return;
    }

    await instance.setAnalyticsCollectionEnabled(true);
    _debugLog('Analytics inicializado correctamente');
  }

  // ========================================
  // EVENTOS DE PANTALLA
  // ========================================

  /// Registra vista de pantalla
  static Future<void> logScreenView(String screenName, {String? screenClass}) async {
    if (kDebugMode) {
      _debugLog('Screen: $screenName');
      return;
    }

    await instance.logScreenView(
      screenName: screenName,
      screenClass: screenClass ?? screenName,
    );
  }

  // ========================================
  // EVENTOS DE AUTENTICACIÓN
  // ========================================

  /// Registra inicio de sesión
  static Future<void> logLogin(String method) async {
    if (kDebugMode) {
      _debugLog('Login: $method');
      return;
    }

    await instance.logLogin(loginMethod: method);
  }

  /// Registra registro de usuario
  static Future<void> logSignUp(String method) async {
    if (kDebugMode) {
      _debugLog('SignUp: $method');
      return;
    }

    await instance.logSignUp(signUpMethod: method);
  }

  // ========================================
  // EVENTOS DE VIAJE
  // ========================================

  /// Registra solicitud de viaje
  static Future<void> logTripRequested({
    required String origin,
    required String destination,
    String? serviceType,
  }) async {
    await logEvent('trip_requested', {
      'origin': origin,
      'destination': destination,
      if (serviceType != null) 'service_type': serviceType,
    });
  }

  /// Registra viaje aceptado
  static Future<void> logTripAccepted(String tripId) async {
    await logEvent('trip_accepted', {'trip_id': tripId});
  }

  /// Registra viaje iniciado
  static Future<void> logTripStarted(String tripId) async {
    await logEvent('trip_started', {'trip_id': tripId});
  }

  /// Registra viaje completado
  static Future<void> logTripCompleted({
    required String tripId,
    required double fare,
    required int durationMinutes,
  }) async {
    await logEvent('trip_completed', {
      'trip_id': tripId,
      'fare': fare,
      'duration_minutes': durationMinutes,
    });
  }

  /// Registra viaje cancelado
  static Future<void> logTripCancelled({
    required String tripId,
    required String reason,
    required String cancelledBy,
  }) async {
    await logEvent('trip_cancelled', {
      'trip_id': tripId,
      'reason': reason,
      'cancelled_by': cancelledBy,
    });
  }

  // ========================================
  // EVENTOS DE PAGO
  // ========================================

  /// Registra método de pago agregado
  static Future<void> logPaymentMethodAdded(String type) async {
    await logEvent('payment_method_added', {'type': type});
  }

  /// Registra pago exitoso
  static Future<void> logPurchase({
    required double amount,
    required String currency,
    required String tripId,
  }) async {
    if (kDebugMode) {
      _debugLog('Purchase: $amount $currency');
      return;
    }

    await instance.logPurchase(
      currency: currency,
      value: amount,
      items: [
        AnalyticsEventItem(
          itemId: tripId,
          itemName: 'Viaje Blincar',
          itemCategory: 'transport',
          price: amount,
          quantity: 1,
        ),
      ],
    );
  }

  // ========================================
  // EVENTOS GENÉRICOS
  // ========================================

  /// Registra evento personalizado
  static Future<void> logEvent(String name, [Map<String, dynamic>? parameters]) async {
    if (kDebugMode) {
      _debugLog('Event: $name ${parameters ?? ''}');
      return;
    }

    await instance.logEvent(
      name: name,
      parameters: parameters?.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  // ========================================
  // PROPIEDADES DE USUARIO
  // ========================================

  /// Establece ID de usuario
  static Future<void> setUserId(String userId) async {
    if (kDebugMode) return;
    await instance.setUserId(id: userId);
  }

  /// Limpia ID de usuario (logout)
  static Future<void> clearUserId() async {
    if (kDebugMode) return;
    await instance.setUserId(id: null);
  }

  /// Establece propiedad de usuario
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (kDebugMode) {
      _debugLog('UserProperty: $name = $value');
      return;
    }

    await instance.setUserProperty(name: name, value: value);
  }

  /// Establece tipo de usuario (pasajero/conductor)
  static Future<void> setUserType(String type) async {
    await setUserProperty(name: 'user_type', value: type);
  }

  /// Log interno solo en modo debug
  static void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[Analytics] $message');
    }
  }
}
