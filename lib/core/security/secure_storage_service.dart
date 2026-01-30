// lib/core/security/secure_storage_service.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

/// Servicio de almacenamiento seguro para datos sensibles
///
/// Usa flutter_secure_storage que almacena datos de forma encriptada:
/// - iOS: Keychain
/// - Android: EncryptedSharedPreferences / Keystore
///
/// IMPORTANTE: Usar SOLO para datos sensibles como tokens, claves API, etc.
/// Para datos no sensibles (preferencias, locale), usar SharedPreferences normal.
class SecureStorageService {
  late final FlutterSecureStorage _secureStorage;

  // Keys para datos sensibles
  static const String _authTokenKey = 'secure_auth_token';
  static const String _refreshTokenKey = 'secure_refresh_token';
  static const String _userIdKey = 'secure_user_id';
  static const String _stripeCustomerIdKey = 'secure_stripe_customer_id';

  SecureStorageService() {
    // Configuración de Android con EncryptedSharedPreferences
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'blincar_secure_prefs',
      preferencesKeyPrefix: 'blincar_',
    );

    // Configuración de iOS con Keychain
    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      accountName: 'com.blincar.app',
    );

    _secureStorage = const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );
  }

  // ========================================
  // AUTH TOKEN
  // ========================================

  /// Guarda el token de autenticación de forma segura
  Future<void> saveAuthToken(String token) async {
    try {
      await _secureStorage.write(key: _authTokenKey, value: token);
      debugPrint('🔐 Auth token guardado de forma segura');
    } catch (e) {
      debugPrint('❌ Error guardando auth token: $e');
      rethrow;
    }
  }

  /// Obtiene el token de autenticación
  Future<String?> getAuthToken() async {
    try {
      return await _secureStorage.read(key: _authTokenKey);
    } catch (e) {
      debugPrint('❌ Error leyendo auth token: $e');
      return null;
    }
  }

  /// Elimina el token de autenticación
  Future<void> deleteAuthToken() async {
    try {
      await _secureStorage.delete(key: _authTokenKey);
      debugPrint('🔐 Auth token eliminado');
    } catch (e) {
      debugPrint('❌ Error eliminando auth token: $e');
    }
  }

  // ========================================
  // REFRESH TOKEN
  // ========================================

  /// Guarda el refresh token de forma segura
  Future<void> saveRefreshToken(String token) async {
    try {
      await _secureStorage.write(key: _refreshTokenKey, value: token);
    } catch (e) {
      debugPrint('❌ Error guardando refresh token: $e');
      rethrow;
    }
  }

  /// Obtiene el refresh token
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      debugPrint('❌ Error leyendo refresh token: $e');
      return null;
    }
  }

  /// Elimina el refresh token
  Future<void> deleteRefreshToken() async {
    try {
      await _secureStorage.delete(key: _refreshTokenKey);
    } catch (e) {
      debugPrint('❌ Error eliminando refresh token: $e');
    }
  }

  // ========================================
  // USER ID (sensible para identificación)
  // ========================================

  /// Guarda el ID del usuario de forma segura
  Future<void> saveUserId(String userId) async {
    try {
      await _secureStorage.write(key: _userIdKey, value: userId);
    } catch (e) {
      debugPrint('❌ Error guardando user ID: $e');
      rethrow;
    }
  }

  /// Obtiene el ID del usuario
  Future<String?> getUserId() async {
    try {
      return await _secureStorage.read(key: _userIdKey);
    } catch (e) {
      debugPrint('❌ Error leyendo user ID: $e');
      return null;
    }
  }

  /// Elimina el ID del usuario
  Future<void> deleteUserId() async {
    try {
      await _secureStorage.delete(key: _userIdKey);
    } catch (e) {
      debugPrint('❌ Error eliminando user ID: $e');
    }
  }

  // ========================================
  // STRIPE CUSTOMER ID
  // ========================================

  /// Guarda el Stripe Customer ID de forma segura
  Future<void> saveStripeCustomerId(String customerId) async {
    try {
      await _secureStorage.write(key: _stripeCustomerIdKey, value: customerId);
    } catch (e) {
      debugPrint('❌ Error guardando Stripe customer ID: $e');
      rethrow;
    }
  }

  /// Obtiene el Stripe Customer ID
  Future<String?> getStripeCustomerId() async {
    try {
      return await _secureStorage.read(key: _stripeCustomerIdKey);
    } catch (e) {
      debugPrint('❌ Error leyendo Stripe customer ID: $e');
      return null;
    }
  }

  /// Elimina el Stripe Customer ID
  Future<void> deleteStripeCustomerId() async {
    try {
      await _secureStorage.delete(key: _stripeCustomerIdKey);
    } catch (e) {
      debugPrint('❌ Error eliminando Stripe customer ID: $e');
    }
  }

  // ========================================
  // MÉTODOS GENÉRICOS
  // ========================================

  /// Guarda un valor de forma segura
  Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('❌ Error escribiendo $key: $e');
      rethrow;
    }
  }

  /// Lee un valor seguro
  Future<String?> read(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      debugPrint('❌ Error leyendo $key: $e');
      return null;
    }
  }

  /// Elimina un valor seguro
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('❌ Error eliminando $key: $e');
    }
  }

  /// Verifica si existe un valor
  Future<bool> containsKey(String key) async {
    try {
      return await _secureStorage.containsKey(key: key);
    } catch (e) {
      return false;
    }
  }

  // ========================================
  // LIMPIEZA
  // ========================================

  /// Elimina TODOS los datos sensibles (para logout)
  Future<void> clearAllSecureData() async {
    try {
      await Future.wait([
        deleteAuthToken(),
        deleteRefreshToken(),
        deleteUserId(),
        deleteStripeCustomerId(),
      ]);
      debugPrint('🔐 Todos los datos sensibles eliminados');
    } catch (e) {
      debugPrint('❌ Error limpiando datos sensibles: $e');
    }
  }

  /// Elimina absolutamente todo el almacenamiento seguro
  /// CUIDADO: Solo usar en casos extremos (reset total de la app)
  Future<void> deleteAll() async {
    try {
      await _secureStorage.deleteAll();
      debugPrint('🔐 Almacenamiento seguro completamente limpiado');
    } catch (e) {
      debugPrint('❌ Error limpiando almacenamiento seguro: $e');
    }
  }

  // ========================================
  // MIGRACIÓN
  // ========================================

  /// Migra datos de SharedPreferences a SecureStorage
  ///
  /// Llama esto una vez al iniciar la app para migrar usuarios existentes
  Future<void> migrateFromSharedPreferences({
    String? legacyToken,
    String? legacyUserId,
  }) async {
    try {
      // Solo migrar si hay datos legacy y no hay datos nuevos
      if (legacyToken != null) {
        final existingToken = await getAuthToken();
        if (existingToken == null) {
          await saveAuthToken(legacyToken);
          debugPrint('🔄 Token migrado a almacenamiento seguro');
        }
      }

      if (legacyUserId != null) {
        final existingUserId = await getUserId();
        if (existingUserId == null) {
          await saveUserId(legacyUserId);
          debugPrint('🔄 User ID migrado a almacenamiento seguro');
        }
      }
    } catch (e) {
      debugPrint('❌ Error en migración: $e');
    }
  }
}
