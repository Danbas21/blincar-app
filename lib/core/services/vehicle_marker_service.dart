// lib/core/services/vehicle_marker_service.dart

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Colores de vehículo disponibles
enum VehicleColor {
  white,
  black,
}

/// Servicio para generar marcadores de vehículo personalizados
///
/// Genera íconos de camioneta tipo Suburban que pueden ser:
/// - Blancas o negras
/// - Rotadas según el heading del GPS
class VehicleMarkerService {
  static final VehicleMarkerService _instance = VehicleMarkerService._internal();
  factory VehicleMarkerService() => _instance;
  VehicleMarkerService._internal();

  // Cache de marcadores para evitar regenerar constantemente
  final Map<String, BitmapDescriptor> _markerCache = {};

  /// Genera un BitmapDescriptor para una camioneta
  ///
  /// [color] - Color del vehículo (blanco o negro)
  /// [heading] - Ángulo de rotación en grados (0-360, donde 0 es norte)
  /// [size] - Tamaño del marcador en píxeles
  Future<BitmapDescriptor> getVehicleMarker({
    required VehicleColor color,
    required double heading,
    double size = 80,
  }) async {
    // Redondear heading a múltiplos de 5 para mejorar caching
    final roundedHeading = (heading / 5).round() * 5;
    final cacheKey = '${color.name}_${roundedHeading}_$size';

    if (_markerCache.containsKey(cacheKey)) {
      return _markerCache[cacheKey]!;
    }

    final marker = await _createVehicleMarker(color, roundedHeading.toDouble(), size);
    _markerCache[cacheKey] = marker;
    return marker;
  }

  /// Crea el marcador dibujando una camioneta tipo SUV/Suburban
  Future<BitmapDescriptor> _createVehicleMarker(
    VehicleColor vehicleColor,
    double heading,
    double size,
  ) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();

    // Colores base según el color del vehículo
    final Color bodyColor;
    final Color windowColor;
    final Color accentColor;
    final Color shadowColor;

    if (vehicleColor == VehicleColor.white) {
      bodyColor = const Color(0xFFF5F5F5);
      windowColor = const Color(0xFF1A237E).withValues(alpha: 0.7);
      accentColor = const Color(0xFFE0E0E0);
      shadowColor = const Color(0xFFBDBDBD);
    } else {
      bodyColor = const Color(0xFF1A1A1A);
      windowColor = const Color(0xFF37474F).withValues(alpha: 0.8);
      accentColor = const Color(0xFF333333);
      shadowColor = const Color(0xFF0D0D0D);
    }

    // Guardar estado del canvas y aplicar rotación
    canvas.save();
    canvas.translate(size / 2, size / 2);
    canvas.rotate((heading - 90) * math.pi / 180); // -90 porque el dibujo apunta a la derecha
    canvas.translate(-size / 2, -size / 2);

    // Escala para el dibujo
    final scale = size / 100;

    // ===== DIBUJAR LA CAMIONETA (vista superior) =====

    // Sombra del vehículo
    paint.color = Colors.black.withValues(alpha: 0.3);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(12 * scale, 22 * scale, 76 * scale, 58 * scale),
        Radius.circular(10 * scale),
      ),
      paint,
    );

    // Cuerpo principal de la camioneta
    paint.color = bodyColor;
    final bodyPath = Path();

    // Forma del cuerpo (vista superior de SUV)
    bodyPath.moveTo(20 * scale, 20 * scale);
    // Frente redondeado
    bodyPath.quadraticBezierTo(10 * scale, 25 * scale, 10 * scale, 35 * scale);
    bodyPath.lineTo(10 * scale, 65 * scale);
    bodyPath.quadraticBezierTo(10 * scale, 75 * scale, 20 * scale, 80 * scale);
    // Parte trasera
    bodyPath.lineTo(80 * scale, 80 * scale);
    bodyPath.quadraticBezierTo(90 * scale, 75 * scale, 90 * scale, 65 * scale);
    bodyPath.lineTo(90 * scale, 35 * scale);
    bodyPath.quadraticBezierTo(90 * scale, 25 * scale, 80 * scale, 20 * scale);
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);

    // Línea de acento lateral
    paint.color = accentColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2 * scale;
    canvas.drawLine(
      Offset(15 * scale, 50 * scale),
      Offset(85 * scale, 50 * scale),
      paint,
    );
    paint.style = PaintingStyle.fill;

    // Parabrisas frontal
    paint.color = windowColor;
    final windshieldPath = Path();
    windshieldPath.moveTo(75 * scale, 30 * scale);
    windshieldPath.quadraticBezierTo(82 * scale, 32 * scale, 82 * scale, 40 * scale);
    windshieldPath.lineTo(82 * scale, 60 * scale);
    windshieldPath.quadraticBezierTo(82 * scale, 68 * scale, 75 * scale, 70 * scale);
    windshieldPath.lineTo(70 * scale, 70 * scale);
    windshieldPath.lineTo(70 * scale, 30 * scale);
    windshieldPath.close();
    canvas.drawPath(windshieldPath, paint);

    // Ventanas laterales
    // Ventana lateral izquierda
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(25 * scale, 22 * scale, 40 * scale, 8 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );
    // Ventana lateral derecha
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(25 * scale, 70 * scale, 40 * scale, 8 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );

    // Vidrio trasero
    final rearWindowPath = Path();
    rearWindowPath.moveTo(20 * scale, 32 * scale);
    rearWindowPath.quadraticBezierTo(14 * scale, 35 * scale, 14 * scale, 42 * scale);
    rearWindowPath.lineTo(14 * scale, 58 * scale);
    rearWindowPath.quadraticBezierTo(14 * scale, 65 * scale, 20 * scale, 68 * scale);
    rearWindowPath.lineTo(25 * scale, 68 * scale);
    rearWindowPath.lineTo(25 * scale, 32 * scale);
    rearWindowPath.close();
    canvas.drawPath(rearWindowPath, paint);

    // Llantas (4 ruedas)
    paint.color = const Color(0xFF212121);
    // Llanta trasera izquierda
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(18 * scale, 14 * scale, 16 * scale, 8 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );
    // Llanta trasera derecha
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(18 * scale, 78 * scale, 16 * scale, 8 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );
    // Llanta delantera izquierda
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(66 * scale, 14 * scale, 16 * scale, 8 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );
    // Llanta delantera derecha
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(66 * scale, 78 * scale, 16 * scale, 8 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );

    // Rines de las llantas
    paint.color = const Color(0xFF424242);
    // Rin trasero izquierdo
    canvas.drawCircle(Offset(26 * scale, 18 * scale), 3 * scale, paint);
    // Rin trasero derecho
    canvas.drawCircle(Offset(26 * scale, 82 * scale), 3 * scale, paint);
    // Rin delantero izquierdo
    canvas.drawCircle(Offset(74 * scale, 18 * scale), 3 * scale, paint);
    // Rin delantero derecho
    canvas.drawCircle(Offset(74 * scale, 82 * scale), 3 * scale, paint);

    // Faros delanteros
    paint.color = const Color(0xFFFFEB3B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(84 * scale, 28 * scale, 4 * scale, 10 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(84 * scale, 62 * scale, 4 * scale, 10 * scale),
        Radius.circular(2 * scale),
      ),
      paint,
    );

    // Luces traseras
    paint.color = const Color(0xFFE53935);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(12 * scale, 28 * scale, 3 * scale, 8 * scale),
        Radius.circular(1 * scale),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(12 * scale, 64 * scale, 3 * scale, 8 * scale),
        Radius.circular(1 * scale),
      ),
      paint,
    );

    // Espejos retrovisores
    paint.color = shadowColor;
    // Espejo izquierdo
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(68 * scale, 10 * scale, 6 * scale, 4 * scale),
        Radius.circular(1 * scale),
      ),
      paint,
    );
    // Espejo derecho
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(68 * scale, 86 * scale, 6 * scale, 4 * scale),
        Radius.circular(1 * scale),
      ),
      paint,
    );

    // Parrilla frontal (para camioneta ejecutiva)
    if (vehicleColor == VehicleColor.black) {
      paint.color = const Color(0xFF616161);
    } else {
      paint.color = const Color(0xFFBDBDBD);
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(86 * scale, 42 * scale, 3 * scale, 16 * scale),
        Radius.circular(1 * scale),
      ),
      paint,
    );

    canvas.restore();

    // Convertir a imagen
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(bytes);
  }

  /// Limpia el cache de marcadores
  void clearCache() {
    _markerCache.clear();
  }
}

/// Clase para manejar animación suave del vehículo entre posiciones
class VehicleAnimationController {
  LatLng _currentPosition;
  LatLng _targetPosition;
  double _currentHeading;
  double _targetHeading;

  Timer? _animationTimer;
  final Duration animationDuration;
  final void Function(LatLng position, double heading) onUpdate;

  VehicleAnimationController({
    required LatLng initialPosition,
    required double initialHeading,
    required this.onUpdate,
    this.animationDuration = const Duration(milliseconds: 1000),
  })  : _currentPosition = initialPosition,
        _targetPosition = initialPosition,
        _currentHeading = initialHeading,
        _targetHeading = initialHeading;

  /// Actualiza la posición objetivo (el vehículo se animará hacia allí)
  void updateTarget(LatLng newPosition, double newHeading) {
    _targetPosition = newPosition;
    _targetHeading = newHeading;
    _startAnimation();
  }

  void _startAnimation() {
    _animationTimer?.cancel();

    final startPosition = _currentPosition;
    final startHeading = _currentHeading;
    final startTime = DateTime.now();

    _animationTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final elapsed = DateTime.now().difference(startTime);
      final progress = (elapsed.inMilliseconds / animationDuration.inMilliseconds).clamp(0.0, 1.0);

      // Ease out cubic para movimiento más natural
      final easedProgress = (1 - math.pow(1 - progress, 3)).toDouble();

      // Interpolar posición
      _currentPosition = LatLng(
        _lerp(startPosition.latitude, _targetPosition.latitude, easedProgress),
        _lerp(startPosition.longitude, _targetPosition.longitude, easedProgress),
      );

      // Interpolar heading (considerando que es circular 0-360)
      _currentHeading = _lerpAngle(startHeading, _targetHeading, easedProgress);

      onUpdate(_currentPosition, _currentHeading);

      if (progress >= 1.0) {
        timer.cancel();
      }
    });
  }

  double _lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  double _lerpAngle(double a, double b, double t) {
    // Normalizar ángulos a 0-360
    a = a % 360;
    b = b % 360;

    // Encontrar la dirección más corta
    double diff = b - a;
    if (diff > 180) diff -= 360;
    if (diff < -180) diff += 360;

    return (a + diff * t) % 360;
  }

  LatLng get currentPosition => _currentPosition;
  double get currentHeading => _currentHeading;

  void dispose() {
    _animationTimer?.cancel();
  }
}
