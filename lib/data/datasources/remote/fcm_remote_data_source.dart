// lib/data/datasources/remote/fcm_remote_data_source.dart

import 'package:dio/dio.dart';
import '../../../core/errors/exceptions.dart';

/// Data source para manejar tokens FCM con el backend
abstract class FcmRemoteDataSource {
  /// Registra el token FCM en el backend
  Future<void> registerToken({
    required String fcmToken,
    required String deviceType,
    String? deviceName,
    String? deviceId,
  });

  /// Elimina el token FCM del backend (logout)
  Future<void> removeToken(String fcmToken);

  /// Obtiene estadísticas de notificaciones del usuario
  Future<Map<String, dynamic>> getNotificationStats();
}

class FcmRemoteDataSourceImpl implements FcmRemoteDataSource {
  final Dio dio;

  FcmRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> registerToken({
    required String fcmToken,
    required String deviceType,
    String? deviceName,
    String? deviceId,
  }) async {
    try {
      final response = await dio.post(
        '/fcm/register',
        data: {
          'fcmToken': fcmToken,
          'deviceType': deviceType,
          'deviceName': deviceName,
          'deviceId': deviceId,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
            message: 'Error registrando token FCM',
            statusCode: response.statusCode ?? 500);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException('No autenticado');
      }
      throw ServerException(
        message: e.message ?? 'Error de conexión',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> removeToken(String fcmToken) async {
    try {
      final response = await dio.post(
        '/fcm/remove',
        data: {'fcmToken': fcmToken},
      );

      if (response.statusCode != 200) {
        throw ServerException(
            message: 'Error eliminando token FCM',
            statusCode: response.statusCode ?? 500);
      }
    } on DioException catch (_) {
      // No lanzar error si falla al eliminar token (logout puede continuar)
      // Error silenciado intencionalmente
    } catch (_) {
      // Error silenciado intencionalmente
    }
  }

  @override
  Future<Map<String, dynamic>> getNotificationStats() async {
    try {
      final response = await dio.get('/fcm/stats');

      if (response.statusCode == 200 && response.data['stats'] != null) {
        return response.data['stats'] as Map<String, dynamic>;
      }

      throw ServerException(
          message: 'Error obteniendo estadísticas',
          statusCode: response.statusCode ?? 500);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException('No autenticado');
      }
      throw ServerException(
        message: e.message ?? 'Error de conexión',
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
