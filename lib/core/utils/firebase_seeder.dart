// lib/core/utils/firebase_seeder.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

/// Utilidad para cargar datos iniciales (seed data) en Firebase Realtime Database
///
/// IMPORTANTE: Solo ejecutar en desarrollo, NUNCA en produccion.
class FirebaseSeeder {
  final FirebaseDatabase _database;

  FirebaseSeeder({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  /// Carga todos los datos desde el archivo JSON
  Future<bool> seedDatabase() async {
    try {
      final jsonString =
          await rootBundle.loadString('firebase_seed_data.json');
      final Map<String, dynamic> data = json.decode(jsonString);

      // Verificar si ya existen datos
      final snapshot = await _database.ref('blincar').get();
      if (snapshot.exists) {
        await _database.ref('blincar').remove();
      }

      // Cargar datos en Firebase
      await _database.ref().set(data);

      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error durante el seed: $e');
        debugPrint('Stack trace: $stackTrace');
      }
      return false;
    }
  }

  /// Carga solo vehiculos
  Future<bool> seedVehicles() async {
    try {
      final jsonString =
          await rootBundle.loadString('firebase_seed_data.json');
      final Map<String, dynamic> data = json.decode(jsonString);

      await _database
          .ref('blincar/vehicles')
          .set(data['blincar']['vehicles']);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Carga solo conductores
  Future<bool> seedDrivers() async {
    try {
      final jsonString =
          await rootBundle.loadString('firebase_seed_data.json');
      final Map<String, dynamic> data = json.decode(jsonString);

      await _database.ref('blincar/drivers').set(data['blincar']['drivers']);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Carga solo paquetes de servicio
  Future<bool> seedServicePackages() async {
    try {
      final jsonString =
          await rootBundle.loadString('firebase_seed_data.json');
      final Map<String, dynamic> data = json.decode(jsonString);

      await _database
          .ref('blincar/servicePackages')
          .set(data['blincar']['servicePackages']);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Limpia todos los datos de la base de datos
  ///
  /// PELIGRO: Esto eliminara TODOS los datos. Solo usar en desarrollo.
  Future<bool> clearDatabase() async {
    try {
      await _database.ref('blincar').remove();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Obtiene conteo de datos cargados
  Future<Map<String, int>> getDataCounts() async {
    final counts = <String, int>{};

    final vehiclesSnapshot = await _database.ref('blincar/vehicles').get();
    counts['vehicles'] = vehiclesSnapshot.exists
        ? (vehiclesSnapshot.value as Map).length
        : 0;

    final driversSnapshot = await _database.ref('blincar/drivers').get();
    counts['drivers'] = driversSnapshot.exists
        ? (driversSnapshot.value as Map).length
        : 0;

    final packagesSnapshot = await _database.ref('blincar/servicePackages').get();
    counts['servicePackages'] = packagesSnapshot.exists
        ? (packagesSnapshot.value as Map).length
        : 0;

    return counts;
  }
}
