// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripRequestImpl _$$TripRequestImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TripRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$TripRequestImpl(
          id: $checkedConvert('id', (v) => v as String),
          userId: $checkedConvert('userId', (v) => v as String),
          userEmail: $checkedConvert('userEmail', (v) => v as String),
          userName: $checkedConvert('userName', (v) => v as String),
          servicePackageId:
              $checkedConvert('servicePackageId', (v) => v as String),
          servicePackageName:
              $checkedConvert('servicePackageName', (v) => v as String),
          origin: $checkedConvert(
              'origin', (v) => Location.fromJson(v as Map<String, dynamic>)),
          destination: $checkedConvert('destination',
              (v) => Location.fromJson(v as Map<String, dynamic>)),
          scheduledTime: $checkedConvert(
              'scheduledTime', (v) => DateTime.parse(v as String)),
          estimatedDistance: $checkedConvert(
              'estimatedDistance', (v) => (v as num).toDouble()),
          estimatedDuration:
              $checkedConvert('estimatedDuration', (v) => (v as num).toInt()),
          estimatedPrice:
              $checkedConvert('estimatedPrice', (v) => (v as num).toDouble()),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$TripRequestStatusEnumMap, v)),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
          assignedDriverId:
              $checkedConvert('assignedDriverId', (v) => v as String?),
          assignedVehicleId:
              $checkedConvert('assignedVehicleId', (v) => v as String?),
          assignedByMonitorId:
              $checkedConvert('assignedByMonitorId', (v) => v as String?),
          assignedAt: $checkedConvert('assignedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TripRequestImplToJson(_$TripRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userEmail': instance.userEmail,
      'userName': instance.userName,
      'servicePackageId': instance.servicePackageId,
      'servicePackageName': instance.servicePackageName,
      'origin': instance.origin.toJson(),
      'destination': instance.destination.toJson(),
      'scheduledTime': instance.scheduledTime.toIso8601String(),
      'estimatedDistance': instance.estimatedDistance,
      'estimatedDuration': instance.estimatedDuration,
      'estimatedPrice': instance.estimatedPrice,
      'status': _$TripRequestStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'assignedDriverId': instance.assignedDriverId,
      'assignedVehicleId': instance.assignedVehicleId,
      'assignedByMonitorId': instance.assignedByMonitorId,
      'assignedAt': instance.assignedAt?.toIso8601String(),
    };

const _$TripRequestStatusEnumMap = {
  TripRequestStatus.pending: 'pending',
  TripRequestStatus.assigned: 'assigned',
  TripRequestStatus.confirmed: 'confirmed',
  TripRequestStatus.cancelled: 'cancelled',
};
