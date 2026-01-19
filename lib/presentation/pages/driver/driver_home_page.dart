// lib/presentation/pages/driver/driver_home_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/services/location_tracking_service.dart';

class DriverHomePage extends StatefulWidget {
  final String driverId;
  final String driverName;

  const DriverHomePage({
    super.key,
    required this.driverId,
    required this.driverName,
  });

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final _database = FirebaseDatabase.instance.ref();
  final _locationService = getIt<LocationTrackingService>();

  Map<String, dynamic>? _assignedTrip;
  bool _isLoading = true;
  StreamSubscription? _tripsSubscription;

  @override
  void initState() {
    super.initState();
    _listenToAssignedTrips();
  }

  @override
  void dispose() {
    _tripsSubscription?.cancel();
    _locationService.stopTracking(); // Detener tracking GPS
    super.dispose();
  }

  void _listenToAssignedTrips() {
    // Escuchar cambios en todos los trips donde driverId == widget.driverId
    _tripsSubscription = _database.child('blincar/trips').onValue.listen((event) {
      try {
        final tripsData = event.snapshot.value;

        if (tripsData == null) {
          if (mounted) {
            setState(() {
              _assignedTrip = null;
              _isLoading = false;
            });
          }
          return;
        }

        // Buscar trip asignado a este conductor que no esté completado
        Map<String, dynamic>? foundTrip;

        if (tripsData is Map) {
          for (var entry in tripsData.entries) {
            final tripData = entry.value;
            if (tripData is Map &&
                tripData['driverId'] == widget.driverId &&
                (tripData['status'] == 'assigned' ||
                    tripData['status'] == 'inProgress')) {
              foundTrip = {
                'id': entry.key,
                ...Map<String, dynamic>.from(tripData),
              };
              break;
            }
          }
        }

        if (mounted) {
          setState(() {
            _assignedTrip = foundTrip;
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  Future<void> _startTrip() async {
    if (_assignedTrip == null) return;

    try {
      await _database.child('blincar/trips/${_assignedTrip!['id']}').update({
        'status': 'inProgress',
        'startedAt': DateTime.now().toIso8601String(),
      });

      // 📍 INICIAR TRACKING GPS EN TIEMPO REAL
      await _locationService.startTracking(
        tripId: _assignedTrip!['id'],
        driverId: widget.driverId,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Viaje iniciado - GPS tracking activo'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al iniciar viaje: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  Future<void> _endTrip() async {
    if (_assignedTrip == null) return;

    // Confirmar antes de terminar
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          '¿Terminar viaje?',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: const Text(
          '¿Confirmas que el viaje ha finalizado?',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successColor,
            ),
            child: const Text(
              'Confirmar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      // Detener tracking GPS
      await _locationService.stopTracking();

      await _database.child('blincar/trips/${_assignedTrip!['id']}').update({
        'status': 'completed',
        'completedAt': DateTime.now().toIso8601String(),
      });

      // Marcar conductor como disponible nuevamente
      await _database
          .child('blincar/drivers/${widget.driverId}/isAvailable')
          .set(true);

      // Marcar vehículo como disponible
      final vehicleId = _assignedTrip!['vehicleId'];
      if (vehicleId != null) {
        await _database
            .child('blincar/vehicles/$vehicleId/isAvailable')
            .set(true);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Viaje completado - GPS tracking detenido'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al finalizar viaje: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Hola, ${widget.driverName.split(' ')[0]}'),
        backgroundColor: AppTheme.successColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() => _isLoading = true);
              _listenToAssignedTrips();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _assignedTrip == null
              ? _buildNoTripView()
              : _buildTripView(),
    );
  }

  Widget _buildNoTripView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.car_rental,
                size: 60,
                color: AppTheme.successColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sin viajes asignados',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Espera a que el monitor te asigne un viaje',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: AppTheme.successColor),
                  SizedBox(width: 12),
                  Text(
                    'Disponible',
                    style: TextStyle(
                      color: AppTheme.successColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripView() {
    final trip = _assignedTrip!;
    final isInProgress = trip['status'] == 'inProgress';
    final route = trip['route'] as Map;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Estado del viaje
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isInProgress
                  ? AppTheme.successColor.withValues(alpha: 0.2)
                  : AppTheme.warningColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isInProgress
                    ? AppTheme.successColor
                    : AppTheme.warningColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isInProgress ? Icons.directions_car : Icons.pending,
                  color: isInProgress
                      ? AppTheme.successColor
                      : AppTheme.warningColor,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isInProgress ? 'VIAJE EN CURSO' : 'VIAJE ASIGNADO',
                        style: TextStyle(
                          color: isInProgress
                              ? AppTheme.successColor
                              : AppTheme.warningColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isInProgress
                            ? 'Completa el viaje cuando llegues'
                            : 'Inicia el viaje cuando recojas al pasajero',
                        style: TextStyle(
                          color: isInProgress
                              ? AppTheme.successColor
                              : AppTheme.warningColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Información del pasajero
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pasajero',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLightColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip['userName'] ?? 'N/A',
                            style: const TextStyle(
                              color: AppTheme.textPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            trip['userPhone'] ?? 'N/A',
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone, color: AppTheme.successColor),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Llamando al pasajero...'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Ruta
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ruta del Viaje',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                // Origen
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppTheme.successColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Origen',
                            style: TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            route['origin']['name'] ?? 'N/A',
                            style: const TextStyle(
                              color: AppTheme.textPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            route['origin']['address'] ?? '',
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.more_vert,
                    color: AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 16),
                // Destino
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppTheme.errorColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Destino',
                            style: TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            route['destination']['name'] ?? 'N/A',
                            style: const TextStyle(
                              color: AppTheme.textPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            route['destination']['address'] ?? '',
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Detalles del viaje
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  'Distancia',
                  '${route['distanceKm']} km',
                  Icons.straighten,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  'Duración estimada',
                  '${route['estimatedDurationMinutes']} min',
                  Icons.access_time,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  'Tarifa',
                  '\$${trip['totalPrice'].toStringAsFixed(2)}',
                  Icons.payments,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  'Vehículo',
                  trip['vehiclePlate'] ?? 'N/A',
                  Icons.directions_car,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Botones de acción
          if (!isInProgress)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _startTrip,
                icon: const Icon(Icons.play_arrow, size: 28),
                label: const Text(
                  'INICIAR VIAJE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.successColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _endTrip,
                icon: const Icon(Icons.check_circle, size: 28),
                label: const Text(
                  'TERMINAR VIAJE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryLightColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
