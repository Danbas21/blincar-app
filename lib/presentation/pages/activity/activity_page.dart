// lib/presentation/pages/activity/activity_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/service_locator.dart';
import '../../../domain/entities/trip/trip_entity.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final TripRepository _tripRepository = getIt<TripRepository>();

  List<TripEntity> _trips = [];
  bool _isLoading = true;
  String? _errorMessage;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadUserTrips();
  }

  Future<void> _loadUserTrips() async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Usuario no autenticado';
      });
      return;
    }

    _currentUserId = authState.user.id;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _tripRepository.getUserTrips(_currentUserId!);

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (trips) {
        setState(() {
          _isLoading = false;
          // Filtrar solo viajes completados o cancelados (historial)
          _trips = trips
              .where((t) =>
                  t.status == TripStatus.completed ||
                  t.status == TripStatus.cancelled)
              .toList();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.activityTitle),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUserTrips,
          ),
        ],
      ),
      body: _buildBody(l10n),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadUserTrips,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (_trips.isEmpty) {
      return _buildEmptyState(l10n);
    }

    return RefreshIndicator(
      onRefresh: _loadUserTrips,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen
            _buildSummaryCards(),

            const SizedBox(height: 24),

            // Título
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.tripHistory,
                  style: TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${_trips.length} viajes',
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de viajes
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _trips.length,
              itemBuilder: (context, index) {
                final trip = _trips[index];
                return _buildTripCard(trip, l10n);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    final l10n = AppLocalizations.of(context)!;
    final completedTrips =
        _trips.where((t) => t.status == TripStatus.completed).toList();
    final totalSpent =
        completedTrips.fold<double>(0, (sum, t) => sum + t.totalPrice);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.directions_car,
                  color: AppTheme.primaryLightColor,
                  size: 28,
                ),
                const SizedBox(height: 12),
                Text(
                  '${completedTrips.length}',
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.tripsCompleted,
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.attach_money,
                  color: AppTheme.successColor,
                  size: 28,
                ),
                const SizedBox(height: 12),
                Text(
                  '\$${totalSpent.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.totalSpent,
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.history,
                size: 64,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noTripsYet,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.noTripsDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(TripEntity trip, AppLocalizations l10n) {
    final statusColor = _getStatusColor(trip.status);
    final statusText = _getStatusText(trip.status, l10n);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Fecha y precio
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(trip.completedAt ?? trip.requestedAt),
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$${trip.totalPrice.toStringAsFixed(0)} MXN',
                    style: const TextStyle(
                      color: AppTheme.successColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Origen
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppTheme.successColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  trip.route.origin.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          // Línea conectora
          Container(
            margin: const EdgeInsets.only(left: 4),
            height: 20,
            width: 2,
            color: AppTheme.dividerColor,
          ),

          // Destino
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppTheme.errorColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  trip.route.destination.name,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Info adicional
          Row(
            children: [
              const Icon(
                Icons.local_taxi,
                color: AppTheme.textSecondaryColor,
                size: 14,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  trip.serviceType,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trip.driverName != null) ...[
                const SizedBox(width: 16),
                const Icon(
                  Icons.person,
                  color: AppTheme.textSecondaryColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    trip.driverName!,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (trip.vehiclePlate != null) ...[
                const SizedBox(width: 16),
                const Icon(
                  Icons.directions_car,
                  color: AppTheme.textSecondaryColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    trip.vehiclePlate!,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.completed:
        return AppTheme.successColor;
      case TripStatus.cancelled:
        return AppTheme.errorColor;
      case TripStatus.pending:
        return AppTheme.warningColor;
      case TripStatus.assigned:
        return AppTheme.primaryLightColor;
      case TripStatus.inProgress:
        return AppTheme.accentColor;
    }
  }

  String _getStatusText(TripStatus status, AppLocalizations l10n) {
    switch (status) {
      case TripStatus.completed:
        return l10n.tripStatusCompleted;
      case TripStatus.cancelled:
        return l10n.tripStatusCancelled;
      case TripStatus.pending:
        return l10n.tripStatusPending;
      case TripStatus.assigned:
        return l10n.tripStatusAssigned;
      case TripStatus.inProgress:
        return l10n.tripStatusInProgress;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Hoy ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Ayer ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
