// lib/domain/entities/vehicle.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

/// Tipos de vehiculos disponibles en Blincar
enum VehicleType {
  suv,
  suburbanBlindado,
  escalade,
  landRover,
  explorer,
  bmwF800, // Moto
}

/// Entidad que representa un vehiculo en el sistema Blincar
///
/// Incluye informacion completa del vehiculo: marca, modelo, blindaje,
/// disponibilidad, y asignaciones actuales.
///
/// Esta entidad sigue el principio de Single Responsibility (SOLID)
/// enfocandose unicamente en los datos del vehiculo.
@freezed
class Vehicle with _$Vehicle {
  const Vehicle._();

  const factory Vehicle({
    required String id,
    required String brand,
    required String model,
    required int year,
    required VehicleType type,
    required String licensePlate,
    required int capacity,
    @Default(false) bool isArmored,
    String? armorLevel, // "Nivel III", etc.
    required String color,
    String? interiors,
    String? photoUrl,
    @Default(true) bool isAvailable,
    String? currentDriverId,
    String? currentTripId,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  /// Nombre completo del vehiculo (marca + modelo + año)
  String get fullName => '$brand $model $year';

  /// Verifica si el vehiculo esta en uso actualmente
  bool get isInUse => currentTripId != null;

  /// Verifica si el vehiculo tiene conductor asignado
  bool get hasDriver => currentDriverId != null;

  /// Verifica si el vehiculo puede ser asignado a un viaje
  bool get canBeAssigned => isAvailable && !isInUse;

  /// Descripcion del nivel de blindaje
  String get armorDescription {
    if (!isArmored) return 'Sin blindaje';
    return armorLevel ?? 'Blindado';
  }
}
