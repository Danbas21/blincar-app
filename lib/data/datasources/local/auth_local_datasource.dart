import 'dart:convert';
import '../../../core/services/storage_service.dart';
import '../../../domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthData({
    required String token,
    required User user,
  });

  Future<String?> getCachedToken();

  Future<User?> getCachedUser();

  Future<void> clearAuthCache();

  Future<bool> isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService storageService;
  static const String _userKey = 'cached_user';

  AuthLocalDataSourceImpl(this.storageService);

  @override
  Future<void> cacheAuthData({
    required String token,
    required User user,
  }) async {
    await storageService.saveAuthData(
      token: token,
      userId: user.id,
      userRole: user.fullName,
    );

    // Guardar datos completos del usuario (JSON generado por Freezed)
    await storageService.setString(_userKey, _userToJson(user));
  }

  @override
  Future<String?> getCachedToken() async {
    return storageService.getToken();
  }

  @override
  Future<User?> getCachedUser() async {
    final userJson = storageService.getString(_userKey);
    if (userJson != null) {
      try {
        return _userFromJson(userJson);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> clearAuthCache() async {
    await storageService.clearAuthData();
    await storageService.setString(_userKey, '');
  }

  @override
  Future<bool> isLoggedIn() async {
    return storageService.isLoggedIn();
  }

  String _userToJson(User user) {
    // Usar toJson() generado por Freezed
    return jsonEncode(user.toJson());
  }

  User? _userFromJson(String json) {
    try {
      final Map<String, dynamic> map = jsonDecode(json);
      return User.fromJson(map);
    } catch (e) {
      return null;
    }
  }
}
