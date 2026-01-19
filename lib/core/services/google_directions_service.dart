// lib/core/services/google_directions_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';

/// Servicio para calcular rutas y duracion usando Google Maps Directions API
///
/// Uso:
/// ```dart
/// final service = GoogleDirectionsService();
/// final result = await service.getDirections(
///   originLat: 19.4326,
///   originLng: -99.1332,
///   destinationLat: 19.4018,
///   destinationLng: -99.1507,
/// );
/// print('Duracion: ${result.durationMinutes} minutos');
/// ```
class GoogleDirectionsService {
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';

  /// Obtiene la ruta y duracion entre dos puntos
  ///
  /// Retorna [DirectionsResult] con:
  /// - durationMinutes: tiempo estimado en minutos
  /// - distanceKm: distancia en kilometros
  /// - durationText: texto formateado (ej: "25 mins")
  /// - distanceText: texto formateado (ej: "8.5 km")
  Future<DirectionsResult> getDirections({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    try {
      final apiKey = EnvConfig.googleMapsApiKey;

      if (apiKey.isEmpty) {
        // Sin API key, calcular aproximacion basada en distancia
        return _calculateApproximateDirections(
          originLat: originLat,
          originLng: originLng,
          destinationLat: destinationLat,
          destinationLng: destinationLng,
        );
      }

      final url = Uri.parse(
        '$_baseUrl?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&key=$apiKey&mode=driving&language=es',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout obteniendo direcciones'),
      );

      if (response.statusCode != 200) {
        throw Exception('Error en API: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data['status'] != 'OK') {
        // Si la API falla, usar aproximacion
        return _calculateApproximateDirections(
          originLat: originLat,
          originLng: originLng,
          destinationLat: destinationLat,
          destinationLng: destinationLng,
        );
      }

      final routes = data['routes'] as List;
      if (routes.isEmpty) {
        throw Exception('No se encontraron rutas');
      }

      final legs = routes[0]['legs'] as List;
      if (legs.isEmpty) {
        throw Exception('No se encontraron tramos');
      }

      final leg = legs[0] as Map<String, dynamic>;

      // Extraer duracion
      final duration = leg['duration'] as Map<String, dynamic>;
      final durationSeconds = duration['value'] as int;
      final durationText = duration['text'] as String;

      // Extraer distancia
      final distance = leg['distance'] as Map<String, dynamic>;
      final distanceMeters = distance['value'] as int;
      final distanceText = distance['text'] as String;

      return DirectionsResult(
        durationMinutes: (durationSeconds / 60).ceil(),
        distanceKm: distanceMeters / 1000,
        durationText: durationText,
        distanceText: distanceText,
        isApproximate: false,
      );
    } catch (e) {
      // En caso de error, calcular aproximacion
      return _calculateApproximateDirections(
        originLat: originLat,
        originLng: originLng,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
      );
    }
  }

  /// Calcula direcciones aproximadas basadas en distancia lineal
  ///
  /// Usa formula de Haversine para calcular distancia
  /// y estima tiempo basado en velocidad promedio de 25 km/h en ciudad
  DirectionsResult _calculateApproximateDirections({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) {
    // Calcular distancia usando formula de Haversine
    const double earthRadius = 6371; // km

    final dLat = _toRadians(destinationLat - originLat);
    final dLng = _toRadians(destinationLng - originLng);

    final a = _sin(dLat / 2) * _sin(dLat / 2) +
        _cos(_toRadians(originLat)) *
            _cos(_toRadians(destinationLat)) *
            _sin(dLng / 2) *
            _sin(dLng / 2);

    final c = 2 * _atan2(_sqrt(a), _sqrt(1 - a));
    final linearDistance = earthRadius * c;

    // Multiplicar por factor de ruta (las calles no son lineas rectas)
    final estimatedDistance = linearDistance * 1.3;

    // Estimar tiempo basado en velocidad promedio de 25 km/h en CDMX
    // (considerando trafico tipico)
    const averageSpeedKmh = 25.0;
    final estimatedMinutes = (estimatedDistance / averageSpeedKmh * 60).ceil();

    // Minimo 5 minutos
    final finalMinutes = estimatedMinutes < 5 ? 5 : estimatedMinutes;

    return DirectionsResult(
      durationMinutes: finalMinutes,
      distanceKm: estimatedDistance,
      durationText: '$finalMinutes min (aprox)',
      distanceText: '${estimatedDistance.toStringAsFixed(1)} km (aprox)',
      isApproximate: true,
    );
  }

  // Funciones matematicas helper
  double _toRadians(double degrees) => degrees * 3.141592653589793 / 180;
  double _sin(double x) => _sinApprox(x);
  double _cos(double x) => _cosApprox(x);
  double _sqrt(double x) => _sqrtApprox(x);
  double _atan2(double y, double x) => _atan2Approx(y, x);

  // Aproximaciones matematicas (evita dependencias)
  double _sinApprox(double x) {
    // Normalizar a [-pi, pi]
    const pi = 3.141592653589793;
    while (x > pi) x -= 2 * pi;
    while (x < -pi) x += 2 * pi;
    // Taylor series
    double result = x;
    double term = x;
    for (int i = 1; i <= 7; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  double _cosApprox(double x) => _sinApprox(x + 3.141592653589793 / 2);

  double _sqrtApprox(double x) {
    if (x <= 0) return 0;
    double guess = x / 2;
    for (int i = 0; i < 10; i++) {
      guess = (guess + x / guess) / 2;
    }
    return guess;
  }

  double _atan2Approx(double y, double x) {
    const pi = 3.141592653589793;
    if (x > 0) return _atanApprox(y / x);
    if (x < 0 && y >= 0) return _atanApprox(y / x) + pi;
    if (x < 0 && y < 0) return _atanApprox(y / x) - pi;
    if (x == 0 && y > 0) return pi / 2;
    if (x == 0 && y < 0) return -pi / 2;
    return 0;
  }

  double _atanApprox(double x) {
    // Aproximacion polinomica
    if (x.abs() > 1) {
      return (x > 0 ? 1 : -1) * (3.141592653589793 / 2 - _atanApprox(1 / x.abs()));
    }
    final x2 = x * x;
    return x * (1 - x2 * (0.333333333 - x2 * (0.2 - x2 * 0.142857143)));
  }
}

/// Resultado de la consulta de direcciones
class DirectionsResult {
  /// Duracion estimada en minutos
  final int durationMinutes;

  /// Distancia en kilometros
  final double distanceKm;

  /// Texto de duracion (ej: "25 mins")
  final String durationText;

  /// Texto de distancia (ej: "8.5 km")
  final String distanceText;

  /// Si es true, los valores son aproximados (no de Google)
  final bool isApproximate;

  const DirectionsResult({
    required this.durationMinutes,
    required this.distanceKm,
    required this.durationText,
    required this.distanceText,
    required this.isApproximate,
  });

  /// Calcula el precio del viaje rapido
  /// 50 MXN por cada 10 minutos
  double calculateQuickTripPrice({double serviceMultiplier = 1.0}) {
    final basePriceBlocks = (durationMinutes / 10).ceil();
    final basePrice = basePriceBlocks * 50.0;
    return basePrice * serviceMultiplier;
  }

  @override
  String toString() =>
      'DirectionsResult(duration: $durationMinutes min, distance: ${distanceKm.toStringAsFixed(1)} km, approximate: $isApproximate)';
}
