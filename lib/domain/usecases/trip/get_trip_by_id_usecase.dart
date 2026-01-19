// lib/domain/usecases/trip/get_trip_by_id_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/trip/trip_entity.dart';
import '../../repositories/trip_repository.dart';

/// Use Case para obtener un viaje específico por su ID
///
/// Útil para:
/// - Ver detalles de un viaje
/// - Verificar el estado de una solicitud
/// - Historial de viajes
class GetTripByIdUseCase implements UseCase<TripEntity, String> {
  final TripRepository repository;

  GetTripByIdUseCase(this.repository);

  @override
  Future<Either<Failure, TripEntity>> call(String tripId) async {
    if (tripId.isEmpty) {
      return Left(ValidationFailure('Trip ID no puede estar vacío'));
    }

    return await repository.getTripById(tripId);
  }
}
