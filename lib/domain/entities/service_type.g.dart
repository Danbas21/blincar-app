// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceTypeImpl _$$ServiceTypeImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ServiceTypeImpl',
      json,
      ($checkedConvert) {
        final val = _$ServiceTypeImpl(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          basePrice: $checkedConvert('basePrice', (v) => (v as num).toDouble()),
          pricePerKm: $checkedConvert(
              'pricePerKm', (v) => (v as num?)?.toDouble() ?? 0.0),
          pricePerMinute: $checkedConvert(
              'pricePerMinute', (v) => (v as num?)?.toDouble() ?? 0.0),
          pricePerHour: $checkedConvert(
              'pricePerHour', (v) => (v as num?)?.toDouble() ?? 0.0),
          pricePerDay: $checkedConvert(
              'pricePerDay', (v) => (v as num?)?.toDouble() ?? 0.0),
          commissionPercentage: $checkedConvert(
              'commissionPercentage', (v) => (v as num?)?.toDouble() ?? 15.0),
          isActive: $checkedConvert('isActive', (v) => v as bool? ?? true),
          requiresSpecialLicense: $checkedConvert(
              'requiresSpecialLicense', (v) => v as bool? ?? false),
          region: $checkedConvert('region', (v) => v as String? ?? 'mx'),
          currency: $checkedConvert('currency', (v) => v as String? ?? 'MXN'),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ServiceTypeImplToJson(_$ServiceTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'basePrice': instance.basePrice,
      'pricePerKm': instance.pricePerKm,
      'pricePerMinute': instance.pricePerMinute,
      'pricePerHour': instance.pricePerHour,
      'pricePerDay': instance.pricePerDay,
      'commissionPercentage': instance.commissionPercentage,
      'isActive': instance.isActive,
      'requiresSpecialLicense': instance.requiresSpecialLicense,
      'region': instance.region,
      'currency': instance.currency,
    };
