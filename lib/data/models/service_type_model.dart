// lib/data/models/service_type_model.dart

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/service_type.dart';

part 'service_type_model.freezed.dart';
part 'service_type_model.g.dart';

/// Modelo de datos para ServiceType
///
/// Maneja la serializacion JSON con snake_case para comunicacion con APIs.
/// Incluye metodo para convertir a entidad de dominio.
@freezed
class ServiceTypeModel with _$ServiceTypeModel {
  const ServiceTypeModel._();

  const factory ServiceTypeModel({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'base_price') required double basePrice,
    @JsonKey(name: 'price_per_km') @Default(0.0) double pricePerKm,
    @JsonKey(name: 'price_per_minute') @Default(0.0) double pricePerMinute,
    @JsonKey(name: 'price_per_hour') @Default(0.0) double pricePerHour,
    @JsonKey(name: 'price_per_day') @Default(0.0) double pricePerDay,
    @JsonKey(name: 'commission_percentage') @Default(15.0) double commissionPercentage,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'requires_special_license') @Default(false) bool requiresSpecialLicense,
    @Default('mx') String region,
    @Default('MXN') String currency,
  }) = _ServiceTypeModel;

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeModelFromJson(json);

  /// Convierte el modelo a entidad de dominio
  ServiceType toEntity() => ServiceType(
    id: id,
    name: name,
    description: description,
    basePrice: basePrice,
    pricePerKm: pricePerKm,
    pricePerMinute: pricePerMinute,
    pricePerHour: pricePerHour,
    pricePerDay: pricePerDay,
    commissionPercentage: commissionPercentage,
    isActive: isActive,
    requiresSpecialLicense: requiresSpecialLicense,
    region: region,
    currency: currency,
  );

  /// Crea un modelo desde una entidad de dominio
  factory ServiceTypeModel.fromEntity(ServiceType entity) => ServiceTypeModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    basePrice: entity.basePrice,
    pricePerKm: entity.pricePerKm,
    pricePerMinute: entity.pricePerMinute,
    pricePerHour: entity.pricePerHour,
    pricePerDay: entity.pricePerDay,
    commissionPercentage: entity.commissionPercentage,
    isActive: entity.isActive,
    requiresSpecialLicense: entity.requiresSpecialLicense,
    region: entity.region,
    currency: entity.currency,
  );
}
