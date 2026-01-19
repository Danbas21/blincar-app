// lib/domain/entities/service_package.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'vehicle.dart';

part 'service_package.freezed.dart';
part 'service_package.g.dart';

/// Tipos de escolta disponibles
enum EscortType {
  none,
  unarmed, // Desarmada
  armed, // Armada
}

/// Entidad que representa un paquete de servicio en Blincar
///
/// Define que incluye el servicio: tipo de vehiculo, escoltas,
/// blindaje, precios y caracteristicas.
///
/// Ejemplos de paquetes:
/// - Transporte Ejecutivo (Suburban/Escalade sin blindaje)
/// - Seguridad Premium (Suburban Blindado Nivel III)
/// - Escolta Armada (Cualquier vehiculo + escolta armada)
@freezed
class ServicePackage with _$ServicePackage {
  const ServicePackage._();

  const factory ServicePackage({
    required String id,
    required String name,
    required String description,
    required List<VehicleType> vehicleTypes,
    required int capacity,
    @Default(false) bool isArmored,
    @Default(false) bool includesEscort,
    EscortType? escortType,
    required double basePrice,
    required double pricePerKm,
    required double pricePerHour,
    @Default(1) int minHours,
    @Default([]) List<String> features,
    String? imageUrl,
  }) = _ServicePackage;

  factory ServicePackage.fromJson(Map<String, dynamic> json) =>
      _$ServicePackageFromJson(json);

  /// Calcula el precio estimado del servicio
  ///
  /// Formula: basePrice + (distanceKm * pricePerKm) + (hours * pricePerHour)
  double calculateEstimatedPrice({
    required double distanceKm,
    required int hours,
  }) {
    final effectiveHours = hours < minHours ? minHours : hours;
    return basePrice +
        (distanceKm * pricePerKm) +
        (effectiveHours * pricePerHour);
  }

  /// Verifica si el paquete soporta un tipo de vehiculo
  bool supportsVehicleType(VehicleType type) => vehicleTypes.contains(type);

  /// Descripcion del tipo de escolta
  String get escortDescription {
    if (!includesEscort) return 'Sin escolta';
    switch (escortType) {
      case EscortType.armed:
        return 'Escolta armada';
      case EscortType.unarmed:
        return 'Escolta desarmada';
      default:
        return 'Escolta incluida';
    }
  }
}
