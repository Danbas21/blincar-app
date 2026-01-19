// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripEntityImpl _$$TripEntityImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripEntityImpl',
      json,
      ($checkedConvert) {
        final val = _$TripEntityImpl(
          id: $checkedConvert('id', (v) => v as String),
          userId: $checkedConvert('userId', (v) => v as String),
          userName: $checkedConvert('userName', (v) => v as String),
          userPhone: $checkedConvert('userPhone', (v) => v as String),
          route: $checkedConvert(
              'route', (v) => RouteEntity.fromJson(v as Map<String, dynamic>)),
          serviceType: $checkedConvert('serviceType', (v) => v as String),
          totalPrice:
              $checkedConvert('totalPrice', (v) => (v as num).toDouble()),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$TripStatusEnumMap, v)),
          requestedAt: $checkedConvert(
              'requestedAt', (v) => DateTime.parse(v as String)),
          driverId: $checkedConvert('driverId', (v) => v as String?),
          driverName: $checkedConvert('driverName', (v) => v as String?),
          driverPhone: $checkedConvert('driverPhone', (v) => v as String?),
          vehicleId: $checkedConvert('vehicleId', (v) => v as String?),
          vehiclePlate: $checkedConvert('vehiclePlate', (v) => v as String?),
          assignedAt: $checkedConvert('assignedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          startedAt: $checkedConvert('startedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          completedAt: $checkedConvert('completedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          videoSessionId:
              $checkedConvert('videoSessionId', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TripEntityImplToJson(_$TripEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhone': instance.userPhone,
      'route': instance.route.toJson(),
      'serviceType': instance.serviceType,
      'totalPrice': instance.totalPrice,
      'status': _$TripStatusEnumMap[instance.status]!,
      'requestedAt': instance.requestedAt.toIso8601String(),
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'driverPhone': instance.driverPhone,
      'vehicleId': instance.vehicleId,
      'vehiclePlate': instance.vehiclePlate,
      'assignedAt': instance.assignedAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'videoSessionId': instance.videoSessionId,
    };

const _$TripStatusEnumMap = {
  TripStatus.pending: 'pending',
  TripStatus.assigned: 'assigned',
  TripStatus.inProgress: 'inProgress',
  TripStatus.completed: 'completed',
  TripStatus.cancelled: 'cancelled',
};
