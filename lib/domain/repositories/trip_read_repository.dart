// lib/domain/repositories/trip_read_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/trip/trip_entity.dart';
import '../../core/errors/failures.dart';

/// Interfaz para operaciones de lectura de viajes
///
/// Interface Segregation: Solo contiene metodos para consultar viajes.
/// Util para componentes que solo necesitan leer datos (pantallas de historial,
/// detalles de viaje, etc.)
///
/// Principio: Los clientes no deben depender de interfaces que no usan.
abstract class TripReadRepository {
  /// Obtener un viaje por ID
  ///
  /// Returns [TripEntity] si el viaje existe,
  /// [NotFoundFailure] si no se encuentra.
  Future<Either<Failure, TripEntity>> getTripById(String tripId);

  /// Obtener todos los viajes de un usuario
  ///
  /// Returns lista de [TripEntity] ordenados por fecha (mas recientes primero).
  /// Puede retornar lista vacia si el usuario no tiene viajes.
  Future<Either<Failure, List<TripEntity>>> getUserTrips(String userId);

  /// Obtener el viaje activo del usuario (si existe)
  ///
  /// Un viaje activo es uno que esta en estado:
  /// - requested
  /// - confirmed
  /// - in_progress
  ///
  /// Returns null si no hay viaje activo.
  Future<Either<Failure, TripEntity?>> getUserActiveTrip(String userId);

  /// Stream de un viaje especifico
  ///
  /// Emite actualizaciones cada vez que el viaje cambia.
  /// Util para pantallas de tracking en tiempo real.
  Stream<Either<Failure, TripEntity>> watchTrip(String tripId);
}
