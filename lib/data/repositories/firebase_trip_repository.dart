// lib/data/repositories/firebase_trip_repository.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repositories/trip_repository.dart';
import '../../domain/entities/trip/trip_entity.dart';
import '../../domain/entities/trip/route_entity.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/routes_data.dart';

/// Implementación de TripRepository con Firebase Realtime Database
///
/// Estructura en Firebase:
/// /blincar
///   /trips
///     /{tripId}
///       - id, userId, routeId, status, etc.
///   /tripRequests (índice para búsquedas rápidas)
///     /pending/{tripId}: true
///     /active/{tripId}: true
///   /userTrips (índice por usuario)
///     /{userId}/{tripId}: true
class FirebaseTripRepository implements TripRepository {
  final FirebaseDatabase _database;

  FirebaseTripRepository({
    FirebaseDatabase? database,
  }) : _database = database ?? FirebaseDatabase.instance;

  @override
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
  }) async {
    try {
      RouteEntity route;
      double finalPrice = totalPrice;

      // Verificar si es viaje personalizado (viaje rapido)
      final isCustomTrip = routeId.startsWith('custom_');

      if (isCustomTrip) {
        // Validar que se proporcionaron los datos de ubicacion
        if (originAddress == null ||
            originLat == null ||
            originLng == null ||
            destinationAddress == null ||
            destinationLat == null ||
            destinationLng == null) {
          return Left(TripFailure(
              'Datos de ubicación incompletos para viaje personalizado'));
        }

        // Calcular precio basado en tiempo: 50 MXN por cada 10 minutos
        // Si se proporciona estimatedDurationMinutes, usar ese valor
        // De lo contrario, usar el totalPrice proporcionado
        if (estimatedDurationMinutes != null && estimatedDurationMinutes > 0) {
          // Calcular: (duracion / 10) * 50 = duracion * 5
          final baseTimePrice = (estimatedDurationMinutes / 10).ceil() * 1.0;
          finalPrice = baseTimePrice;
        }

        // Crear ruta personalizada
        route = RouteEntity(
          id: routeId,
          name: 'Viaje Personalizado',
          origin: LocationPoint(
            name: 'Origen',
            address: originAddress,
            latitude: originLat,
            longitude: originLng,
          ),
          destination: LocationPoint(
            name: 'Destino',
            address: destinationAddress,
            latitude: destinationLat,
            longitude: destinationLng,
          ),
          distanceKm: 0, // Se calculara despues si es necesario
          estimatedDurationMinutes: estimatedDurationMinutes ?? 0,
          basePrice: finalPrice,
          category: RouteCategory.custom,
        );
      } else {
        // Viaje con ruta predefinida
        final predefinedRoute = RoutesData.getRouteById(routeId);
        if (predefinedRoute == null) {
          return Left(TripFailure('Ruta no encontrada'));
        }
        route = predefinedRoute;
      }

      // Generar ID único
      final tripId = _database.ref('blincar/trips').push().key;
      if (tripId == null) {
        return Left(TripFailure('Error generando ID de viaje'));
      }

      // Crear trip entity
      final trip = TripEntity(
        id: tripId,
        userId: userId,
        userName: userName,
        userPhone: userPhone,
        route: route,
        serviceType: serviceType,
        totalPrice: finalPrice,
        status: TripStatus.pending,
        requestedAt: DateTime.now(),
      );

      // Guardar en Firebase
      await _database.ref('blincar/trips/$tripId').set(trip.toMap());

      // Agregar a índice de pendientes
      await _database.ref('blincar/tripRequests/pending/$tripId').set(true);

      // Agregar a índice de usuario
      await _database.ref('blincar/userTrips/$userId/$tripId').set(true);

      return Right(trip);
    } catch (e) {
      return Left(TripFailure('Error creando viaje: $e'));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> getTripById(String tripId) async {
    try {
      final snapshot = await _database.ref('blincar/trips/$tripId').get();

      if (!snapshot.exists) {
        return Left(TripFailure('Viaje no encontrado'));
      }

      final trip = _tripFromSnapshot(snapshot);
      return Right(trip);
    } catch (e) {
      return Left(TripFailure('Error obteniendo viaje: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TripEntity>>> getUserTrips(String userId) async {
    try {
      // Obtener IDs de trips del usuario
      final tripsSnapshot =
          await _database.ref('blincar/userTrips/$userId').get();

      if (!tripsSnapshot.exists) {
        return const Right([]);
      }

      final tripIds = (tripsSnapshot.value as Map).keys.toList();
      final trips = <TripEntity>[];

      // Obtener cada trip
      for (final tripId in tripIds) {
        final tripSnapshot = await _database.ref('blincar/trips/$tripId').get();
        if (tripSnapshot.exists) {
          trips.add(_tripFromSnapshot(tripSnapshot));
        }
      }

      // Ordenar por fecha más reciente
      trips.sort((a, b) => b.requestedAt.compareTo(a.requestedAt));

      return Right(trips);
    } catch (e) {
      return Left(TripFailure('Error obteniendo viajes: $e'));
    }
  }

  @override
  Future<Either<Failure, TripEntity?>> getUserActiveTrip(String userId) async {
    try {
      final tripsResult = await getUserTrips(userId);

      return tripsResult.fold(
        (failure) => Left(failure),
        (trips) {
          // Buscar viaje activo (pending, assigned, o inProgress)
          final activeTrip = trips.firstWhere(
            (trip) =>
                trip.status == TripStatus.pending ||
                trip.status == TripStatus.assigned ||
                trip.status == TripStatus.inProgress,
            orElse: () => trips.first,
          );

          return Right(activeTrip);
        },
      );
    } catch (e) {
      return Right(null); // No hay viaje activo
    }
  }

  @override
  Stream<Either<Failure, TripEntity>> watchTrip(String tripId) {
    try {
      return _database.ref('blincar/trips/$tripId').onValue.map((event) {
        if (!event.snapshot.exists) {
          return Left(TripFailure('Viaje no encontrado'));
        }
        return Right(_tripFromSnapshot(event.snapshot));
      });
    } catch (e) {
      return Stream.value(Left(TripFailure('Error escuchando viaje: $e')));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> assignDriver({
    required String tripId,
    required String driverId,
    required String driverName,
    required String driverPhone,
    required String vehicleId,
    required String vehiclePlate,
  }) async {
    try {
      final tripResult = await getTripById(tripId);

      return await tripResult.fold(
        (failure) async => Left(failure),
        (trip) async {
          final updatedTrip = trip.copyWith(
            status: TripStatus.assigned,
            driverId: driverId,
            driverName: driverName,
            driverPhone: driverPhone,
            vehicleId: vehicleId,
            vehiclePlate: vehiclePlate,
            assignedAt: DateTime.now(),
          );

          await _database
              .ref('blincar/trips/$tripId')
              .update(updatedTrip.toMap());

          // Quitar de pendientes, agregar a activos
          await _database.ref('blincar/tripRequests/pending/$tripId').remove();
          await _database.ref('blincar/tripRequests/active/$tripId').set(true);

          return Right(updatedTrip);
        },
      );
    } catch (e) {
      return Left(TripFailure('Error asignando conductor: $e'));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> startTrip({
    required String tripId,
    required String videoSessionId,
  }) async {
    try {
      final tripResult = await getTripById(tripId);

      return await tripResult.fold(
        (failure) async => Left(failure),
        (trip) async {
          final updatedTrip = trip.copyWith(
            status: TripStatus.inProgress,
            startedAt: DateTime.now(),
            videoSessionId: videoSessionId,
          );

          await _database
              .ref('blincar/trips/$tripId')
              .update(updatedTrip.toMap());

          return Right(updatedTrip);
        },
      );
    } catch (e) {
      return Left(TripFailure('Error iniciando viaje: $e'));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> completeTrip({
    required String tripId,
  }) async {
    try {
      final tripResult = await getTripById(tripId);

      return await tripResult.fold(
        (failure) async => Left(failure),
        (trip) async {
          final updatedTrip = trip.copyWith(
            status: TripStatus.completed,
            completedAt: DateTime.now(),
          );

          await _database
              .ref('blincar/trips/$tripId')
              .update(updatedTrip.toMap());

          // Quitar de activos
          await _database.ref('blincar/tripRequests/active/$tripId').remove();

          return Right(updatedTrip);
        },
      );
    } catch (e) {
      return Left(TripFailure('Error completando viaje: $e'));
    }
  }

  @override
  Future<Either<Failure, TripEntity>> cancelTrip({
    required String tripId,
    required String reason,
  }) async {
    try {
      final tripResult = await getTripById(tripId);

      return await tripResult.fold(
        (failure) async => Left(failure),
        (trip) async {
          final updatedTrip = trip.copyWith(
            status: TripStatus.cancelled,
          );

          await _database
              .ref('blincar/trips/$tripId')
              .update(updatedTrip.toMap());

          // Quitar de pendientes/activos
          await _database.ref('blincar/tripRequests/pending/$tripId').remove();
          await _database.ref('blincar/tripRequests/active/$tripId').remove();

          return Right(updatedTrip);
        },
      );
    } catch (e) {
      return Left(TripFailure('Error cancelando viaje: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TripEntity>>> getPendingRequests() async {
    try {
      _log('getPendingRequests: Consultando blincar/tripRequests/pending...');
      final snapshot =
          await _database.ref('blincar/tripRequests/pending').get();

      _log('getPendingRequests: snapshot.exists = ${snapshot.exists}');

      if (!snapshot.exists) {
        _log('getPendingRequests: No hay datos pendientes');
        return const Right([]);
      }

      _log('getPendingRequests: snapshot.value = ${snapshot.value}');
      final tripIds = (snapshot.value as Map).keys.toList();
      _log('getPendingRequests: IDs encontrados: $tripIds');

      final trips = <TripEntity>[];

      for (final tripId in tripIds) {
        _log('getPendingRequests: Obteniendo trip $tripId...');
        final tripSnapshot = await _database.ref('blincar/trips/$tripId').get();
        if (tripSnapshot.exists) {
          try {
            final trip = _tripFromSnapshot(tripSnapshot);
            trips.add(trip);
            _log('getPendingRequests: Trip $tripId cargado OK');
          } catch (e) {
            _log('getPendingRequests: ERROR parseando trip $tripId: $e');
          }
        } else {
          _log('getPendingRequests: Trip $tripId NO existe en /trips');
        }
      }

      trips.sort((a, b) => a.requestedAt.compareTo(b.requestedAt));
      _log('getPendingRequests: Total trips cargados: ${trips.length}');

      return Right(trips);
    } catch (e) {
      _log('getPendingRequests: EXCEPCION: $e');
      return Left(TripFailure('Error obteniendo solicitudes: $e'));
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[FirebaseTripRepo] $message');
    }
  }

  @override
  Stream<Either<Failure, List<TripEntity>>> watchPendingRequests() {
    try {
      return _database
          .ref('blincar/tripRequests/pending')
          .onValue
          .asyncMap((event) async {
        if (!event.snapshot.exists) {
          return const Right(<TripEntity>[]);
        }

        final tripIds = (event.snapshot.value as Map).keys.toList();
        final trips = <TripEntity>[];

        for (final tripId in tripIds) {
          final tripSnapshot =
              await _database.ref('blincar/trips/$tripId').get();
          if (tripSnapshot.exists) {
            trips.add(_tripFromSnapshot(tripSnapshot));
          }
        }

        trips.sort((a, b) => a.requestedAt.compareTo(b.requestedAt));

        return Right(trips);
      });
    } catch (e) {
      return Stream.value(
          Left(TripFailure('Error escuchando solicitudes: $e')));
    }
  }

  @override
  Future<Either<Failure, List<TripEntity>>> getActiveTrips() async {
    try {
      final snapshot = await _database.ref('blincar/tripRequests/active').get();

      if (!snapshot.exists) {
        return const Right([]);
      }

      final tripIds = (snapshot.value as Map).keys.toList();
      final trips = <TripEntity>[];

      for (final tripId in tripIds) {
        final tripSnapshot = await _database.ref('blincar/trips/$tripId').get();
        if (tripSnapshot.exists) {
          trips.add(_tripFromSnapshot(tripSnapshot));
        }
      }

      return Right(trips);
    } catch (e) {
      return Left(TripFailure('Error obteniendo viajes activos: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<TripEntity>>> watchActiveTrips() {
    try {
      return _database
          .ref('blincar/tripRequests/active')
          .onValue
          .asyncMap((event) async {
        if (!event.snapshot.exists) {
          return const Right(<TripEntity>[]);
        }

        final tripIds = (event.snapshot.value as Map).keys.toList();
        final trips = <TripEntity>[];

        for (final tripId in tripIds) {
          final tripSnapshot =
              await _database.ref('blincar/trips/$tripId').get();
          if (tripSnapshot.exists) {
            trips.add(_tripFromSnapshot(tripSnapshot));
          }
        }

        return Right(trips);
      });
    } catch (e) {
      return Stream.value(
          Left(TripFailure('Error escuchando viajes activos: $e')));
    }
  }

  // Helper: Convertir snapshot a TripEntity
  TripEntity _tripFromSnapshot(DataSnapshot snapshot) {
    final data = Map<String, dynamic>.from(snapshot.value as Map);

    // Reconstruir ruta
    final route = RoutesData.getRouteById(data['routeId'] as String) ??
        RouteEntity(
          id: data['routeId'] as String,
          name: data['routeName'] as String,
          origin: LocationPoint(
            name: data['originName'] as String,
            address: '',
            latitude: (data['originLat'] as num).toDouble(),
            longitude: (data['originLng'] as num).toDouble(),
          ),
          destination: LocationPoint(
            name: data['destinationName'] as String,
            address: '',
            latitude: (data['destinationLat'] as num).toDouble(),
            longitude: (data['destinationLng'] as num).toDouble(),
          ),
          distanceKm: 0,
          estimatedDurationMinutes: 0,
          basePrice: (data['totalPrice'] as num).toDouble(),
          category: RouteCategory.cityCenter,
        );

    return TripEntity(
      id: data['id'] as String,
      userId: data['userId'] as String,
      userName: data['userName'] as String,
      userPhone: data['userPhone'] as String,
      route: route,
      serviceType: data['serviceType'] as String,
      totalPrice: (data['totalPrice'] as num).toDouble(),
      status: _parseStatus(data['status'] as String),
      requestedAt: DateTime.parse(data['requestedAt'] as String),
      driverId: data['driverId'] as String?,
      driverName: data['driverName'] as String?,
      driverPhone: data['driverPhone'] as String?,
      vehicleId: data['vehicleId'] as String?,
      vehiclePlate: data['vehiclePlate'] as String?,
      assignedAt: data['assignedAt'] != null
          ? DateTime.parse(data['assignedAt'] as String)
          : null,
      startedAt: data['startedAt'] != null
          ? DateTime.parse(data['startedAt'] as String)
          : null,
      completedAt: data['completedAt'] != null
          ? DateTime.parse(data['completedAt'] as String)
          : null,
      videoSessionId: data['videoSessionId'] as String?,
    );
  }

  TripStatus _parseStatus(String status) {
    return TripStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => TripStatus.pending,
    );
  }
}

/// Failure específico de Trip
class TripFailure extends Failure {
  TripFailure(String message) : super(message);
}
