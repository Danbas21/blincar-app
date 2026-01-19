import '../../../core/services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login({
    required String email,
    required String password,
  });

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String emergencyContactName,
    required String emergencyContactPhone,
    String role = 'passenger',
  });

  Future<User> verifyToken(String token);

  Future<void> logout(String token);
}

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response['success'] == true && response['data'] != null) {
      final user = User.fromApiJson(response['data']['user']);
      final token = response['data']['token'] as String;

      return AuthResponse(user: user, token: token);
    } else {
      throw Exception(response['message'] ?? 'Error en login');
    }
  }

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String emergencyContactName,
    required String emergencyContactPhone,
    String role = 'passenger',
  }) async {
    final response = await apiService.post(
      ApiConstants.register,
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'emergencyContactName': emergencyContactName,
        'emergencyContactPhone': emergencyContactPhone,
        'role': role,
      },
    );

    if (response['success'] == true && response['data'] != null) {
      final user = User.fromApiJson(response['data']['user']);
      final token = response['data']['token'] as String;

      return AuthResponse(user: user, token: token);
    } else {
      throw Exception(response['message'] ?? 'Error en registro');
    }
  }

  @override
  Future<User> verifyToken(String token) async {
    final response = await apiService.get(
      ApiConstants.verify,
      token: token,
    );

    if (response['success'] == true && response['data'] != null) {
      return User.fromApiJson(response['data']['user']);
    } else {
      throw Exception(response['message'] ?? 'Token inválido');
    }
  }

  @override
  Future<void> logout(String token) async {
    await apiService.post(
      ApiConstants.logout,
      token: token,
    );
  }
}
