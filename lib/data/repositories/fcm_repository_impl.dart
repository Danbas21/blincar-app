// lib/data/repositories/fcm_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../domain/repositories/fcm_repository.dart';
import '../datasources/remote/fcm_remote_data_source.dart';

class FcmRepositoryImpl implements FcmRepository {
  final FcmRemoteDataSource remoteDataSource;

  FcmRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> registerToken({
    required String fcmToken,
    required String deviceType,
    String? deviceName,
    String? deviceId,
  }) async {
    try {
      await remoteDataSource.registerToken(
        fcmToken: fcmToken,
        deviceType: deviceType,
        deviceName: deviceName,
        deviceId: deviceId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeToken(String fcmToken) async {
    try {
      await remoteDataSource.removeToken(fcmToken);
      return const Right(null);
    } catch (e) {
      // No fallar si no se puede eliminar el token
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getNotificationStats() async {
    try {
      final stats = await remoteDataSource.getNotificationStats();
      return Right(stats);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
