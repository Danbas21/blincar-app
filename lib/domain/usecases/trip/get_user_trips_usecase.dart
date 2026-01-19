// lib/domain/usecases/trip/get_user_trips_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/trip/trip_entity.dart';
import '../../repositories/trip_repository.dart';

/// Use Case para obtener todos los viajes de un usuario
///
/// Útil para:
/// - Mostrar historial de viajes
/// - Página "Mis Viajes"
/// - Estadísticas del usuario
///
/// Los viajes se retornan ordenados por fecha (más reciente primero)
class GetUserTripsUseCase implements UseCase<List<TripEntity>, String> {
  final TripRepository repository;

  GetUserTripsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TripEntity>>> call(String userId) async {
    if (userId.isEmpty) {
      return Left(ValidationFailure('User ID no puede estar vacío'));
    }

    return await repository.getUserTrips(userId);
  }
}
