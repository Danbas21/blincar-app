// lib/core/services/auth_fcm_listener.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'fcm_manager.dart';

/// Listener que sincroniza el estado de autenticación con el registro de tokens FCM
///
/// Cuando el usuario:
/// - Inicia sesión → Registra token FCM en el backend
/// - Cierra sesión → Elimina token FCM del backend
class AuthFcmListener {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FcmManager _fcmManager;

  AuthFcmListener({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required FcmManager fcmManager,
  })  : _firebaseAuth = firebaseAuth,
        _fcmManager = fcmManager;

  /// Inicializa el listener de cambios de autenticación
  void initialize() {
    _debugLog('Inicializando listener de autenticación');

    // Escuchar cambios de estado de autenticación
    _firebaseAuth.authStateChanges().listen((firebase_auth.User? user) async {
      if (user != null) {
        // Usuario autenticado → Registrar token
        _debugLog('Usuario autenticado: ${user.uid}');
        await _handleUserSignedIn();
      } else {
        // Usuario desautenticado → No hacer nada
        // (el token se elimina explícitamente en logout)
        _debugLog('Usuario no autenticado');
      }
    });

    // Escuchar cambios de token FCM (refresh automático)
    _fcmManager.listenToTokenRefresh();
  }

  /// Maneja el evento de usuario autenticado
  Future<void> _handleUserSignedIn() async {
    try {
      _debugLog('Registrando token FCM en backend...');

      // Dar tiempo a que Firebase Auth se inicialice completamente
      await Future.delayed(const Duration(milliseconds: 500));

      // Registrar token en el backend
      await _fcmManager.registerTokenWithBackend();

      _debugLog('Token FCM registrado exitosamente');
    } catch (e) {
      _debugLog('Error registrando token FCM: $e');
    }
  }

  /// Maneja el evento de logout (llamar explícitamente desde AuthBloc)
  Future<void> handleUserSignedOut() async {
    try {
      _debugLog('Eliminando token FCM del backend...');
      await _fcmManager.removeTokenFromBackend();
      _debugLog('Token FCM eliminado exitosamente');
    } catch (e) {
      _debugLog('Error eliminando token FCM: $e');
    }
  }

  /// Log interno solo en modo debug
  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[AuthFcmListener] $message');
    }
  }
}
