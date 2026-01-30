import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/mock/mock_data.dart';
import '../../../domain/entities/trip.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  String _selectedFilter = 'Todos';
  final List<String> _filters = ['Todos', 'Completados', 'Cancelados'];

  @override
  Widget build(BuildContext context) {
    final allTrips = MockData.getRecentTrips();
    final filteredTrips = _getFilteredTrips(allTrips);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Historial de Viajes'),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;

                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryLightColor
                          : AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryLightColor
                            : AppTheme.dividerColor,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppTheme.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Lista de viajes
          Expanded(
            child: filteredTrips.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: AppTheme.textSecondaryColor,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No hay viajes para mostrar',
                          style: TextStyle(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: filteredTrips.length,
                    itemBuilder: (context, index) {
                      final trip = filteredTrips[index];
                      return _buildTripCard(trip);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<Trip> _getFilteredTrips(List<Trip> trips) {
    switch (_selectedFilter) {
      case 'Completados':
        return trips
            .where((trip) => trip.status == TripStatus.completed)
            .toList();
      case 'Cancelados':
        return trips
            .where((trip) => trip.status == TripStatus.cancelled)
            .toList();
      default:
        return trips;
    }
  }

  Widget _buildTripCard(Trip trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del viaje
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(trip.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getStatusText(trip.status),
                  style: TextStyle(
                    color: _getStatusColor(trip.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${trip.completedAt?.day ?? trip.requestedAt.day}/${trip.completedAt?.month ?? trip.requestedAt.month}/${trip.completedAt?.year ?? trip.requestedAt.year}',
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Rutas
          _buildRouteInfo(trip),

          const SizedBox(height: 16),

          // Información del viaje
          Row(
            children: [
              _buildInfoChip(
                Icons.schedule,
                '${trip.actualDuration ?? trip.estimatedDuration ?? 0} min',
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                Icons.straighten,
                '${trip.actualDistance?.toStringAsFixed(1) ?? trip.estimatedDistance?.toStringAsFixed(1) ?? '0'} km',
              ),
              if (trip.ratingByPassenger != null) ...[
                const SizedBox(width: 12),
                _buildInfoChip(
                  Icons.star,
                  trip.ratingByPassenger.toString(),
                ),
              ],
              const Spacer(),
              Text(
                '\$${trip.actualPrice?.toStringAsFixed(2) ?? trip.estimatedPrice?.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo(Trip trip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.successColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                trip.originAddress,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 3),
              width: 2,
              height: 20,
              color: AppTheme.dividerColor,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.errorColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                trip.destinationAddress,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppTheme.textSecondaryColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
            ),
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
      case TripStatus.inProgress:
        return AppTheme.warningColor;
      case TripStatus.accepted:
        return AppTheme.primaryLightColor;
      case TripStatus.requested:
        return AppTheme.accentColor;
    }
  }

  String _getStatusText(TripStatus status) {
    switch (status) {
      case TripStatus.completed:
        return 'Completado';
      case TripStatus.cancelled:
        return 'Cancelado';
      case TripStatus.inProgress:
        return 'En progreso';
      case TripStatus.accepted:
        return 'Aceptado';
      case TripStatus.requested:
        return 'Solicitado';
    }
  }
}
