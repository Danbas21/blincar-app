// lib/presentation/pages/monitor/assign_trip_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/trip/trip_entity.dart';

class AssignTripDialog extends StatefulWidget {
  final TripEntity trip;

  const AssignTripDialog({
    super.key,
    required this.trip,
  });

  @override
  State<AssignTripDialog> createState() => _AssignTripDialogState();
}

class _AssignTripDialogState extends State<AssignTripDialog> {
  final _database = FirebaseDatabase.instance.ref();

  List<Map<String, dynamic>> _drivers = [];
  List<Map<String, dynamic>> _vehicles = [];

  String? _selectedDriverId;
  String? _selectedVehicleId;

  bool _isLoading = true;
  bool _isAssigning = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _log('Cargando conductores de blincar/drivers...');

      // Cargar conductores
      final driversSnapshot =
          await _database.child('blincar/drivers').once();
      final driversData = driversSnapshot.snapshot.value as Map?;

      _log('Conductores snapshot.exists: ${driversSnapshot.snapshot.exists}');
      _log('Conductores data: $driversData');

      if (driversData != null) {
        _drivers = driversData.entries
            .where((e) => (e.value as Map)['isAvailable'] == true)
            .map((e) {
          final data = e.value as Map;
          return {
            'id': e.key,
            'fullName': data['fullName'] ?? '',
            'phoneNumber': data['phoneNumber'] ?? '',
            'email': data['email'] ?? '',
            'licenseNumber': data['licenseNumber'] ?? '',
            'rating': data['rating'] ?? 0.0,
          };
        }).toList();
      }

      _log('Conductores disponibles: ${_drivers.length}');

      _log('Cargando vehículos de blincar/vehicles...');

      // Cargar vehículos
      final vehiclesSnapshot =
          await _database.child('blincar/vehicles').once();
      final vehiclesData = vehiclesSnapshot.snapshot.value as Map?;

      _log('Vehículos snapshot.exists: ${vehiclesSnapshot.snapshot.exists}');
      _log('Vehículos data: $vehiclesData');

      if (vehiclesData != null) {
        _vehicles = vehiclesData.entries
            .where((e) => (e.value as Map)['isAvailable'] == true)
            .map((e) {
          final data = e.value as Map;
          return {
            'id': e.key,
            'licensePlate': data['licensePlate'] ?? '',
            'brand': data['brand'] ?? '',
            'model': data['model'] ?? '',
            'year': data['year'] ?? '',
            'type': data['type'] ?? '',
          };
        }).toList();
      }

      _log('Vehículos disponibles: ${_vehicles.length}');

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      _log('ERROR cargando datos: $e');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: $e')),
        );
      }
    }
  }

  /// Crea datos de prueba en Firebase (conductores y vehículos)
  Future<void> _createTestData() async {
    _log('Creando datos de prueba...');

    try {
      // Crear conductores de prueba
      final drivers = {
        'driver_001': {
          'fullName': 'Carlos Mendoza',
          'phoneNumber': '+52 55 1234 5678',
          'email': 'carlos.mendoza@blincar.com',
          'licenseNumber': 'LIC-001',
          'rating': 4.8,
          'isAvailable': true,
        },
        'driver_002': {
          'fullName': 'Roberto García',
          'phoneNumber': '+52 55 2345 6789',
          'email': 'roberto.garcia@blincar.com',
          'licenseNumber': 'LIC-002',
          'rating': 4.9,
          'isAvailable': true,
        },
        'driver_003': {
          'fullName': 'Miguel Ángel Torres',
          'phoneNumber': '+52 55 3456 7890',
          'email': 'miguel.torres@blincar.com',
          'licenseNumber': 'LIC-003',
          'rating': 4.7,
          'isAvailable': true,
        },
      };

      // Crear vehículos de prueba
      final vehicles = {
        'vehicle_001': {
          'licensePlate': 'ABC-123',
          'brand': 'Chevrolet',
          'model': 'Suburban',
          'year': '2023',
          'type': 'SUV Blindada',
          'isAvailable': true,
        },
        'vehicle_002': {
          'licensePlate': 'DEF-456',
          'brand': 'Chevrolet',
          'model': 'Suburban',
          'year': '2024',
          'type': 'SUV Blindada',
          'isAvailable': true,
        },
        'vehicle_003': {
          'licensePlate': 'GHI-789',
          'brand': 'Ford',
          'model': 'Expedition',
          'year': '2023',
          'type': 'SUV Blindada',
          'isAvailable': true,
        },
      };

      await _database.child('blincar/drivers').set(drivers);
      await _database.child('blincar/vehicles').set(vehicles);

      _log('Datos de prueba creados exitosamente');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Datos de prueba creados'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }

      // Recargar datos
      await _loadData();
    } catch (e) {
      _log('ERROR creando datos de prueba: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  /// Resetea la disponibilidad de todos los conductores y vehículos
  Future<void> _resetAvailability() async {
    _log('Reseteando disponibilidad...');

    try {
      // Obtener todos los conductores y marcarlos como disponibles
      final driversSnapshot = await _database.child('blincar/drivers').once();
      final driversData = driversSnapshot.snapshot.value as Map?;

      if (driversData != null) {
        for (final driverId in driversData.keys) {
          await _database
              .child('blincar/drivers/$driverId/isAvailable')
              .set(true);
          _log('Conductor $driverId → isAvailable: true');
        }
      }

      // Obtener todos los vehículos y marcarlos como disponibles
      final vehiclesSnapshot = await _database.child('blincar/vehicles').once();
      final vehiclesData = vehiclesSnapshot.snapshot.value as Map?;

      if (vehiclesData != null) {
        for (final vehicleId in vehiclesData.keys) {
          await _database
              .child('blincar/vehicles/$vehicleId/isAvailable')
              .set(true);
          _log('Vehículo $vehicleId → isAvailable: true');
        }
      }

      _log('Disponibilidad reseteada exitosamente');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Disponibilidad reseteada'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }

      // Recargar datos
      await _loadData();
    } catch (e) {
      _log('ERROR reseteando disponibilidad: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[AssignTripDialog] $message');
    }
  }

  Future<void> _assignTrip() async {
    if (_selectedDriverId == null || _selectedVehicleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona un conductor y un vehículo'),
        ),
      );
      return;
    }

    setState(() => _isAssigning = true);

    try {
      final driver =
          _drivers.firstWhere((d) => d['id'] == _selectedDriverId);
      final vehicle =
          _vehicles.firstWhere((v) => v['id'] == _selectedVehicleId);

      // Actualizar trip en Firebase
      await _database.child('blincar/trips/${widget.trip.id}').update({
        'status': 'assigned',
        'driverId': driver['id'],
        'driverName': driver['fullName'],
        'driverPhone': driver['phoneNumber'],
        'vehicleId': vehicle['id'],
        'vehiclePlate': vehicle['licensePlate'],
        'assignedAt': DateTime.now().toIso8601String(),
      });

      // Marcar conductor como no disponible
      await _database
          .child('blincar/drivers/${driver['id']}/isAvailable')
          .set(false);

      // Marcar vehículo como no disponible
      await _database
          .child('blincar/vehicles/${vehicle['id']}/isAvailable')
          .set(false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Viaje asignado exitosamente'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      Navigator.of(context).pop(true); // Retornar success
    } catch (e) {
      setState(() => _isAssigning = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al asignar viaje: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        padding: const EdgeInsets.all(24),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      const Icon(
                        Icons.assignment_ind,
                        color: AppTheme.primaryLightColor,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Asignar Viaje',
                          style: TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: AppTheme.textSecondaryColor),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Info del viaje
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Viaje de ${widget.trip.userName}',
                          style: const TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.trip.route.origin.name} → ${widget.trip.route.destination.name}',
                          style: const TextStyle(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${widget.trip.totalPrice.toStringAsFixed(2)} • ${widget.trip.route.distanceKm} km',
                          style: const TextStyle(
                            color: AppTheme.primaryLightColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Seleccionar conductor
                  const Text(
                    'Seleccionar Conductor',
                    style: TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (_drivers.isEmpty && _vehicles.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'No hay conductores ni vehículos disponibles',
                            style: TextStyle(color: AppTheme.textSecondaryColor),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _resetAvailability,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Resetear disponibilidad'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _createTestData,
                            icon: const Icon(Icons.add),
                            label: const Text('Crear datos de prueba'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.warningColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_drivers.isEmpty)
                    const Center(
                      child: Text(
                        'No hay conductores disponibles',
                        style: TextStyle(color: AppTheme.textSecondaryColor),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _drivers.length,
                        itemBuilder: (context, index) {
                          final driver = _drivers[index];
                          final isSelected =
                              _selectedDriverId == driver['id'];

                          return Card(
                            color: isSelected
                                ? AppTheme.primaryColor.withValues(alpha: 0.2)
                                : AppTheme.backgroundColor,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppTheme.primaryLightColor,
                                child: Text(
                                  driver['fullName'][0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                driver['fullName'],
                                style: const TextStyle(
                                  color: AppTheme.textPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                driver['phoneNumber'],
                                style: const TextStyle(
                                  color: AppTheme.textSecondaryColor,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppTheme.successColor,
                                    )
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedDriverId = driver['id'];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Seleccionar vehículo
                  const Text(
                    'Seleccionar Vehículo',
                    style: TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (_vehicles.isEmpty)
                    const Center(
                      child: Text(
                        'No hay vehículos disponibles',
                        style: TextStyle(color: AppTheme.textSecondaryColor),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _vehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = _vehicles[index];
                          final isSelected =
                              _selectedVehicleId == vehicle['id'];

                          return Card(
                            color: isSelected
                                ? AppTheme.primaryColor.withValues(alpha: 0.2)
                                : AppTheme.backgroundColor,
                            child: ListTile(
                              leading: const Icon(
                                Icons.directions_car,
                                color: AppTheme.primaryLightColor,
                              ),
                              title: Text(
                                '${vehicle['brand']} ${vehicle['model']} (${vehicle['year']})',
                                style: const TextStyle(
                                  color: AppTheme.textPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                'Placa: ${vehicle['licensePlate']}',
                                style: const TextStyle(
                                  color: AppTheme.textSecondaryColor,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppTheme.successColor,
                                    )
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedVehicleId = vehicle['id'];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Botones
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed:
                              _isAssigning ? null : () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _isAssigning ? null : _assignTrip,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: _isAssigning
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text('Asignar Viaje'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
