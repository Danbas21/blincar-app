// lib/domain/value_objects/coordinates.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinates.freezed.dart';
part 'coordinates.g.dart';

/// Value Object que representa coordenadas geograficas (GPS)
///
/// Este VO encapsula latitud y longitud, asegurando inmutabilidad
/// y proporcionando metodos de serializacion.
///
/// Ejemplo de uso:
/// ```dart
/// final coords = Coordinates(latitude: 19.4326, longitude: -99.1332);
/// final updated = coords.copyWith(latitude: 20.0);
/// ```
@freezed
class Coordinates with _$Coordinates {
  const Coordinates._();

  const factory Coordinates({
    required double latitude,
    required double longitude,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  /// Verifica si las coordenadas son validas
  bool get isValid =>
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;

  /// Crea coordenadas desde latitud y longitud separadas
  factory Coordinates.fromLatLng(double lat, double lng) =>
      Coordinates(latitude: lat, longitude: lng);

  /// Coordenadas de Ciudad de Mexico (default)
  factory Coordinates.cdmx() =>
      const Coordinates(latitude: 19.4326, longitude: -99.1332);
}
