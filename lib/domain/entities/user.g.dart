// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$UserImpl',
      json,
      ($checkedConvert) {
        final val = _$UserImpl(
          id: $checkedConvert('id', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
          fullName: $checkedConvert('fullName', (v) => v as String),
          photoURL: $checkedConvert('photoURL', (v) => v as String?),
          phoneVerified:
              $checkedConvert('phoneVerified', (v) => v as bool? ?? false),
          emailVerified:
              $checkedConvert('emailVerified', (v) => v as bool? ?? false),
          emergencyContactName:
              $checkedConvert('emergencyContactName', (v) => v as String?),
          emergencyContactPhone:
              $checkedConvert('emergencyContactPhone', (v) => v as String?),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'photoURL': instance.photoURL,
      'phoneVerified': instance.phoneVerified,
      'emailVerified': instance.emailVerified,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactPhone': instance.emergencyContactPhone,
      'createdAt': instance.createdAt.toIso8601String(),
    };
