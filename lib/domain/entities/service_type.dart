// lib/domain/entities/service_type.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_type.freezed.dart';
part 'service_type.g.dart';

/// Entidad que representa un tipo de servicio en Blincar
///
/// Define precios base, por km, por minuto, hora y dia.
/// Incluye configuracion de comisiones y requisitos especiales.
@freezed
class ServiceType with _$ServiceType {
  const ServiceType._();

  const factory ServiceType({
    required String id,
    required String name,
    required String description,
    required double basePrice,
    @Default(0.0) double pricePerKm,
    @Default(0.0) double pricePerMinute,
    @Default(0.0) double pricePerHour,
    @Default(0.0) double pricePerDay,
    @Default(15.0) double commissionPercentage,
    @Default(true) bool isActive,
    @Default(false) bool requiresSpecialLicense,
    @Default('mx') String region,
    @Default('MXN') String currency,
  }) = _ServiceType;

  factory ServiceType.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeFromJson(json);

  /// Calcula el precio total del servicio
  double calculatePrice({
    double? distance,
    int? minutes,
    int? hours,
    int? days,
  }) {
    double total = basePrice;

    if (distance != null) total += distance * pricePerKm;
    if (minutes != null) total += minutes * pricePerMinute;
    if (hours != null) total += hours * pricePerHour;
    if (days != null) total += days * pricePerDay;

    return total;
  }

  /// Calcula la comision de Blincar
  double calculateCommission(double totalPrice) =>
      totalPrice * (commissionPercentage / 100);

  /// Precio formateado con moneda
  String formatPrice(double price) => '\$$currency ${price.toStringAsFixed(2)}';
}
