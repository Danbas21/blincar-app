// lib/domain/entities/active_trip.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/coordinates.dart';

part 'active_trip.freezed.dart';
part 'active_trip.g.dart';

/// Estados de un viaje activo
enum ActiveTripStatus {
  confirmed, // Confirmado, esperando inicio
  ongoing, // En curso (driver presiono "Iniciar")
  completed, // Completado
  cancelled, // Cancelado
}

/// Entidad que representa un viaje activo en Blincar
///
/// Esta entidad se crea cuando el usuario confirma y paga.
/// Incluye tracking GPS en tiempo real, URL del video streaming,
/// y toda la informacion del viaje en curso.
///
/// Responsabilidades (SOLID - Single Responsibility):
/// - Almacenar datos del viaje en curso
/// - Proveer ubicacion en tiempo real
/// - Gestionar el ciclo de vida del viaje (confirmed -> ongoing -> completed)
@freezed
class ActiveTrip with _$ActiveTrip {
  const ActiveTrip._();

  const factory ActiveTrip({
    required String id,
    required String requestId, // Referencia a la TripRequest original
    required String userId,
    required String driverId,
    required String vehicleId,
    required String monitorId, // Monitor que asigno el viaje
    required ActiveTripStatus status,

    // Datos en tiempo real
    Coordinates? currentLocation,
    double? currentSpeed, // km/h
    double? currentHeading, // Grados (0-360)

    // Video y grabacion
    String? videoStreamUrl, // URL RTSP de la camara Hikvision
    @Default(false) bool recordingStarted,

    // Contactos de emergencia
    @Default(false) bool emergencyContactNotified,

    // Tiempos
    DateTime? startTime, // Cuando driver presiona "Iniciar"
    DateTime? estimatedEndTime,
    DateTime? completedAt,

    // Precio y calificacion
    required double actualPrice,
    int? serviceRating, // 1-5 estrellas (null hasta que usuario califique)
    String? serviceFeedback,
  }) = _ActiveTrip;

  factory ActiveTrip.fromJson(Map<String, dynamic> json) =>
      _$ActiveTripFromJson(json);

  /// Verifica si el viaje esta en curso
  bool get isOngoing => status == ActiveTripStatus.ongoing;

  /// Verifica si el viaje esta completado
  bool get isCompleted => status == ActiveTripStatus.completed;

  /// Verifica si el viaje fue cancelado
  bool get isCancelled => status == ActiveTripStatus.cancelled;

  /// Verifica si el viaje puede ser calificado
  bool get canBeRated => isCompleted && serviceRating == null;

  /// Duracion del viaje en minutos (si esta completado)
  int? get durationMinutes {
    if (startTime == null || completedAt == null) return null;
    return completedAt!.difference(startTime!).inMinutes;
  }

  /// Rating formateado como estrellas
  String get ratingStars {
    if (serviceRating == null) return 'Sin calificar';
    return List.filled(serviceRating!, '★').join() +
        List.filled(5 - serviceRating!, '☆').join();
  }
}
