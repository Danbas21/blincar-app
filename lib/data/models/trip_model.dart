import '../../domain/entities/trip.dart';

class TripModel extends Trip {
  const TripModel({
    required super.id,
    required super.passengerId,
    super.driverId,
    super.serviceTypeId,
    required super.status,
    required super.originAddress,
    required super.destinationAddress,
    required super.originCoordinates,
    required super.destinationCoordinates,
    super.estimatedDistance,
    super.estimatedDuration,
    super.estimatedPrice,
    super.actualPrice,
    super.actualDistance,
    super.actualDuration,
    required super.requestedAt,
    super.acceptedAt,
    super.startedAt,
    super.completedAt,
    super.cancelledAt,
    super.cancelReason,
    super.cancelledBy,
    super.ratingByPassenger,
    super.ratingByDriver,
    super.commentByPassenger,
    super.commentByDriver,
    super.hasRecording,
    super.panicAlertsCount,
    super.routeChangesCount,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String,
      passengerId: json['passenger_id'] as String,
      driverId: json['driver_id'] as String?,
      serviceTypeId: json['service_type_id'] as String?,
      status: _parseTripStatus(json['status'] as String),
      originAddress: json['origin_address'] as String,
      destinationAddress: json['destination_address'] as String,
      originCoordinates: CoordinatesModel.fromJson(json['origin_coordinates']),
      destinationCoordinates:
          CoordinatesModel.fromJson(json['destination_coordinates']),
      estimatedDistance: json['estimated_distance'] != null
          ? double.parse(json['estimated_distance'].toString())
          : null,
      estimatedDuration: json['estimated_duration'] as int?,
      estimatedPrice: json['estimated_price'] != null
          ? double.parse(json['estimated_price'].toString())
          : null,
      actualPrice: json['actual_price'] != null
          ? double.parse(json['actual_price'].toString())
          : null,
      actualDistance: json['actual_distance'] != null
          ? double.parse(json['actual_distance'].toString())
          : null,
      actualDuration: json['actual_duration'] as int?,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'] as String)
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'] as String)
          : null,
      cancelReason: json['cancel_reason'] as String?,
      cancelledBy: json['cancelled_by'] as String?,
      ratingByPassenger: json['rating_by_passenger'] as int?,
      ratingByDriver: json['rating_by_driver'] as int?,
      commentByPassenger: json['comment_by_passenger'] as String?,
      commentByDriver: json['comment_by_driver'] as String?,
      hasRecording: json['has_recording'] as bool? ?? false,
      panicAlertsCount: json['panic_alerts_count'] as int? ?? 0,
      routeChangesCount: json['route_changes_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'passenger_id': passengerId,
      'driver_id': driverId,
      'service_type_id': serviceTypeId,
      'status': status.name,
      'origin_address': originAddress,
      'destination_address': destinationAddress,
      'origin_coordinates': (originCoordinates as CoordinatesModel).toJson(),
      'destination_coordinates':
          (destinationCoordinates as CoordinatesModel).toJson(),
      'estimated_distance': estimatedDistance,
      'estimated_duration': estimatedDuration,
      'estimated_price': estimatedPrice,
      'actual_price': actualPrice,
      'actual_distance': actualDistance,
      'actual_duration': actualDuration,
      'requested_at': requestedAt.toIso8601String(),
      'accepted_at': acceptedAt?.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'cancelled_at': cancelledAt?.toIso8601String(),
      'cancel_reason': cancelReason,
      'cancelled_by': cancelledBy,
      'rating_by_passenger': ratingByPassenger,
      'rating_by_driver': ratingByDriver,
      'comment_by_passenger': commentByPassenger,
      'comment_by_driver': commentByDriver,
      'has_recording': hasRecording,
      'panic_alerts_count': panicAlertsCount,
      'route_changes_count': routeChangesCount,
    };
  }

  static TripStatus _parseTripStatus(String status) {
    switch (status) {
      case 'pending':        // Firebase actual
      case 'requested':      // Legacy/display name
        return TripStatus.requested;
      case 'assigned':       // Firebase actual
      case 'accepted':       // Legacy/display name
        return TripStatus.accepted;
      case 'inProgress':     // Firebase actual (camelCase)
      case 'in_progress':    // Legacy (snake_case)
        return TripStatus.inProgress;
      case 'completed':
        return TripStatus.completed;
      case 'cancelled':
        return TripStatus.cancelled;
      default:
        return TripStatus.requested;
    }
  }
}

class CoordinatesModel extends Coordinates {
  const CoordinatesModel({
    required super.latitude,
    required super.longitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
