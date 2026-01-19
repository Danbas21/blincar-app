// lib/presentation/pages/monitor/monitor_dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/trip/trip_entity.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/errors/failures.dart';
import 'assign_trip_dialog.dart';

class MonitorDashboardPage extends StatefulWidget {
  const MonitorDashboardPage({super.key});

  @override
  State<MonitorDashboardPage> createState() => _MonitorDashboardPageState();
}

class _MonitorDashboardPageState extends State<MonitorDashboardPage>
    with SingleTickerProviderStateMixin {
  final TripRepository _tripRepository = getIt<TripRepository>();

  late TabController _tabController;
  StreamSubscription? _tripsSubscription;

  List<TripEntity> _pendingTrips = [];
  List<TripEntity> _activeTrips = [];
  List<TripEntity> _completedTrips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _listenToAllTrips();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tripsSubscription?.cancel();
    super.dispose();
  }

  void _listenToAllTrips() {
    _log('Iniciando escucha de viajes...');

    // Escuchar trips pendientes en tiempo real
    _tripRepository.watchPendingRequests().listen(
      (result) {
        result.fold(
          (failure) {
            _log('ERROR watchPendingRequests: ${failure.message}');
          },
          (trips) {
            _log('Viajes pendientes recibidos: ${trips.length}');
            if (mounted) {
              setState(() {
                _pendingTrips = trips;
              });
            }
          },
        );
      },
      onError: (error) {
        _log('ERROR en stream pendientes: $error');
      },
    );

    // Escuchar trips activos en tiempo real
    _tripRepository.watchActiveTrips().listen(
      (result) {
        result.fold(
          (failure) {
            _log('ERROR watchActiveTrips: ${failure.message}');
          },
          (trips) {
            _log('Viajes activos recibidos: ${trips.length}');
            if (mounted) {
              setState(() {
                _activeTrips = trips
                    .where((t) =>
                        t.status == TripStatus.assigned ||
                        t.status == TripStatus.inProgress)
                    .toList();
                _completedTrips = trips
                    .where((t) => t.status == TripStatus.completed)
                    .toList();
              });
            }
          },
        );
      },
      onError: (error) {
        _log('ERROR en stream activos: $error');
      },
    );

    // Cargar inicial
    _loadTripsFromFirebase();
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[MonitorDashboard] $message');
    }
  }

  Future<void> _loadTripsFromFirebase() async {
    _log('Cargando viajes desde Firebase...');
    setState(() => _isLoading = true);

    // Cargar pendientes
    final pendingResult = await _tripRepository.getPendingRequests();
    pendingResult.fold(
      (failure) {
        _log('ERROR getPendingRequests: ${failure.message}');
      },
      (trips) {
        _log('Carga inicial - Pendientes: ${trips.length}');
        for (var t in trips) {
          _log('  - Trip: ${t.id} | ${t.userName} | ${t.status.name}');
        }
        if (mounted) {
          setState(() {
            _pendingTrips = trips;
          });
        }
      },
    );

    // Cargar activos y completados
    final activeResult = await _tripRepository.getActiveTrips();
    activeResult.fold(
      (failure) {
        _log('ERROR getActiveTrips: ${failure.message}');
        if (mounted) {
          setState(() => _isLoading = false);
        }
      },
      (trips) {
        _log('Carga inicial - Activos: ${trips.length}');
        if (mounted) {
          setState(() {
            _activeTrips = trips
                .where((t) =>
                    t.status == TripStatus.assigned ||
                    t.status == TripStatus.inProgress)
                .toList();
            _completedTrips = trips
                .where((t) => t.status == TripStatus.completed)
                .toList();
            _isLoading = false;
          });
        }
      },
    );
  }

  Future<void> _refreshTrips() async {
    await _loadTripsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Monitor - Dashboard'),
        backgroundColor: AppTheme.primaryColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: const Icon(Icons.pending_actions),
              text: 'Pendientes (${_pendingTrips.length})',
            ),
            Tab(
              icon: const Icon(Icons.directions_car),
              text: 'Activos (${_activeTrips.length})',
            ),
            Tab(
              icon: const Icon(Icons.check_circle),
              text: 'Completados (${_completedTrips.length})',
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshTrips,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildPendingTripsTab(),
                _buildActiveTripsTab(),
                _buildCompletedTripsTab(),
              ],
            ),
    );
  }

  Widget _buildPendingTripsTab() {
    if (_pendingTrips.isEmpty) {
      return _buildEmptyState(
        icon: Icons.pending_actions,
        title: 'No hay solicitudes pendientes',
        subtitle: 'Las nuevas solicitudes aparecerán aquí',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshTrips,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _pendingTrips.length,
        itemBuilder: (context, index) {
          final trip = _pendingTrips[index];
          return _buildTripCard(trip, isPending: true);
        },
      ),
    );
  }

  Widget _buildActiveTripsTab() {
    if (_activeTrips.isEmpty) {
      return _buildEmptyState(
        icon: Icons.directions_car,
        title: 'No hay viajes activos',
        subtitle: 'Los viajes asignados aparecerán aquí',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshTrips,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _activeTrips.length,
        itemBuilder: (context, index) {
          final trip = _activeTrips[index];
          return _buildTripCard(trip, isPending: false);
        },
      ),
    );
  }

  Widget _buildCompletedTripsTab() {
    if (_completedTrips.isEmpty) {
      return _buildEmptyState(
        icon: Icons.check_circle,
        title: 'No hay viajes completados',
        subtitle: 'Los viajes finalizados aparecerán aquí',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshTrips,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _completedTrips.length,
        itemBuilder: (context, index) {
          final trip = _completedTrips[index];
          return _buildTripCard(trip, isPending: false);
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: AppTheme.textSecondaryColor),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTripCard(TripEntity trip, {required bool isPending}) {
    return Card(
      color: AppTheme.surfaceColor,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isPending
            ? () => _showAssignDialog(trip)
            : () => _showTripDetails(trip),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(trip.status).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      trip.status.displayName,
                      style: TextStyle(
                        color: _getStatusColor(trip.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${trip.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppTheme.primaryLightColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Usuario
              Row(
                children: [
                  const Icon(Icons.person,
                      color: AppTheme.textSecondaryColor, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    trip.userName,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Ruta
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.route,
                      color: AppTheme.textSecondaryColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.route.origin.name,
                          style: const TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Icon(Icons.arrow_downward,
                            size: 12, color: AppTheme.textSecondaryColor),
                        Text(
                          trip.route.destination.name,
                          style: const TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Info adicional
              Row(
                children: [
                  const Icon(Icons.straighten,
                      color: AppTheme.textSecondaryColor, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${trip.route.distanceKm.toStringAsFixed(1)} km',
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time,
                      color: AppTheme.textSecondaryColor, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(trip.requestedAt),
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              // Conductor (si está asignado)
              if (trip.driverName != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_taxi,
                        color: AppTheme.successColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '${trip.driverName} - ${trip.vehiclePlate ?? "N/A"}',
                      style: const TextStyle(
                        color: AppTheme.successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],

              // Botón de acción
              if (isPending) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showAssignDialog(trip),
                    icon: const Icon(Icons.assignment_ind),
                    label: const Text('Asignar Conductor'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.pending:
        return AppTheme.warningColor;
      case TripStatus.assigned:
        return AppTheme.primaryLightColor;
      case TripStatus.inProgress:
        return AppTheme.successColor;
      case TripStatus.completed:
        return AppTheme.successColor;
      case TripStatus.cancelled:
        return AppTheme.errorColor;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) {
      return 'Hace un momento';
    } else if (diff.inMinutes < 60) {
      return 'Hace ${diff.inMinutes} min';
    } else if (diff.inHours < 24) {
      return 'Hace ${diff.inHours}h';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  void _showAssignDialog(TripEntity trip) {
    showDialog(
      context: context,
      builder: (context) => AssignTripDialog(trip: trip),
    ).then((assigned) {
      if (assigned == true) {
        _refreshTrips();
      }
    });
  }

  void _showTripDetails(TripEntity trip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          'Detalles del Viaje',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Usuario', trip.userName),
            _buildDetailRow('Teléfono', trip.userPhone),
            _buildDetailRow('Estado', trip.status.displayName),
            if (trip.driverName != null)
              _buildDetailRow('Conductor', trip.driverName!),
            if (trip.vehiclePlate != null)
              _buildDetailRow('Vehículo', trip.vehiclePlate!),
            _buildDetailRow('Precio', '\$${trip.totalPrice}'),
            _buildDetailRow('Distancia', '${trip.route.distanceKm} km'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
