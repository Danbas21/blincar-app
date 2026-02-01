// lib/core/services/storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../security/secure_storage_service.dart';

/// Servicio unificado de almacenamiento
///
/// Combina:
/// - SecureStorageService: Para datos SENSIBLES (tokens, IDs)
/// - SharedPreferences: Para datos NO sensibles (preferencias, locale)
///
/// Esta separación garantiza que datos sensibles estén encriptados
/// mientras que datos de preferencias mantengan acceso rápido.
class StorageService {
  final SharedPreferences _prefs;
  final SecureStorageService _secureStorage;

  // Keys para datos NO sensibles (SharedPreferences)
  static const String _userRoleKey = 'user_role';
  static const String _localeKey = 'app_locale';
  static const String _regionKey = 'user_region';
  static const String _activeTripIdKey = 'active_trip_id';
  static const String _onboardingCompleteKey = 'onboarding_complete';

  // Keys legacy (para migración)
  static const String _legacyTokenKey = 'auth_token';
  static const String _legacyUserIdKey = 'user_id';

  StorageService(this._prefs, this._secureStorage);

  // ========================================
  // INICIALIZACIÓN Y MIGRACIÓN
  // ========================================

  /// Inicializa el servicio y migra datos legacy si es necesario
  Future<void> initialize() async {
    await _migrateToSecureStorage();
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Obtiene un int (null si no existe)
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Migra datos sensibles de SharedPreferences a SecureStorage
  Future<void> _migrateToSecureStorage() async {
    // Obtener datos legacy
    final legacyToken = _prefs.getString(_legacyTokenKey);
    final legacyUserId = _prefs.getString(_legacyUserIdKey);

    // Migrar a almacenamiento seguro
    await _secureStorage.migrateFromSharedPreferences(
      legacyToken: legacyToken,
      legacyUserId: legacyUserId,
    );

    // Limpiar datos legacy después de migración exitosa
    if (legacyToken != null) {
      await _prefs.remove(_legacyTokenKey);
    }
    if (legacyUserId != null) {
      await _prefs.remove(_legacyUserIdKey);
    }
  }

  // ========================================
  // AUTH METHODS (DATOS SENSIBLES - SecureStorage)
  // ========================================

  /// Guarda datos de autenticación de forma segura
  Future<void> saveAuthData({
    required String token,
    required String userId,
    required String userRole,
  }) async {
    // Datos sensibles → SecureStorage
    await Future.wait([
      _secureStorage.saveAuthToken(token),
      _secureStorage.saveUserId(userId),
    ]);

    // Rol no es tan sensible → SharedPreferences
    await _prefs.setString(_userRoleKey, userRole);
  }

  /// Obtiene el token de autenticación (async por SecureStorage)
  Future<String?> getTokenAsync() async {
    return await _secureStorage.getAuthToken();
  }

  /// Obtiene el token de forma síncrona (para compatibilidad)
  /// NOTA: Retorna null si no hay cache, usar getTokenAsync() preferentemente
  String? getToken() {
    // Para compatibilidad con código existente que espera sync
    // En el futuro, todo el código debería usar getTokenAsync()
    return null; // Forzar uso de async
  }

  /// Obtiene el User ID (async por SecureStorage)
  Future<String?> getUserIdAsync() async {
    return await _secureStorage.getUserId();
  }

  /// Obtiene el User ID de forma síncrona (para compatibilidad)
  String? getUserId() {
    return null; // Forzar uso de async
  }

  /// Obtiene el rol del usuario
  String? getUserRole() => _prefs.getString(_userRoleKey);

  /// Limpia todos los datos de autenticación
  Future<void> clearAuthData() async {
    await Future.wait([
      _secureStorage.clearAllSecureData(),
      _prefs.remove(_userRoleKey),
    ]);
  }

  /// Verifica si el usuario está logueado
  Future<bool> isLoggedInAsync() async {
    final token = await getTokenAsync();
    return token != null && token.isNotEmpty;
  }

  /// Verifica login de forma síncrona (legacy)
  bool isLoggedIn() {
    // Para compatibilidad - verificar rol como proxy
    return getUserRole() != null;
  }

  // ========================================
  // LOCALE METHODS (NO SENSIBLE - SharedPreferences)
  // ========================================

  Future<void> saveLocale(String locale) async {
    await _prefs.setString(_localeKey, locale);
  }

  String? getLocale() => _prefs.getString(_localeKey);

  // ========================================
  // REGION METHODS (NO SENSIBLE - SharedPreferences)
  // ========================================

  Future<void> saveRegion(String region) async {
    await _prefs.setString(_regionKey, region);
  }

  String? getRegion() => _prefs.getString(_regionKey);

  // ========================================
  // ACTIVE TRIP METHODS (NO SENSIBLE - SharedPreferences)
  // ========================================

  Future<void> saveActiveTripId(String tripId) async {
    await _prefs.setString(_activeTripIdKey, tripId);
  }

  String? getActiveTripId() => _prefs.getString(_activeTripIdKey);

  Future<void> clearActiveTripId() async {
    await _prefs.remove(_activeTripIdKey);
  }

  bool hasActiveTrip() => getActiveTripId() != null;

  // ========================================
  // ONBOARDING (NO SENSIBLE - SharedPreferences)
  // ========================================

  Future<void> setOnboardingComplete(bool complete) async {
    await _prefs.setBool(_onboardingCompleteKey, complete);
  }

  bool isOnboardingComplete() =>
      _prefs.getBool(_onboardingCompleteKey) ?? false;

  // ========================================
  // STRIPE (SENSIBLE - SecureStorage)
  // ========================================

  Future<void> saveStripeCustomerId(String customerId) async {
    await _secureStorage.saveStripeCustomerId(customerId);
  }

  Future<String?> getStripeCustomerId() async {
    return await _secureStorage.getStripeCustomerId();
  }

  // ========================================
  // GENERIC METHODS (NO SENSIBLE - SharedPreferences)
  // ========================================

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // ========================================
  // SECURE GENERIC METHODS (SENSIBLE - SecureStorage)
  // ========================================

  /// Guarda un valor de forma segura (para datos sensibles custom)
  Future<void> setSecureString(String key, String value) async {
    await _secureStorage.write(key, value);
  }

  /// Lee un valor seguro
  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key);
  }

  /// Elimina un valor seguro
  Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key);
  }

  // ========================================
  // ACCESO DIRECTO A SECURE STORAGE
  // ========================================

  /// Proporciona acceso directo a SecureStorageService
  /// Usar solo cuando se necesite control fino sobre almacenamiento seguro
  SecureStorageService get secureStorage => _secureStorage;
}
