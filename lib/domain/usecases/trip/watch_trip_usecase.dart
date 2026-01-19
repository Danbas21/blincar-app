// lib/domain/usecases/trip/watch_trip_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/trip/trip_entity.dart';
import '../../repositories/trip_repository.dart';

/// Use Case para escuchar cambios en tiempo real de un viaje
///
/// Este NO es un UseCase tradicional que retorna Future,
/// sino que retorna un Stream para actualizaciones en tiempo real.
///
/// Útil para:
/// - Pantalla de tracking (ver ubicación del conductor en vivo)
/// - Ver cuando el viaje cambia de estado (assigned → inProgress → completed)
/// - Notificar al usuario de actualizaciones automáticamente
///
/// Principio: Dependency Inversion
/// - El dominio define la necesidad de "escuchar" sin saber cómo Firebase lo implementa
class WatchTripUseCase {
  final TripRepository repository;

  WatchTripUseCase(this.repository);

  /// Escucha cambios en tiempo real de un viaje específico
  ///
  /// Retorna un Stream que emite cada vez que el viaje se actualiza en Firebase.
  /// El Stream permanece abierto hasta que se cancele la suscripción.
  Stream<Either<Failure, TripEntity>> call(String tripId) {
    if (tripId.isEmpty) {
      return Stream.value(
          Left(ValidationFailure('Trip ID no puede estar vacío')));
    }

    return repository.watchTrip(tripId);
  }
}
