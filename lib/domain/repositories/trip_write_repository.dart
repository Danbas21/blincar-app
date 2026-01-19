// lib/domain/repositories/trip_write_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/trip/trip_entity.dart';
import '../../core/errors/failures.dart';

/// Interfaz para operaciones de escritura de viajes
///
/// Interface Segregation: Solo contiene metodos para modificar viajes.
/// Incluye operaciones de usuarios, conductores y operadores.
///
/// Principio: Los clientes no deben depender de interfaces que no usan.
abstract class TripWriteRepository {
  /// Crear una nueva solicitud de viaje
  ///
  /// Crea un viaje en estado 'requested'.
  /// El monitor lo vera y podra asignarlo.
  ///
  /// Para viajes personalizados (viaje rapido), proporciona:
  /// - [originAddress], [originLat], [originLng] para el origen
  /// - [destinationAddress], [destinationLat], [destinationLng] para el destino
  /// - [estimatedDurationMinutes] para calcular precio por tiempo
  ///
  /// Calculo de precio para viajes personalizados: 50 MXN por cada 10 minutos
  Future<Either<Failure, TripEntity>> createTripRequest({
    required String userId,
    required String userName,
    required String userPhone,
    required String routeId,
    required String serviceType,
    required double totalPrice,
    // Campos opcionales para viajes personalizados (viaje rapido)
    String? originAddress,
    double? originLat,
    double? originLng,
    String? destinationAddress,
    double? destinationLat,
    double? destinationLng,
    int? estimatedDurationMinutes,
  });

  /// Asignar conductor a un viaje (solo operador)
  ///
  /// Cambia el estado de 'requested' a 'confirmed'.
  /// Agrega la informacion del conductor y vehiculo.
  Future<Either<Failure, TripEntity>> assignDriver({
    required String tripId,
    required String driverId,
    required String driverName,
    required String driverPhone,
    required String vehicleId,
    required String vehiclePlate,
  });

  /// Iniciar viaje (conductor)
  ///
  /// Cambia el estado de 'confirmed' a 'in_progress'.
  /// Inicia la grabacion de video.
  Future<Either<Failure, TripEntity>> startTrip({
    required String tripId,
    required String videoSessionId,
  });

  /// Completar viaje (conductor)
  ///
  /// Cambia el estado a 'completed'.
  /// Finaliza la grabacion de video.
  Future<Either<Failure, TripEntity>> completeTrip({
    required String tripId,
  });

  /// Cancelar viaje
  ///
  /// Puede ser cancelado por usuario, conductor u operador.
  /// Cambia el estado a 'cancelled'.
  Future<Either<Failure, TripEntity>> cancelTrip({
    required String tripId,
    required String reason,
  });
}
