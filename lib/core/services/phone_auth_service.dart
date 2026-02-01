// lib/core/services/phone_auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

/// Resultado de verificación de teléfono
class PhoneVerificationResult {
  final bool success;
  final String? errorMessage;
  final String? verificationId;

  PhoneVerificationResult({
    required this.success,
    this.errorMessage,
    this.verificationId,
  });
}

/// Servicio para verificación de teléfono con SMS OTP
class PhoneAuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  PhoneAuthService({
    FirebaseAuth? firebaseAuth,
    FirebaseDatabase? firebaseDatabase,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  /// Envía código de verificación SMS al teléfono
  ///
  /// [phoneNumber] - Número de teléfono en formato internacional (ej: +52 555 123 4567)
  /// [onCodeSent] - Callback cuando el código fue enviado
  /// [onVerificationCompleted] - Callback cuando se completa automáticamente (solo Android)
  /// [onVerificationFailed] - Callback cuando falla la verificación
  Future<PhoneVerificationResult> sendVerificationCode({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    Function(PhoneAuthCredential credential)? onVerificationCompleted,
    Function(FirebaseAuthException exception)? onVerificationFailed,
  }) async {
    try {
      // Normalizar número de teléfono
      final normalizedPhone = _normalizePhoneNumber(phoneNumber);

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: normalizedPhone,
        timeout: const Duration(seconds: 60),

        // Auto-verificación en Android cuando el SMS es detectado
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (onVerificationCompleted != null) {
            onVerificationCompleted(credential);
          } else {
            // Auto-vincular credencial si no se proporciona callback
            await _linkPhoneCredential(credential);
          }
        },

        // Error en la verificación
        verificationFailed: (FirebaseAuthException exception) {
          if (onVerificationFailed != null) {
            onVerificationFailed(exception);
          }
        },

        // Código SMS enviado exitosamente
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId, resendToken);
        },

        // Timeout de auto-verificación
        codeAutoRetrievalTimeout: (String verificationId) {
          // No hacer nada, el usuario puede ingresar el código manualmente
        },
      );

      return PhoneVerificationResult(success: true);
    } on FirebaseAuthException catch (e) {
      return PhoneVerificationResult(
        success: false,
        errorMessage: _mapFirebaseError(e),
      );
    } catch (e) {
      return PhoneVerificationResult(
        success: false,
        errorMessage: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  /// Verifica el código SMS ingresado por el usuario
  ///
  /// [verificationId] - ID de verificación recibido en onCodeSent
  /// [smsCode] - Código de 6 dígitos ingresado por el usuario
  Future<PhoneVerificationResult> verifyCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      // Crear credencial con el código
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Vincular credencial al usuario actual
      await _linkPhoneCredential(credential);

      return PhoneVerificationResult(success: true);
    } on FirebaseAuthException catch (e) {
      return PhoneVerificationResult(
        success: false,
        errorMessage: _mapFirebaseError(e),
      );
    } catch (e) {
      return PhoneVerificationResult(
        success: false,
        errorMessage: 'Error al verificar código: ${e.toString()}',
      );
    }
  }

  /// Vincula la credencial de teléfono al usuario actual
  Future<void> _linkPhoneCredential(PhoneAuthCredential credential) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('No hay usuario autenticado');
    }

    // Vincular credencial
    await user.linkWithCredential(credential);

    // Actualizar estado de verificación en Realtime Database
    await _firebaseDatabase
        .ref('blincar/users/${user.uid}')
        .update({
      'phoneVerified': true,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  /// Normaliza el número de teléfono al formato internacional
  String _normalizePhoneNumber(String phoneNumber) {
    // Remover espacios, guiones y paréntesis
    String normalized = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Si no empieza con +, asumir código de país México (+52)
    if (!normalized.startsWith('+')) {
      if (normalized.startsWith('52')) {
        normalized = '+$normalized';
      } else if (normalized.length == 10) {
        // Número de 10 dígitos sin código de país
        normalized = '+52$normalized';
      }
    }

    return normalized;
  }

  /// Mapea errores de Firebase a mensajes amigables
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Número de teléfono inválido';
      case 'invalid-verification-code':
        return 'Código de verificación inválido';
      case 'invalid-verification-id':
        return 'ID de verificación inválido';
      case 'quota-exceeded':
        return 'Se excedió el límite de SMS. Intenta más tarde';
      case 'credential-already-in-use':
        return 'Este número ya está asociado a otra cuenta';
      case 'provider-already-linked':
        return 'El teléfono ya está verificado';
      case 'session-expired':
        return 'La sesión expiró. Solicita un nuevo código';
      default:
        return e.message ?? 'Error de autenticación';
    }
  }

  /// Verifica si el usuario actual tiene el teléfono verificado
  Future<bool> isPhoneVerified() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return false;

    // Verificar en Realtime Database
    final snapshot = await _firebaseDatabase
        .ref('blincar/users/${user.uid}/phoneVerified')
        .get();

    return snapshot.value == true;
  }

  /// Obtiene el número de teléfono verificado del usuario actual
  Future<String?> getVerifiedPhoneNumber() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return user.phoneNumber;
  }
}
