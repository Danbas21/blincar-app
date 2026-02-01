// lib/core/services/google_directions_service.dart

import 'dart:convert';
import 'dart:math' as math;
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
  /// Obtiene la ruta y duracion entre dos puntos
  ///
  /// Primero intenta usar el backend (que tiene el API key restringido por IP)
  /// Si falla, usa calculo aproximado con formula Haversine
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
    // Intentar primero con el backend (que tiene el API key con IP restringida)
    try {
      final backendResult = await _getDirectionsFromBackend(
        originLat: originLat,
        originLng: originLng,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
      );
      if (backendResult != null) {
        return backendResult;
      }
    } catch (e) {
      // Si falla el backend, continuar con aproximacion
    }

    // Fallback: calcular aproximacion
    return _calculateApproximateDirections(
      originLat: originLat,
      originLng: originLng,
      destinationLat: destinationLat,
      destinationLng: destinationLng,
    );
  }

  /// Obtiene direcciones desde el backend de Blincar
  /// El backend usa el API key de Google Maps restringido por IP
  Future<DirectionsResult?> _getDirectionsFromBackend({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    try {
      final baseUrl = EnvConfig.apiBaseUrl;
      final url = Uri.parse(
        '$baseUrl/api/routes/directions?originLat=$originLat&originLng=$originLng&destinationLat=$destinationLat&destinationLng=$destinationLng',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Timeout'),
      );

      if (response.statusCode != 200) {
        return null;
      }

      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data['success'] != true || data['data'] == null) {
        return null;
      }

      final routeData = data['data'] as Map<String, dynamic>;

      return DirectionsResult(
        durationMinutes: routeData['durationMinutes'] as int,
        distanceKm: (routeData['distanceKm'] as num).toDouble(),
        durationText: routeData['durationText'] as String,
        distanceText: routeData['distanceText'] as String,
        isApproximate: routeData['isApproximate'] as bool? ?? false,
      );
    } catch (e) {
      return null;
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
    // Calcular distancia usando formula de Haversine (con funciones math reales)
    const double earthRadius = 6371; // km

    final dLat = _toRadians(destinationLat - originLat);
    final dLng = _toRadians(destinationLng - originLng);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(originLat)) *
            math.cos(_toRadians(destinationLat)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
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

  // Funcion helper para convertir grados a radianes
  double _toRadians(double degrees) => degrees * math.pi / 180;
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
