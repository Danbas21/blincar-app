import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userRoleKey = 'user_role';
  static const String _localeKey = 'app_locale';
  static const String _regionKey = 'user_region';
  static const String _activeTripIdKey = 'active_trip_id';

  // Auth methods
  Future<void> saveAuthData({
    required String token,
    required String userId,
    required String userRole,
  }) async {
    await Future.wait([
      _prefs.setString(_tokenKey, token),
      _prefs.setString(_userIdKey, userId),
      _prefs.setString(_userRoleKey, userRole),
    ]);
  }

  String? getToken() => _prefs.getString(_tokenKey);
  String? getUserId() => _prefs.getString(_userIdKey);
  String? getUserRole() => _prefs.getString(_userRoleKey);

  Future<void> clearAuthData() async {
    await Future.wait([
      _prefs.remove(_tokenKey),
      _prefs.remove(_userIdKey),
      _prefs.remove(_userRoleKey),
    ]);
  }

  bool isLoggedIn() => getToken() != null;

  // Locale methods
  Future<void> saveLocale(String locale) async {
    await _prefs.setString(_localeKey, locale);
  }

  String? getLocale() => _prefs.getString(_localeKey);

  // Region methods
  Future<void> saveRegion(String region) async {
    await _prefs.setString(_regionKey, region);
  }

  String? getRegion() => _prefs.getString(_regionKey);

  // Active Trip methods
  Future<void> saveActiveTripId(String tripId) async {
    await _prefs.setString(_activeTripIdKey, tripId);
  }

  String? getActiveTripId() => _prefs.getString(_activeTripIdKey);

  Future<void> clearActiveTripId() async {
    await _prefs.remove(_activeTripIdKey);
  }

  bool hasActiveTrip() => getActiveTripId() != null;

  // Generic methods
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) => _prefs.getBool(key);
}
