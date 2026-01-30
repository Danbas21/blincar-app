// lib/domain/repositories/fcm_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

/// Repository para manejar tokens FCM
abstract class FcmRepository {
  /// Registra el token FCM en el backend
  Future<Either<Failure, void>> registerToken({
    required String fcmToken,
    required String deviceType,
    String? deviceName,
    String? deviceId,
  });

  /// Elimina el token FCM del backend (logout)
  Future<Either<Failure, void>> removeToken(String fcmToken);

  /// Obtiene estadísticas de notificaciones del usuario
  Future<Either<Failure, Map<String, dynamic>>> getNotificationStats();
}
