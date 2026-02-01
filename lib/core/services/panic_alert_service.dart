// lib/core/services/panic_alert_service.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';

/// Servicio para manejar alertas de pánico
///
/// Funcionalidades:
/// - Obtener ubicación GPS actual
/// - Registrar alerta en Firebase
/// - Actualizar ubicación en tiempo real
/// - Desactivar alerta
class PanicAlertService {
  final FirebaseDatabase _database;
  String? _activeAlertId;

  PanicAlertService({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  /// Referencia a las alertas de pánico en la base de datos
  DatabaseReference get _alertsRef => _database.ref('blincar/panic_alerts');

  /// Activa una alerta de pánico
  ///
  /// Retorna el ID de la alerta creada
  Future<PanicAlertResult> activatePanicAlert({
    required User user,
    String? tripId,
  }) async {
    try {
      // 1. Obtener ubicación actual
      final position = await _getCurrentLocation();

      // 2. Crear registro de alerta en Firebase
      final alertId = _alertsRef.push().key;
      if (alertId == null) {
        return PanicAlertResult.failure('Error al crear alerta');
      }

      final alertData = {
        'id': alertId,
        'userId': user.id,
        'userName': user.fullName,
        'userPhone': user.phoneNumber,
        'userEmail': user.email,
        'emergencyContactName': user.emergencyContactName,
        'emergencyContactPhone': user.emergencyContactPhone,
        'tripId': tripId,
        'status': 'active',
        'location': position != null
            ? {
                'latitude': position.latitude,
                'longitude': position.longitude,
                'accuracy': position.accuracy,
                'altitude': position.altitude,
                'speed': position.speed,
                'heading': position.heading,
                'timestamp': position.timestamp.toIso8601String(),
              }
            : null,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'resolvedAt': null,
        'resolvedBy': null,
        'notes': null,
      };

      await _alertsRef.child(alertId).set(alertData);

      _activeAlertId = alertId;

      _debugLog('Panic alert created: $alertId');

      return PanicAlertResult.success(
        alertId: alertId,
        latitude: position?.latitude,
        longitude: position?.longitude,
      );
    } catch (e) {
      _debugLog('Error creating panic alert: $e');
      return PanicAlertResult.failure('Error al activar alerta: $e');
    }
  }

  /// Actualiza la ubicación de una alerta activa
  Future<bool> updateAlertLocation({
    required String alertId,
  }) async {
    try {
      final position = await _getCurrentLocation();
      if (position == null) return false;

      await _alertsRef.child(alertId).update({
        'location': {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'accuracy': position.accuracy,
          'altitude': position.altitude,
          'speed': position.speed,
          'heading': position.heading,
          'timestamp': position.timestamp.toIso8601String(),
        },
        'updatedAt': DateTime.now().toIso8601String(),
      });

      _debugLog('Alert location updated: $alertId');
      return true;
    } catch (e) {
      _debugLog('Error updating alert location: $e');
      return false;
    }
  }

  /// Desactiva una alerta de pánico
  Future<bool> deactivatePanicAlert({
    required String alertId,
    String? resolvedBy,
    String? notes,
  }) async {
    try {
      await _alertsRef.child(alertId).update({
        'status': 'resolved',
        'resolvedAt': DateTime.now().toIso8601String(),
        'resolvedBy': resolvedBy ?? 'user',
        'notes': notes,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      _activeAlertId = null;

      _debugLog('Panic alert resolved: $alertId');
      return true;
    } catch (e) {
      _debugLog('Error resolving panic alert: $e');
      return false;
    }
  }

  /// Agrega una nota a una alerta existente
  Future<bool> addNoteToAlert({
    required String alertId,
    required String note,
  }) async {
    try {
      final noteRef = _alertsRef.child(alertId).child('timeline').push();
      await noteRef.set({
        'type': 'note',
        'content': note,
        'timestamp': DateTime.now().toIso8601String(),
      });

      _debugLog('Note added to alert: $alertId');
      return true;
    } catch (e) {
      _debugLog('Error adding note to alert: $e');
      return false;
    }
  }

  /// Obtiene el ID de la alerta activa
  String? get activeAlertId => _activeAlertId;

  /// Verifica si hay una alerta activa
  bool get hasActiveAlert => _activeAlertId != null;

  /// Obtiene la ubicación actual del dispositivo
  Future<Position?> _getCurrentLocation() async {
    try {
      // Verificar si el servicio de ubicación está habilitado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _debugLog('Location services are disabled');
        return null;
      }

      // Verificar permisos
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _debugLog('Location permissions are denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _debugLog('Location permissions are permanently denied');
        return null;
      }

      // Obtener ubicación con alta precisión
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      _debugLog('Location obtained: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      _debugLog('Error getting location: $e');
      return null;
    }
  }

  /// Log condicional - solo muestra en debug
  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[PanicAlertService] $message');
    }
  }
}

/// Resultado de una operación de alerta de pánico
class PanicAlertResult {
  final bool isSuccess;
  final String? alertId;
  final double? latitude;
  final double? longitude;
  final String? errorMessage;

  PanicAlertResult._({
    required this.isSuccess,
    this.alertId,
    this.latitude,
    this.longitude,
    this.errorMessage,
  });

  factory PanicAlertResult.success({
    required String alertId,
    double? latitude,
    double? longitude,
  }) {
    return PanicAlertResult._(
      isSuccess: true,
      alertId: alertId,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory PanicAlertResult.failure(String message) {
    return PanicAlertResult._(
      isSuccess: false,
      errorMessage: message,
    );
  }
}
