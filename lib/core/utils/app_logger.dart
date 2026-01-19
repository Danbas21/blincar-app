// lib/core/utils/app_logger.dart

import 'package:flutter/foundation.dart';
import '../config/env_config.dart';

/// Logger centralizado para la aplicacion
///
/// IMPORTANTE: Solo loguea en modo debug o si ENABLE_DEBUG_LOGS=true en .env
/// En produccion (release mode), los logs se omiten completamente.
///
/// Uso:
///   AppLogger.info('Mensaje informativo');
///   AppLogger.error('Error ocurrido', error: e, stackTrace: st);
///   AppLogger.debug('Solo visible en debug');
class AppLogger {
  AppLogger._();

  static bool get _shouldLog {
    // En release mode, solo loguear si esta explicitamente habilitado
    if (kReleaseMode) {
      return EnvConfig.enableDebugLogs;
    }
    // En debug mode, siempre loguear
    return true;
  }

  /// Log de informacion general
  static void info(String message, {String? tag}) {
    if (!_shouldLog) return;
    final prefix = tag != null ? '[$tag]' : '[INFO]';
    debugPrint('$prefix $message');
  }

  /// Log de debug (solo en desarrollo)
  static void debug(String message, {String? tag}) {
    if (!_shouldLog) return;
    final prefix = tag != null ? '[$tag]' : '[DEBUG]';
    debugPrint('$prefix $message');
  }

  /// Log de advertencia
  static void warning(String message, {String? tag}) {
    if (!_shouldLog) return;
    final prefix = tag != null ? '[$tag]' : '[WARN]';
    debugPrint('$prefix $message');
  }

  /// Log de error con stack trace opcional
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog) return;
    final prefix = tag != null ? '[$tag]' : '[ERROR]';
    debugPrint('$prefix $message');
    if (error != null) {
      debugPrint('$prefix Error: $error');
    }
    if (stackTrace != null) {
      debugPrint('$prefix StackTrace: $stackTrace');
    }
  }

  /// Log de operaciones de viaje
  static void trip(String message) {
    info(message, tag: 'TRIP');
  }

  /// Log de operaciones de autenticacion
  static void auth(String message) {
    info(message, tag: 'AUTH');
  }

  /// Log de operaciones de ubicacion
  static void location(String message) {
    info(message, tag: 'LOCATION');
  }

  /// Log de operaciones de pago
  static void payment(String message) {
    info(message, tag: 'PAYMENT');
  }

  /// Log de operaciones de Firebase
  static void firebase(String message) {
    info(message, tag: 'FIREBASE');
  }
}
