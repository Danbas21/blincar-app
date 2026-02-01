// lib/core/services/vehicle_marker_service.dart

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Colores de vehículo disponibles
enum VehicleColor {
  white,
  black,
}

/// Tipo de vehículo
enum VehicleType {
  escalade,
  explorer,
  tahoe,
  tahoeLs,
  rangeRover,
}

/// Servicio para generar marcadores de vehículo personalizados desde imágenes PNG
///
/// Utiliza imágenes PNG de vista superior de vehículos reales que pueden ser:
/// - Rotadas según el heading del GPS
/// - Cacheadas para mejor rendimiento
class VehicleMarkerService {
  static final VehicleMarkerService _instance = VehicleMarkerService._internal();
  factory VehicleMarkerService() => _instance;
  VehicleMarkerService._internal();

  // Cache de marcadores para evitar regenerar constantemente
  final Map<String, BitmapDescriptor> _markerCache = {};

  // Cache de imágenes base cargadas desde assets
  final Map<String, ui.Image> _imageCache = {};

  /// Mapa de tipos de vehículo a rutas de assets
  static const Map<String, String> _vehicleAssets = {
    'escalade_white': 'assets/vehicle/Cadillac Escalade_white.png',
    'explorer_white': 'assets/vehicle/Ford Explorer SUV_white.png',
    'tahoe_white': 'assets/vehicle/Chevrolet Tahoe SUV_white.png',
    'tahoe_black': 'assets/vehicle/Chevrolet Tahoe LS SUV_black.png',
    'rangerover_black': 'assets/vehicle/Land Rover Range Rover_black.png',
  };

  /// Obtiene el asset key según tipo y color de vehículo
  String _getAssetKey(VehicleType type, VehicleColor color) {
    switch (type) {
      case VehicleType.escalade:
        return 'escalade_white';
      case VehicleType.explorer:
        return 'explorer_white';
      case VehicleType.tahoe:
        return color == VehicleColor.white ? 'tahoe_white' : 'tahoe_black';
      case VehicleType.tahoeLs:
        return 'tahoe_black';
      case VehicleType.rangeRover:
        return 'rangerover_black';
    }
  }

  /// Genera un BitmapDescriptor para un vehículo desde imagen PNG
  ///
  /// [type] - Tipo de vehículo (Escalade, Explorer, Tahoe, etc.)
  /// [color] - Color del vehículo (blanco o negro)
  /// [heading] - Ángulo de rotación en grados (0-360, donde 0 es norte)
  /// [size] - Tamaño del marcador en píxeles
  Future<BitmapDescriptor> getVehicleMarker({
    VehicleType type = VehicleType.tahoe,
    VehicleColor color = VehicleColor.white,
    required double heading,
    double size = 80,
  }) async {
    // Redondear heading a múltiplos de 5 para mejorar caching
    final roundedHeading = (heading / 5).round() * 5;
    final assetKey = _getAssetKey(type, color);
    final cacheKey = '${assetKey}_${roundedHeading}_$size';

    if (_markerCache.containsKey(cacheKey)) {
      return _markerCache[cacheKey]!;
    }

    // Cargar imagen base si no está en cache
    if (!_imageCache.containsKey(assetKey)) {
      await _loadImage(assetKey);
    }

    final marker = await _createRotatedMarker(
      assetKey,
      roundedHeading.toDouble(),
      size,
    );

    _markerCache[cacheKey] = marker;
    return marker;
  }

  /// Carga una imagen desde assets al cache
  Future<void> _loadImage(String assetKey) async {
    final assetPath = _vehicleAssets[assetKey];
    if (assetPath == null) {
      debugPrint('[VehicleMarker] ❌ Asset not found for key: $assetKey');
      throw Exception('Asset not found for key: $assetKey');
    }

    try {
      debugPrint('[VehicleMarker] 🔄 Loading image: $assetPath');
      final byteData = await rootBundle.load(assetPath);
      final codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      _imageCache[assetKey] = frame.image;
      debugPrint('[VehicleMarker] ✅ Image loaded successfully: $assetPath');
    } catch (e) {
      debugPrint('[VehicleMarker] ❌ Error loading image $assetPath: $e');
      rethrow;
    }
  }

  /// Crea un marcador rotado desde la imagen base
  Future<BitmapDescriptor> _createRotatedMarker(
    String assetKey,
    double heading,
    double size,
  ) async {
    final baseImage = _imageCache[assetKey];
    if (baseImage == null) {
      throw Exception('Image not loaded for key: $assetKey');
    }

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    // Aplicar rotación desde el centro
    canvas.save();
    canvas.translate(size / 2, size / 2);
    // Convertir heading a radianes
    // heading 0 = Norte (arriba), necesitamos rotar
    // La imagen base apunta hacia arriba (0 grados)
    canvas.rotate(heading * math.pi / 180);
    canvas.translate(-size / 2, -size / 2);

    // Dibujar la imagen escalada al tamaño deseado
    final srcRect = Rect.fromLTWH(
      0,
      0,
      baseImage.width.toDouble(),
      baseImage.height.toDouble(),
    );
    final dstRect = Rect.fromLTWH(0, 0, size, size);

    canvas.drawImageRect(baseImage, srcRect, dstRect, paint);
    canvas.restore();

    // Convertir a BitmapDescriptor
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(bytes);
  }

  /// Pre-carga todas las imágenes de vehículos para mejor rendimiento
  Future<void> preloadAllImages() async {
    for (final assetKey in _vehicleAssets.keys) {
      if (!_imageCache.containsKey(assetKey)) {
        await _loadImage(assetKey);
      }
    }
  }

  /// Limpia el cache de marcadores (mantiene las imágenes base)
  void clearMarkerCache() {
    _markerCache.clear();
  }

  /// Limpia todo el cache incluyendo imágenes base
  void clearAllCache() {
    _markerCache.clear();
    _imageCache.clear();
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
