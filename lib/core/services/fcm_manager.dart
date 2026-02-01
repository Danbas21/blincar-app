// lib/core/services/fcm_manager.dart

import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  StreamSubscription<String>? _tokenRefreshSubscription;

  FcmManager({required FcmRepository fcmRepository})
      : _fcmRepository = fcmRepository;

  /// Registra el token FCM en el backend y Firebase después del login
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

      // También guardar en Firebase Realtime Database para Cloud Functions
      await _saveTokenToFirebase(fcmToken);
    } catch (e) {
      _debugLog('Error en registerTokenWithBackend: $e');
    }
  }

  /// Guarda el token FCM en Firebase Realtime Database
  /// Las Cloud Functions buscan el token aquí para enviar notificaciones
  Future<void> _saveTokenToFirebase(String fcmToken) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _debugLog('No hay usuario autenticado para guardar token en Firebase');
        return;
      }

      final database = FirebaseDatabase.instance;

      // Guardar en blincar/users/{userId}/fcmToken
      await database.ref('blincar/users/${user.uid}/fcmToken').set(fcmToken);

      // También guardar en blincar/fcm_tokens para búsqueda inversa
      await database.ref('blincar/fcm_tokens/${user.uid}').set({
        'token': fcmToken,
        'userId': user.uid,
        'updatedAt': ServerValue.timestamp,
        'platform': Platform.isAndroid ? 'android' : 'ios',
      });

      _debugLog('Token FCM guardado en Firebase para usuario ${user.uid}');
    } catch (e) {
      _debugLog('Error guardando token en Firebase: $e');
    }
  }

  /// Escucha cambios de token y los actualiza en el backend y Firebase
  void listenToTokenRefresh() {
    // Cancelar subscription anterior si existe
    _tokenRefreshSubscription?.cancel();

    _tokenRefreshSubscription = PushNotificationService.onTokenRefresh.listen(
      (newToken) async {
        _debugLog('Token refrescado, actualizando en backend...');

        try {
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

          // También actualizar en Firebase
          await _saveTokenToFirebase(newToken);
        } catch (e) {
          _debugLog('Error en listener de token refresh: $e');
        }
      },
      onError: (error) {
        _debugLog('Error en stream de token refresh: $error');
      },
    );
  }

  /// Elimina el token del backend y Firebase (llamar en logout)
  Future<void> removeTokenFromBackend() async {
    try {
      final fcmToken = await PushNotificationService.getToken();
      final user = FirebaseAuth.instance.currentUser;

      if (fcmToken == null) {
        _debugLog('No hay token para eliminar');
        return;
      }

      // Eliminar del backend
      await _fcmRepository.removeToken(fcmToken);

      // Eliminar de Firebase Realtime Database
      if (user != null) {
        final database = FirebaseDatabase.instance;
        await database.ref('blincar/users/${user.uid}/fcmToken').remove();
        await database.ref('blincar/fcm_tokens/${user.uid}').remove();
        _debugLog('Token eliminado de Firebase');
      }

      // Eliminar localmente
      await PushNotificationService.deleteToken();

      _debugLog('Token eliminado del backend, Firebase y localmente');
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

  /// Limpia recursos (llamar antes de destruir el manager)
  void dispose() {
    _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = null;
    _debugLog('FcmManager disposed');
  }
}
