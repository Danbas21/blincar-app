// lib/core/services/fcm_manager.dart

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/fcm_repository.dart';
import 'push_notification_service.dart';

/// Manager que integra PushNotificationService con el backend
///
/// Responsabilidades:
/// - Obtener token FCM y enviarlo al backend automáticamente
/// - Escuchar cambios de token y actualizarlos en el backend
/// - Eliminar token del backend en logout
class FcmManager {
  final FcmRepository _fcmRepository;

  FcmManager({required FcmRepository fcmRepository})
      : _fcmRepository = fcmRepository;

  /// Registra el token FCM en el backend después del login
  Future<void> registerTokenWithBackend() async {
    try {
      // Obtener token FCM
      final fcmToken = await PushNotificationService.getToken();

      if (fcmToken == null) {
        _debugLog('No se pudo obtener token FCM');
        return;
      }

      // Obtener información del dispositivo
      final deviceInfo = await _getDeviceInfo();

      // Enviar al backend
      final result = await _fcmRepository.registerToken(
        fcmToken: fcmToken,
        deviceType: deviceInfo['deviceType']!,
        deviceName: deviceInfo['deviceName'],
        deviceId: deviceInfo['deviceId'],
      );

      result.fold(
        (failure) => _debugLog('Error registrando token: ${failure.message}'),
        (_) => _debugLog('Token FCM registrado exitosamente'),
      );
    } catch (e) {
      _debugLog('Error en registerTokenWithBackend: $e');
    }
  }

  /// Escucha cambios de token y los actualiza en el backend
  void listenToTokenRefresh() {
    PushNotificationService.onTokenRefresh.listen((newToken) async {
      _debugLog('Token refrescado, actualizando en backend...');

      final deviceInfo = await _getDeviceInfo();

      final result = await _fcmRepository.registerToken(
        fcmToken: newToken,
        deviceType: deviceInfo['deviceType']!,
        deviceName: deviceInfo['deviceName'],
        deviceId: deviceInfo['deviceId'],
      );

      result.fold(
        (failure) => _debugLog('Error actualizando token: ${failure.message}'),
        (_) => _debugLog('Token actualizado exitosamente'),
      );
    });
  }

  /// Elimina el token del backend (llamar en logout)
  Future<void> removeTokenFromBackend() async {
    try {
      final fcmToken = await PushNotificationService.getToken();

      if (fcmToken == null) {
        _debugLog('No hay token para eliminar');
        return;
      }

      // Eliminar del backend
      await _fcmRepository.removeToken(fcmToken);

      // Eliminar localmente
      await PushNotificationService.deleteToken();

      _debugLog('Token eliminado del backend y localmente');
    } catch (e) {
      _debugLog('Error eliminando token: $e');
    }
  }

  /// Obtiene información del dispositivo
  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return {
          'deviceType': 'android',
          'deviceName': '${androidInfo.brand} ${androidInfo.model}',
          'deviceId': androidInfo.id,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return {
          'deviceType': 'ios',
          'deviceName': '${iosInfo.name} ${iosInfo.model}',
          'deviceId': iosInfo.identifierForVendor ?? 'unknown',
        };
      } else {
        return {
          'deviceType': 'web',
          'deviceName': 'Web Browser',
          'deviceId': 'web',
        };
      }
    } catch (e) {
      _debugLog('Error obteniendo info del dispositivo: $e');
      return {
        'deviceType': Platform.isAndroid ? 'android' : 'ios',
        'deviceName': 'Unknown Device',
      };
    }
  }

  /// Log interno solo en modo debug
  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[FCMManager] $message');
    }
  }
}
