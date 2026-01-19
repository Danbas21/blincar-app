// lib/domain/entities/trip/trip_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'route_entity.dart';

part 'trip_entity.freezed.dart';
part 'trip_entity.g.dart';

/// Entidad de viaje
///
/// Representa una solicitud de viaje completa desde que se solicita
/// hasta que se completa
@freezed
class TripEntity with _$TripEntity {
  const TripEntity._(); // Constructor privado para métodos custom

  const factory TripEntity({
    required String id,
    required String userId,
    required String userName,
    required String userPhone,
    required RouteEntity route,
    required String serviceType,
    required double totalPrice,
    required TripStatus status,
    required DateTime requestedAt,
    // Datos del conductor (cuando se asigna)
    String? driverId,
    String? driverName,
    String? driverPhone,
    String? vehicleId,
    String? vehiclePlate,
    // Timestamps
    DateTime? assignedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    // Video session
    String? videoSessionId,
  }) = _TripEntity;

  factory TripEntity.fromJson(Map<String, dynamic> json) =>
      _$TripEntityFromJson(json);

  /// Duración del viaje (si está completado)
  Duration? get tripDuration {
    if (startedAt != null && completedAt != null) {
      return completedAt!.difference(startedAt!);
    }
    return null;
  }

  /// Tiempo esperando asignación
  Duration? get waitingDuration {
    if (assignedAt != null) {
      return assignedAt!.difference(requestedAt);
    }
    return null;
  }

  /// Si el viaje está activo (en progreso)
  bool get isActive => status == TripStatus.inProgress;

  /// Si el viaje está pendiente de asignación
  bool get isPending => status == TripStatus.pending;

  /// Si el viaje está completo
  bool get isCompleted => status == TripStatus.completed;

  /// Método custom para toMap (para Firebase Realtime Database)
  /// Nota: Freezed genera toJson(), pero necesitamos un formato específico para Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'routeId': route.id,
      'routeName': route.name,
      'originLat': route.origin.latitude,
      'originLng': route.origin.longitude,
      'originName': route.origin.name,
      'originAddress': route.origin.address,
      'destinationLat': route.destination.latitude,
      'destinationLng': route.destination.longitude,
      'destinationName': route.destination.name,
      'destinationAddress': route.destination.address,
      // Objeto route completo para que las apps lo puedan leer fácilmente
      'route': {
        'origin': {
          'name': route.origin.name,
          'address': route.origin.address,
          'latitude': route.origin.latitude,
          'longitude': route.origin.longitude,
        },
        'destination': {
          'name': route.destination.name,
          'address': route.destination.address,
          'latitude': route.destination.latitude,
          'longitude': route.destination.longitude,
        },
        'distanceKm': route.distanceKm,
        'estimatedDurationMinutes': route.estimatedDurationMinutes,
      },
      'serviceType': serviceType,
      'totalPrice': totalPrice,
      'status': status.name,
      'requestedAt': requestedAt.toIso8601String(),
      'driverId': driverId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'vehicleId': vehicleId,
      'vehiclePlate': vehiclePlate,
      'assignedAt': assignedAt?.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'videoSessionId': videoSessionId,
    };
  }
}

/// Estados de un viaje
enum TripStatus {
  pending, // Pendiente de asignación
  assigned, // Asignado a conductor
  inProgress, // En progreso
  completed, // Completado
  cancelled, // Cancelado
}

extension TripStatusX on TripStatus {
  String get displayName {
    switch (this) {
      case TripStatus.pending:
        return 'Esperando asignación';
      case TripStatus.assigned:
        return 'Asignado';
      case TripStatus.inProgress:
        return 'En progreso';
      case TripStatus.completed:
        return 'Completado';
      case TripStatus.cancelled:
        return 'Cancelado';
    }
  }

  String get description {
    switch (this) {
      case TripStatus.pending:
        return 'Un operador asignará un conductor pronto';
      case TripStatus.assigned:
        return 'Tu conductor está en camino';
      case TripStatus.inProgress:
        return 'Viaje en progreso';
      case TripStatus.completed:
        return 'Viaje completado exitosamente';
      case TripStatus.cancelled:
        return 'Viaje cancelado';
    }
  }
}
