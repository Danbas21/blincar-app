// lib/domain/entities/trip/route_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_entity.freezed.dart';
part 'route_entity.g.dart';

/// Punto de ubicación
@freezed
class LocationPoint with _$LocationPoint {
  const LocationPoint._(); // Constructor privado para métodos custom

  const factory LocationPoint({
    required String name,
    required String address,
    required double latitude,
    required double longitude,
  }) = _LocationPoint;

  factory LocationPoint.fromJson(Map<String, dynamic> json) =>
      _$LocationPointFromJson(json);
}

/// Ruta predefinida de Blincar
///
/// Basada en el tabulador real:
/// Draft_Tabulador_BLINCAR_oct_2025.xlsx
@freezed
class RouteEntity with _$RouteEntity {
  const RouteEntity._(); // Constructor privado para métodos custom

  const factory RouteEntity({
    required String id,
    required String name,
    required LocationPoint origin,
    required LocationPoint destination,
    required double distanceKm,
    required int estimatedDurationMinutes,
    required double basePrice, // MXN
    double? tollCost, // MXN (casetas)
    required RouteCategory category,
  }) = _RouteEntity;

  factory RouteEntity.fromJson(Map<String, dynamic> json) =>
      _$RouteEntityFromJson(json);

  /// Precio total (incluye casetas)
  double get totalPrice => basePrice + (tollCost ?? 0);

  /// Precio por kilómetro
  double get pricePerKm => basePrice / distanceKm;
}

/// Categoría de ruta
enum RouteCategory {
  airport, // Desde/hacia aeropuertos
  cityCenter, // Centro de CDMX
  businessDistrict, // Zonas de negocios
  residential, // Zonas residenciales
  cultural, // Zonas culturales
  highway, // Carretera
  custom, // Viaje personalizado (viaje rapido)
}

extension RouteCategoryX on RouteCategory {
  String get displayName {
    switch (this) {
      case RouteCategory.airport:
        return 'Aeropuerto';
      case RouteCategory.cityCenter:
        return 'Centro';
      case RouteCategory.businessDistrict:
        return 'Negocios';
      case RouteCategory.residential:
        return 'Residencial';
      case RouteCategory.cultural:
        return 'Cultural';
      case RouteCategory.highway:
        return 'Carretera';
      case RouteCategory.custom:
        return 'Personalizado';
    }
  }
}
