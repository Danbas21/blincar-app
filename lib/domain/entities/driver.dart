// lib/domain/entities/driver.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/coordinates.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

/// Entidad que representa un conductor/chofer en Blincar
///
/// Incluye informacion personal, licencias, disponibilidad,
/// rating y ubicacion en tiempo real.
///
/// Usa @freezed para generar automaticamente:
/// - copyWith()
/// - fromJson/toJson
/// - equality (==)
/// - hashCode
/// - toString()
@freezed
class Driver with _$Driver {
  const Driver._();

  const factory Driver({
    required String id,
    required String firebaseUid,
    required String email,
    required String phoneNumber,
    required String fullName,
    String? licenseNumber,
    DateTime? licenseExpiryDate,
    @Default(true) bool isAvailable,
    @Default(true) bool isActive,
    String? currentTripId,
    Coordinates? currentLocation,
    String? profilePhotoUrl,
    double? rating,
    @Default(0) int totalTrips,
    DateTime? lastUpdate,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  /// Verifica si el conductor tiene licencia vigente
  bool get hasValidLicense {
    if (licenseNumber == null || licenseExpiryDate == null) return false;
    return licenseExpiryDate!.isAfter(DateTime.now());
  }

  /// Verifica si el conductor esta disponible para un viaje
  bool get canAcceptTrip =>
      isAvailable && isActive && currentTripId == null && hasValidLicense;

  /// Calcula el rating como string formateado
  String get formattedRating => rating?.toStringAsFixed(1) ?? 'N/A';
}
