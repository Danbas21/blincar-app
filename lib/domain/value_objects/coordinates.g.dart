// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoordinatesImpl _$$CoordinatesImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CoordinatesImpl',
      json,
      ($checkedConvert) {
        final val = _$CoordinatesImpl(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CoordinatesImplToJson(_$CoordinatesImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
