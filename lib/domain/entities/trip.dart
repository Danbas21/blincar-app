import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  final String id;
  final String passengerId;
  final String? driverId;
  final String? serviceTypeId;
  final TripStatus status;
  final String originAddress;
  final String destinationAddress;
  final Coordinates originCoordinates;
  final Coordinates destinationCoordinates;
  final double? estimatedDistance;
  final int? estimatedDuration;
  final double? estimatedPrice;
  final double? actualPrice;
  final double? actualDistance;
  final int? actualDuration;
  final DateTime requestedAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final String? cancelReason;
  final String? cancelledBy;
  final int? ratingByPassenger;
  final int? ratingByDriver;
  final String? commentByPassenger;
  final String? commentByDriver;
  final bool hasRecording;
  final int panicAlertsCount;
  final int routeChangesCount;

  const Trip({
    required this.id,
    required this.passengerId,
    this.driverId,
    this.serviceTypeId,
    required this.status,
    required this.originAddress,
    required this.destinationAddress,
    required this.originCoordinates,
    required this.destinationCoordinates,
    this.estimatedDistance,
    this.estimatedDuration,
    this.estimatedPrice,
    this.actualPrice,
    this.actualDistance,
    this.actualDuration,
    required this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancelReason,
    this.cancelledBy,
    this.ratingByPassenger,
    this.ratingByDriver,
    this.commentByPassenger,
    this.commentByDriver,
    this.hasRecording = false,
    this.panicAlertsCount = 0,
    this.routeChangesCount = 0,
  });

  bool get isCompleted => status == TripStatus.completed;
  bool get isCancelled => status == TripStatus.cancelled;
  bool get isInProgress => status == TripStatus.inProgress;
  bool get canCancel =>
      status == TripStatus.requested || status == TripStatus.accepted;

  Duration? get actualDurationDuration =>
      actualDuration != null ? Duration(minutes: actualDuration!) : null;

  @override
  List<Object?> get props => [
        id,
        passengerId,
        driverId,
        serviceTypeId,
        status,
        originAddress,
        destinationAddress,
        originCoordinates,
        destinationCoordinates,
        estimatedDistance,
        estimatedDuration,
        estimatedPrice,
        actualPrice,
        actualDistance,
        actualDuration,
        requestedAt,
        acceptedAt,
        startedAt,
        completedAt,
        cancelledAt,
        cancelReason,
        cancelledBy,
        ratingByPassenger,
        ratingByDriver,
        commentByPassenger,
        commentByDriver,
        hasRecording,
        panicAlertsCount,
        routeChangesCount,
      ];
}

class Coordinates extends Equatable {
  final double latitude;
  final double longitude;

  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}

enum TripStatus {
  requested,
  accepted,
  inProgress,
  completed,
  cancelled,
}
