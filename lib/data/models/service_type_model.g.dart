// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceTypeModelImpl _$$ServiceTypeModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ServiceTypeModelImpl',
      json,
      ($checkedConvert) {
        final val = _$ServiceTypeModelImpl(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          basePrice:
              $checkedConvert('base_price', (v) => (v as num).toDouble()),
          pricePerKm: $checkedConvert(
              'price_per_km', (v) => (v as num?)?.toDouble() ?? 0.0),
          pricePerMinute: $checkedConvert(
              'price_per_minute', (v) => (v as num?)?.toDouble() ?? 0.0),
          pricePerHour: $checkedConvert(
              'price_per_hour', (v) => (v as num?)?.toDouble() ?? 0.0),
          pricePerDay: $checkedConvert(
              'price_per_day', (v) => (v as num?)?.toDouble() ?? 0.0),
          commissionPercentage: $checkedConvert(
              'commission_percentage', (v) => (v as num?)?.toDouble() ?? 15.0),
          isActive: $checkedConvert('is_active', (v) => v as bool? ?? true),
          requiresSpecialLicense: $checkedConvert(
              'requires_special_license', (v) => v as bool? ?? false),
          region: $checkedConvert('region', (v) => v as String? ?? 'mx'),
          currency: $checkedConvert('currency', (v) => v as String? ?? 'MXN'),
        );
        return val;
      },
      fieldKeyMap: const {
        'basePrice': 'base_price',
        'pricePerKm': 'price_per_km',
        'pricePerMinute': 'price_per_minute',
        'pricePerHour': 'price_per_hour',
        'pricePerDay': 'price_per_day',
        'commissionPercentage': 'commission_percentage',
        'isActive': 'is_active',
        'requiresSpecialLicense': 'requires_special_license'
      },
    );

Map<String, dynamic> _$$ServiceTypeModelImplToJson(
        _$ServiceTypeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'base_price': instance.basePrice,
      'price_per_km': instance.pricePerKm,
      'price_per_minute': instance.pricePerMinute,
      'price_per_hour': instance.pricePerHour,
      'price_per_day': instance.pricePerDay,
      'commission_percentage': instance.commissionPercentage,
      'is_active': instance.isActive,
      'requires_special_license': instance.requiresSpecialLicense,
      'region': instance.region,
      'currency': instance.currency,
    };
