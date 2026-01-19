// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverImpl _$$DriverImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$DriverImpl',
      json,
      ($checkedConvert) {
        final val = _$DriverImpl(
          id: $checkedConvert('id', (v) => v as String),
          firebaseUid: $checkedConvert('firebaseUid', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
          fullName: $checkedConvert('fullName', (v) => v as String),
          licenseNumber: $checkedConvert('licenseNumber', (v) => v as String?),
          licenseExpiryDate: $checkedConvert('licenseExpiryDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          isAvailable:
              $checkedConvert('isAvailable', (v) => v as bool? ?? true),
          isActive: $checkedConvert('isActive', (v) => v as bool? ?? true),
          currentTripId: $checkedConvert('currentTripId', (v) => v as String?),
          currentLocation: $checkedConvert(
              'currentLocation',
              (v) => v == null
                  ? null
                  : Coordinates.fromJson(v as Map<String, dynamic>)),
          profilePhotoUrl:
              $checkedConvert('profilePhotoUrl', (v) => v as String?),
          rating: $checkedConvert('rating', (v) => (v as num?)?.toDouble()),
          totalTrips:
              $checkedConvert('totalTrips', (v) => (v as num?)?.toInt() ?? 0),
          lastUpdate: $checkedConvert('lastUpdate',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$DriverImplToJson(_$DriverImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firebaseUid': instance.firebaseUid,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'licenseNumber': instance.licenseNumber,
      'licenseExpiryDate': instance.licenseExpiryDate?.toIso8601String(),
      'isAvailable': instance.isAvailable,
      'isActive': instance.isActive,
      'currentTripId': instance.currentTripId,
      'currentLocation': instance.currentLocation?.toJson(),
      'profilePhotoUrl': instance.profilePhotoUrl,
      'rating': instance.rating,
      'totalTrips': instance.totalTrips,
      'lastUpdate': instance.lastUpdate?.toIso8601String(),
    };
