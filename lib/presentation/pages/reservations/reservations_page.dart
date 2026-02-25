// lib/presentation/pages/reservations/reservations_page.dart

import 'package:flutter/material.dart';
import 'package:blincar_app/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

/// Página de reservaciones del usuario
///
/// Muestra las reservaciones activas y pasadas del usuario.
/// Permite ver detalles y gestionar reservaciones.
class ReservationsPage extends StatefulWidget {
  /// ID de reservación específica para navegar directamente a sus detalles
  final String? reservationId;

  const ReservationsPage({
    super.key,
    this.reservationId,
  });

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  String _selectedFilter = 'Todas';
  final List<String> _filters = ['Todas', 'Activas', 'Pasadas', 'Canceladas'];

  @override
  void initState() {
    super.initState();
    // Si viene un reservationId específico, navegar a detalles
    if (widget.reservationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showReservationDetails(widget.reservationId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reservations = _getMockReservations();
    final filteredReservations = _getFilteredReservations(reservations);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.myReservations),
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

          // Lista de reservaciones
          Expanded(
            child: filteredReservations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 64,
                          color: AppTheme.textSecondaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noReservations,
                          style: const TextStyle(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: filteredReservations.length,
                    itemBuilder: (context, index) {
                      final reservation = filteredReservations[index];
                      return _buildReservationCard(reservation, l10n);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navegar a crear nueva reservación
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Crear nueva reservación - Próximamente'),
              backgroundColor: AppTheme.primaryLightColor,
            ),
          );
        },
        backgroundColor: AppTheme.primaryLightColor,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Reservación'),
      ),
    );
  }

  List<_Reservation> _getMockReservations() {
    return [
      _Reservation(
        id: 'res_001',
        origin: 'Aeropuerto CDMX T1',
        destination: 'Polanco, CDMX',
        scheduledDate: DateTime.now().add(const Duration(days: 2)),
        status: _ReservationStatus.confirmed,
        estimatedPrice: 450.00,
        vehicleType: 'Ejecutivo',
      ),
      _Reservation(
        id: 'res_002',
        origin: 'Hotel Four Seasons',
        destination: 'Aeropuerto CDMX T2',
        scheduledDate: DateTime.now().add(const Duration(days: 5)),
        status: _ReservationStatus.pending,
        estimatedPrice: 380.00,
        vehicleType: 'SUV Premium',
      ),
      _Reservation(
        id: 'res_003',
        origin: 'Santa Fe, CDMX',
        destination: 'Centro Histórico',
        scheduledDate: DateTime.now().subtract(const Duration(days: 3)),
        status: _ReservationStatus.completed,
        estimatedPrice: 320.00,
        vehicleType: 'Ejecutivo',
      ),
      _Reservation(
        id: 'res_004',
        origin: 'Roma Norte',
        destination: 'Aeropuerto Toluca',
        scheduledDate: DateTime.now().subtract(const Duration(days: 7)),
        status: _ReservationStatus.cancelled,
        estimatedPrice: 680.00,
        vehicleType: 'SUV Premium',
      ),
    ];
  }

  List<_Reservation> _getFilteredReservations(List<_Reservation> reservations) {
    switch (_selectedFilter) {
      case 'Activas':
        return reservations
            .where((r) =>
                r.status == _ReservationStatus.confirmed ||
                r.status == _ReservationStatus.pending)
            .toList();
      case 'Pasadas':
        return reservations
            .where((r) => r.status == _ReservationStatus.completed)
            .toList();
      case 'Canceladas':
        return reservations
            .where((r) => r.status == _ReservationStatus.cancelled)
            .toList();
      default:
        return reservations;
    }
  }

  Widget _buildReservationCard(_Reservation reservation, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => _showReservationDetails(reservation.id),
      child: Container(
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _getStatusColor(reservation.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getStatusText(reservation.status, l10n),
                    style: TextStyle(
                      color: _getStatusColor(reservation.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _formatDate(reservation.scheduledDate),
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Rutas
            _buildRouteInfo(reservation),

            const SizedBox(height: 16),

            // Info adicional
            Row(
              children: [
                _buildInfoChip(Icons.directions_car, reservation.vehicleType),
                const SizedBox(width: 12),
                _buildInfoChip(
                  Icons.access_time,
                  _formatTime(reservation.scheduledDate),
                ),
                const Spacer(),
                Text(
                  '\$${reservation.estimatedPrice.toStringAsFixed(2)}',
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
      ),
    );
  }

  Widget _buildRouteInfo(_Reservation reservation) {
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
                reservation.origin,
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
                reservation.destination,
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

  Color _getStatusColor(_ReservationStatus status) {
    switch (status) {
      case _ReservationStatus.confirmed:
        return AppTheme.successColor;
      case _ReservationStatus.pending:
        return AppTheme.warningColor;
      case _ReservationStatus.completed:
        return AppTheme.primaryLightColor;
      case _ReservationStatus.cancelled:
        return AppTheme.errorColor;
    }
  }

  String _getStatusText(_ReservationStatus status, AppLocalizations l10n) {
    switch (status) {
      case _ReservationStatus.confirmed:
        return l10n.reservationConfirmed;
      case _ReservationStatus.pending:
        return l10n.tripStatusPending;
      case _ReservationStatus.completed:
        return l10n.reservationCompleted;
      case _ReservationStatus.cancelled:
        return l10n.reservationCancelled;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showReservationDetails(String reservationId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (ctx) => Text(
                AppLocalizations.of(ctx)!.reservationDetails,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ID: $reservationId',
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Modificar reservación - Próximamente'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: Builder(builder: (ctx) => Text(AppLocalizations.of(ctx)!.modifyButton)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textPrimaryColor,
                      side: const BorderSide(color: AppTheme.dividerColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cancelar reservación - Próximamente'),
                          backgroundColor: AppTheme.errorColor,
                        ),
                      );
                    },
                    icon: const Icon(Icons.cancel),
                    label: Builder(builder: (ctx) => Text(AppLocalizations.of(ctx)!.cancel)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Modelo interno de reservación
class _Reservation {
  final String id;
  final String origin;
  final String destination;
  final DateTime scheduledDate;
  final _ReservationStatus status;
  final double estimatedPrice;
  final String vehicleType;

  _Reservation({
    required this.id,
    required this.origin,
    required this.destination,
    required this.scheduledDate,
    required this.status,
    required this.estimatedPrice,
    required this.vehicleType,
  });
}

enum _ReservationStatus {
  pending,
  confirmed,
  completed,
  cancelled,
}
