// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$VehicleImpl',
      json,
      ($checkedConvert) {
        final val = _$VehicleImpl(
          id: $checkedConvert('id', (v) => v as String),
          brand: $checkedConvert('brand', (v) => v as String),
          model: $checkedConvert('model', (v) => v as String),
          year: $checkedConvert('year', (v) => (v as num).toInt()),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$VehicleTypeEnumMap, v)),
          licensePlate: $checkedConvert('licensePlate', (v) => v as String),
          capacity: $checkedConvert('capacity', (v) => (v as num).toInt()),
          isArmored: $checkedConvert('isArmored', (v) => v as bool? ?? false),
          armorLevel: $checkedConvert('armorLevel', (v) => v as String?),
          color: $checkedConvert('color', (v) => v as String),
          interiors: $checkedConvert('interiors', (v) => v as String?),
          photoUrl: $checkedConvert('photoUrl', (v) => v as String?),
          isAvailable:
              $checkedConvert('isAvailable', (v) => v as bool? ?? true),
          currentDriverId:
              $checkedConvert('currentDriverId', (v) => v as String?),
          currentTripId: $checkedConvert('currentTripId', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'year': instance.year,
      'type': _$VehicleTypeEnumMap[instance.type]!,
      'licensePlate': instance.licensePlate,
      'capacity': instance.capacity,
      'isArmored': instance.isArmored,
      'armorLevel': instance.armorLevel,
      'color': instance.color,
      'interiors': instance.interiors,
      'photoUrl': instance.photoUrl,
      'isAvailable': instance.isAvailable,
      'currentDriverId': instance.currentDriverId,
      'currentTripId': instance.currentTripId,
    };

const _$VehicleTypeEnumMap = {
  VehicleType.suv: 'suv',
  VehicleType.suburbanBlindado: 'suburbanBlindado',
  VehicleType.escalade: 'escalade',
  VehicleType.landRover: 'landRover',
  VehicleType.explorer: 'explorer',
  VehicleType.bmwF800: 'bmwF800',
};
