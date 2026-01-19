// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationPointImpl _$$LocationPointImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$LocationPointImpl',
      json,
      ($checkedConvert) {
        final val = _$LocationPointImpl(
          name: $checkedConvert('name', (v) => v as String),
          address: $checkedConvert('address', (v) => v as String),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$LocationPointImplToJson(_$LocationPointImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$RouteEntityImpl _$$RouteEntityImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$RouteEntityImpl',
      json,
      ($checkedConvert) {
        final val = _$RouteEntityImpl(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          origin: $checkedConvert('origin',
              (v) => LocationPoint.fromJson(v as Map<String, dynamic>)),
          destination: $checkedConvert('destination',
              (v) => LocationPoint.fromJson(v as Map<String, dynamic>)),
          distanceKm:
              $checkedConvert('distanceKm', (v) => (v as num).toDouble()),
          estimatedDurationMinutes: $checkedConvert(
              'estimatedDurationMinutes', (v) => (v as num).toInt()),
          basePrice: $checkedConvert('basePrice', (v) => (v as num).toDouble()),
          tollCost: $checkedConvert('tollCost', (v) => (v as num?)?.toDouble()),
          category: $checkedConvert(
              'category', (v) => $enumDecode(_$RouteCategoryEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$RouteEntityImplToJson(_$RouteEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'origin': instance.origin.toJson(),
      'destination': instance.destination.toJson(),
      'distanceKm': instance.distanceKm,
      'estimatedDurationMinutes': instance.estimatedDurationMinutes,
      'basePrice': instance.basePrice,
      'tollCost': instance.tollCost,
      'category': _$RouteCategoryEnumMap[instance.category]!,
    };

const _$RouteCategoryEnumMap = {
  RouteCategory.airport: 'airport',
  RouteCategory.cityCenter: 'cityCenter',
  RouteCategory.businessDistrict: 'businessDistrict',
  RouteCategory.residential: 'residential',
  RouteCategory.cultural: 'cultural',
  RouteCategory.highway: 'highway',
  RouteCategory.custom: 'custom',
};
