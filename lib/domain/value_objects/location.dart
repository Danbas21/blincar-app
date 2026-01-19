// lib/domain/value_objects/location.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'coordinates.dart';

part 'location.freezed.dart';
part 'location.g.dart';

/// Value Object que representa una ubicacion completa
///
/// Incluye nombre legible, direccion y coordenadas GPS.
/// Util para origen/destino de viajes.
///
/// Ejemplo:
/// ```dart
/// final location = Location(
///   name: 'Hotel Marriott Reforma',
///   address: 'Paseo de la Reforma 276, CDMX',
///   coordinates: Coordinates(latitude: 19.4326, longitude: -99.1332),
/// );
/// ```
@freezed
class Location with _$Location {
  const Location._();

  const factory Location({
    required String name,
    required String address,
    required Coordinates coordinates,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Crea una ubicacion desde coordenadas con geocodificacion pendiente
  factory Location.fromCoordinates(Coordinates coords) => Location(
        name: 'Ubicacion',
        address: '${coords.latitude}, ${coords.longitude}',
        coordinates: coords,
      );

  /// Latitud de la ubicacion
  double get latitude => coordinates.latitude;

  /// Longitud de la ubicacion
  double get longitude => coordinates.longitude;

  /// Nombre corto (primeras 3 palabras)
  String get shortName {
    final words = name.split(' ');
    if (words.length <= 3) return name;
    return '${words.take(3).join(' ')}...';
  }
}
