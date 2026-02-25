// lib/presentation/pages/monitor/monitor_dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/trip/trip_entity.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../../core/services/service_locator.dart';
import 'assign_trip_dialog.dart';
import 'monitor_map_page.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MonitorMapPage(),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.map, color: Colors.white),
        label: const Text(
          'Mapa en Vivo',
          style: TextStyle(color: Colors.white),
        ),
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
    final canReassign = trip.status == TripStatus.assigned ||
        trip.status == TripStatus.inProgress;
    final canCancel = trip.status == TripStatus.assigned ||
        trip.status == TripStatus.inProgress ||
        trip.status == TripStatus.pending;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Detalles del Viaje',
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Usuario', trip.userName),
              _buildDetailRow('Teléfono', trip.userPhone),
              const Divider(color: AppTheme.dividerColor),
              _buildDetailRow('Origen', trip.route.origin.name),
              _buildDetailRow('Destino', trip.route.destination.name),
              _buildDetailRow('Distancia', '${trip.route.distanceKm.toStringAsFixed(1)} km'),
              const Divider(color: AppTheme.dividerColor),
              if (trip.driverName != null)
                _buildDetailRow('Conductor', trip.driverName!),
              if (trip.driverPhone != null)
                _buildDetailRow('Tel. Conductor', trip.driverPhone!),
              if (trip.vehiclePlate != null)
                _buildDetailRow('Vehículo', trip.vehiclePlate!),
              const Divider(color: AppTheme.dividerColor),
              _buildDetailRow('Precio', '\$${trip.totalPrice.toStringAsFixed(2)} MXN'),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          // Botón de cancelar viaje
          if (canCancel)
            TextButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _showCancelTripDialog(trip);
              },
              icon: const Icon(Icons.cancel, color: AppTheme.errorColor, size: 18),
              label: const Text(
                'Cancelar',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botón de reasignar
              if (canReassign)
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _showReassignDialog(trip);
                  },
                  icon: const Icon(Icons.swap_horiz, color: AppTheme.warningColor, size: 18),
                  label: const Text(
                    'Reasignar',
                    style: TextStyle(color: AppTheme.warningColor),
                  ),
                ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReassignDialog(TripEntity trip) {
    showDialog(
      context: context,
      builder: (context) => AssignTripDialog(
        trip: trip,
        isReassignment: true,
      ),
    ).then((reassigned) {
      if (reassigned == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Viaje reasignado exitosamente'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        _refreshTrips();
      }
    });
  }

  void _showCancelTripDialog(TripEntity trip) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          'Cancelar Viaje',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¿Estás seguro de que deseas cancelar este viaje?',
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 3,
              style: const TextStyle(color: AppTheme.textPrimaryColor),
              decoration: InputDecoration(
                hintText: 'Motivo de cancelación (obligatorio)',
                hintStyle: const TextStyle(color: AppTheme.textSecondaryColor),
                filled: true,
                fillColor: AppTheme.backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Volver'),
          ),
          ElevatedButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor indica el motivo de cancelación'),
                    backgroundColor: AppTheme.warningColor,
                  ),
                );
                return;
              }

              Navigator.of(dialogContext).pop();

              // Cancelar el viaje
              final result = await _tripRepository.cancelTrip(
                tripId: trip.id,
                reason: 'Cancelado por monitor: $reason',
              );

              result.fold(
                (failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${failure.message}'),
                      backgroundColor: AppTheme.errorColor,
                    ),
                  );
                },
                (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Viaje cancelado exitosamente'),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                  _refreshTrips();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Cancelar Viaje'),
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
