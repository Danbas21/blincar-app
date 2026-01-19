// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveTripImpl _$$ActiveTripImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ActiveTripImpl',
      json,
      ($checkedConvert) {
        final val = _$ActiveTripImpl(
          id: $checkedConvert('id', (v) => v as String),
          requestId: $checkedConvert('requestId', (v) => v as String),
          userId: $checkedConvert('userId', (v) => v as String),
          driverId: $checkedConvert('driverId', (v) => v as String),
          vehicleId: $checkedConvert('vehicleId', (v) => v as String),
          monitorId: $checkedConvert('monitorId', (v) => v as String),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$ActiveTripStatusEnumMap, v)),
          currentLocation: $checkedConvert(
              'currentLocation',
              (v) => v == null
                  ? null
                  : Coordinates.fromJson(v as Map<String, dynamic>)),
          currentSpeed:
              $checkedConvert('currentSpeed', (v) => (v as num?)?.toDouble()),
          currentHeading:
              $checkedConvert('currentHeading', (v) => (v as num?)?.toDouble()),
          videoStreamUrl:
              $checkedConvert('videoStreamUrl', (v) => v as String?),
          recordingStarted:
              $checkedConvert('recordingStarted', (v) => v as bool? ?? false),
          emergencyContactNotified: $checkedConvert(
              'emergencyContactNotified', (v) => v as bool? ?? false),
          startTime: $checkedConvert('startTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          estimatedEndTime: $checkedConvert('estimatedEndTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          completedAt: $checkedConvert('completedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          actualPrice:
              $checkedConvert('actualPrice', (v) => (v as num).toDouble()),
          serviceRating:
              $checkedConvert('serviceRating', (v) => (v as num?)?.toInt()),
          serviceFeedback:
              $checkedConvert('serviceFeedback', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ActiveTripImplToJson(_$ActiveTripImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestId': instance.requestId,
      'userId': instance.userId,
      'driverId': instance.driverId,
      'vehicleId': instance.vehicleId,
      'monitorId': instance.monitorId,
      'status': _$ActiveTripStatusEnumMap[instance.status]!,
      'currentLocation': instance.currentLocation?.toJson(),
      'currentSpeed': instance.currentSpeed,
      'currentHeading': instance.currentHeading,
      'videoStreamUrl': instance.videoStreamUrl,
      'recordingStarted': instance.recordingStarted,
      'emergencyContactNotified': instance.emergencyContactNotified,
      'startTime': instance.startTime?.toIso8601String(),
      'estimatedEndTime': instance.estimatedEndTime?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'actualPrice': instance.actualPrice,
      'serviceRating': instance.serviceRating,
      'serviceFeedback': instance.serviceFeedback,
    };

const _$ActiveTripStatusEnumMap = {
  ActiveTripStatus.confirmed: 'confirmed',
  ActiveTripStatus.ongoing: 'ongoing',
  ActiveTripStatus.completed: 'completed',
  ActiveTripStatus.cancelled: 'cancelled',
};
