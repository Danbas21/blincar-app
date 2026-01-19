// lib/domain/usecases/trip/get_user_active_trip_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/trip/trip_entity.dart';
import '../../repositories/trip_repository.dart';

/// Use Case para obtener el viaje activo de un usuario
///
/// Lógica de negocio:
/// - Un usuario solo puede tener UN viaje activo a la vez
/// - Viaje activo = pending, assigned, o inProgress
/// - Retorna null si no hay viaje activo
///
/// Útil para:
/// - Verificar si el usuario puede solicitar un nuevo viaje
/// - Mostrar estado del viaje actual en el home
/// - Redirigir al tracking si hay un viaje en progreso
class GetUserActiveTripUseCase implements UseCase<TripEntity?, String> {
  final TripRepository repository;

  GetUserActiveTripUseCase(this.repository);

  @override
  Future<Either<Failure, TripEntity?>> call(String userId) async {
    if (userId.isEmpty) {
      return Left(ValidationFailure('User ID no puede estar vacío'));
    }

    return await repository.getUserActiveTrip(userId);
  }
}
