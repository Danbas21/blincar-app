// lib/core/services/location_tracking_service.dart

import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

/// Servicio para tracking GPS en tiempo real del conductor
class LocationTrackingService {
  final FirebaseDatabase _database;
  StreamSubscription<Position>? _positionStream;
  String? _activeTripId;
  String? _driverId;

  LocationTrackingService({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  /// Inicia el tracking GPS para un viaje activo
  Future<bool> startTracking({
    required String tripId,
    required String driverId,
  }) async {
    _activeTripId = tripId;
    _driverId = driverId;

    // Verificar permisos de ubicacion
    bool hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      return false;
    }

    // Configurar stream de ubicacion
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Actualizar cada 10 metros
    );

    // Escuchar cambios de ubicacion
    _positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        _updateLocationInFirebase(position);
      },
      onError: (error) {
        // Error silencioso en produccion
      },
    );

    return true;
  }

  /// Detiene el tracking GPS
  Future<void> stopTracking() async {
    await _positionStream?.cancel();
    _positionStream = null;

    // Limpiar ubicacion en Firebase
    if (_activeTripId != null) {
      await _database
          .ref('blincar/trips/$_activeTripId/currentLocation')
          .remove();
    }

    _activeTripId = null;
    _driverId = null;
  }

  /// Actualiza la ubicacion en Firebase
  Future<void> _updateLocationInFirebase(Position position) async {
    if (_activeTripId == null) return;

    try {
      final locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'heading': position.heading,
        'speed': position.speed,
        'accuracy': position.accuracy,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      // Actualizar en el trip
      await _database
          .ref('blincar/trips/$_activeTripId/currentLocation')
          .set(locationData);

      // Tambien actualizar en el driver (opcional)
      if (_driverId != null) {
        await _database
            .ref('blincar/drivers/$_driverId/currentLocation')
            .set(locationData);
      }
    } catch (_) {
      // Error silencioso en produccion
    }
  }

  /// Verifica y solicita permisos de ubicacion
  Future<bool> _checkLocationPermission() async {
    // Verificar si el servicio de ubicacion esta habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Verificar permisos
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Obtiene la ubicacion actual una sola vez
  Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await _checkLocationPermission();
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (_) {
      return null;
    }
  }

  /// Verifica si el tracking esta activo
  bool get isTracking => _positionStream != null;
}
