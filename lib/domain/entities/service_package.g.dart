// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServicePackageImpl _$$ServicePackageImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ServicePackageImpl',
      json,
      ($checkedConvert) {
        final val = _$ServicePackageImpl(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          vehicleTypes: $checkedConvert(
              'vehicleTypes',
              (v) => (v as List<dynamic>)
                  .map((e) => $enumDecode(_$VehicleTypeEnumMap, e))
                  .toList()),
          capacity: $checkedConvert('capacity', (v) => (v as num).toInt()),
          isArmored: $checkedConvert('isArmored', (v) => v as bool? ?? false),
          includesEscort:
              $checkedConvert('includesEscort', (v) => v as bool? ?? false),
          escortType: $checkedConvert(
              'escortType', (v) => $enumDecodeNullable(_$EscortTypeEnumMap, v)),
          basePrice: $checkedConvert('basePrice', (v) => (v as num).toDouble()),
          pricePerKm:
              $checkedConvert('pricePerKm', (v) => (v as num).toDouble()),
          pricePerHour:
              $checkedConvert('pricePerHour', (v) => (v as num).toDouble()),
          minHours:
              $checkedConvert('minHours', (v) => (v as num?)?.toInt() ?? 1),
          features: $checkedConvert(
              'features',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ServicePackageImplToJson(
        _$ServicePackageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'vehicleTypes':
          instance.vehicleTypes.map((e) => _$VehicleTypeEnumMap[e]!).toList(),
      'capacity': instance.capacity,
      'isArmored': instance.isArmored,
      'includesEscort': instance.includesEscort,
      'escortType': _$EscortTypeEnumMap[instance.escortType],
      'basePrice': instance.basePrice,
      'pricePerKm': instance.pricePerKm,
      'pricePerHour': instance.pricePerHour,
      'minHours': instance.minHours,
      'features': instance.features,
      'imageUrl': instance.imageUrl,
    };

const _$VehicleTypeEnumMap = {
  VehicleType.suv: 'suv',
  VehicleType.suburbanBlindado: 'suburbanBlindado',
  VehicleType.escalade: 'escalade',
  VehicleType.landRover: 'landRover',
  VehicleType.explorer: 'explorer',
  VehicleType.bmwF800: 'bmwF800',
};

const _$EscortTypeEnumMap = {
  EscortType.none: 'none',
  EscortType.unarmed: 'unarmed',
  EscortType.armed: 'armed',
};
