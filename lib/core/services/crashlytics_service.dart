// lib/core/services/crashlytics_service.dart

import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Servicio para manejo de errores y crash reporting con Firebase Crashlytics
///
/// Funcionalidades:
/// - Captura automática de crashes fatales
/// - Reporte de errores no fatales
/// - Logs personalizados para debugging
/// - Identificación de usuarios para seguimiento
///
/// USO:
/// ```dart
/// // Inicializar en main.dart
/// await CrashlyticsService.initialize();
///
/// // Reportar error manualmente
/// CrashlyticsService.recordError(error, stackTrace);
///
/// // Agregar log para contexto
/// CrashlyticsService.log('Usuario intentó pagar');
/// ```
class CrashlyticsService {
  static FirebaseCrashlytics? _instance;

  /// Obtiene la instancia de Crashlytics
  static FirebaseCrashlytics get instance {
    _instance ??= FirebaseCrashlytics.instance;
    return _instance!;
  }

  /// Inicializa Crashlytics con configuración de producción
  ///
  /// - En DEBUG: Crashlytics deshabilitado (no envía reportes)
  /// - En RELEASE: Crashlytics habilitado con captura automática
  static Future<void> initialize() async {
    // Deshabilitar en modo debug para no contaminar reportes
    if (kDebugMode) {
      await instance.setCrashlyticsCollectionEnabled(false);
      _debugLog('Crashlytics deshabilitado (modo debug)');
      return;
    }

    // Habilitar en release
    await instance.setCrashlyticsCollectionEnabled(true);

    // Capturar errores fatales de Flutter
    FlutterError.onError = (errorDetails) {
      instance.recordFlutterFatalError(errorDetails);
    };

    // Capturar errores asíncronos no manejados
    PlatformDispatcher.instance.onError = (error, stack) {
      instance.recordError(error, stack, fatal: true);
      return true;
    };

    _debugLog('Crashlytics inicializado correctamente');
  }

  /// Registra un error no fatal
  ///
  /// Usar para errores que no crashean la app pero deben monitorearse:
  /// - Errores de red
  /// - Errores de parsing
  /// - Errores de validación
  static Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    if (kDebugMode) {
      _debugLog('Error capturado: $exception');
      return;
    }

    await instance.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Agrega un log para contexto en crash reports
  ///
  /// Los logs aparecen en el reporte de crash para entender
  /// qué estaba haciendo el usuario antes del error.
  static void log(String message) {
    if (kDebugMode) {
      _debugLog(message);
      return;
    }

    instance.log(message);
  }

  /// Identifica al usuario para seguimiento de crashes
  ///
  /// Permite filtrar crashes por usuario en la consola de Firebase.
  /// NO enviar información sensible (email, teléfono, etc.)
  static Future<void> setUserId(String userId) async {
    if (kDebugMode) return;
    await instance.setUserIdentifier(userId);
  }

  /// Limpia el identificador de usuario (en logout)
  static Future<void> clearUserId() async {
    if (kDebugMode) return;
    await instance.setUserIdentifier('');
  }

  /// Agrega atributos personalizados al reporte
  ///
  /// Útil para agregar contexto como:
  /// - Versión del backend
  /// - Tipo de usuario (pasajero/conductor)
  /// - Estado del viaje
  static Future<void> setCustomKey(String key, dynamic value) async {
    if (kDebugMode) return;
    await instance.setCustomKey(key, value.toString());
  }

  /// Fuerza un crash para testing (solo usar en desarrollo)
  static void testCrash() {
    if (kDebugMode) {
      instance.crash();
    }
  }

  /// Log interno solo en modo debug
  static void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[Crashlytics] $message');
    }
  }
}
