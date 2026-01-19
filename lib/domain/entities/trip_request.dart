// lib/domain/entities/trip_request.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/location.dart';

part 'trip_request.freezed.dart';
part 'trip_request.g.dart';

/// Estados posibles de una solicitud de viaje
enum TripRequestStatus {
  pending, // Esperando asignacion del monitor
  assigned, // Monitor asigno conductor y vehiculo
  confirmed, // Usuario pago y confirmo
  cancelled, // Cancelada
}

/// Entidad que representa una solicitud de viaje en Blincar
///
/// Esta es la primera fase del flujo: el usuario crea una solicitud
/// que luego sera asignada por el monitor.
///
/// Flujo: pending -> assigned -> confirmed -> (se convierte en ActiveTrip)
@freezed
class TripRequest with _$TripRequest {
  const TripRequest._();

  const factory TripRequest({
    required String id,
    required String userId,
    required String userEmail,
    required String userName,
    required String servicePackageId,
    required String servicePackageName,
    required Location origin,
    required Location destination,
    required DateTime scheduledTime,
    required double estimatedDistance, // En kilometros
    required int estimatedDuration, // En minutos
    required double estimatedPrice, // En MXN
    required TripRequestStatus status,
    required DateTime createdAt,

    // Campos de asignacion (llenados por el Monitor)
    String? assignedDriverId,
    String? assignedVehicleId,
    String? assignedByMonitorId,
    DateTime? assignedAt,
  }) = _TripRequest;

  factory TripRequest.fromJson(Map<String, dynamic> json) =>
      _$TripRequestFromJson(json);

  /// Verifica si la solicitud esta pendiente
  bool get isPending => status == TripRequestStatus.pending;

  /// Verifica si la solicitud fue asignada
  bool get isAssigned => status == TripRequestStatus.assigned;

  /// Verifica si la solicitud fue confirmada
  bool get isConfirmed => status == TripRequestStatus.confirmed;

  /// Verifica si la solicitud fue cancelada
  bool get isCancelled => status == TripRequestStatus.cancelled;

  /// Verifica si tiene conductor y vehiculo asignado
  bool get hasAssignment =>
      assignedDriverId != null && assignedVehicleId != null;

  /// Precio formateado
  String get formattedPrice => '\$${estimatedPrice.toStringAsFixed(2)} MXN';

  /// Duracion formateada
  String get formattedDuration {
    if (estimatedDuration < 60) return '$estimatedDuration min';
    final hours = estimatedDuration ~/ 60;
    final mins = estimatedDuration % 60;
    return '${hours}h ${mins}min';
  }

  /// Distancia formateada
  String get formattedDistance => '${estimatedDistance.toStringAsFixed(1)} km';
}
