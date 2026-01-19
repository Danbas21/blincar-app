// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$LocationImpl',
      json,
      ($checkedConvert) {
        final val = _$LocationImpl(
          name: $checkedConvert('name', (v) => v as String),
          address: $checkedConvert('address', (v) => v as String),
          coordinates: $checkedConvert('coordinates',
              (v) => Coordinates.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'coordinates': instance.coordinates.toJson(),
    };
