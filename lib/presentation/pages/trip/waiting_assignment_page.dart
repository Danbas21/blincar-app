// lib/presentation/pages/trip/waiting_assignment_page.dart

import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/trip/trip_entity.dart';
import '../../../domain/repositories/trip_repository.dart';
import '../../../core/services/service_locator.dart';
import '../../widgets/common/custom_button.dart';
import 'trip_tracking_page.dart';

class WaitingAssignmentPage extends StatefulWidget {
  final String tripId;

  const WaitingAssignmentPage({
    super.key,
    required this.tripId,
  });

  @override
  State<WaitingAssignmentPage> createState() => _WaitingAssignmentPageState();
}

class _WaitingAssignmentPageState extends State<WaitingAssignmentPage>
    with SingleTickerProviderStateMixin {
  final TripRepository _tripRepository = getIt<TripRepository>();

  late AnimationController _pulseController;
  StreamSubscription? _tripSubscription;
  TripEntity? _currentTrip;

  @override
  void initState() {
    super.initState();

    // Animación de pulso
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Escuchar cambios del viaje
    _listenToTripChanges();
  }

  void _listenToTripChanges() {
    _tripSubscription =
        _tripRepository.watchTrip(widget.tripId).listen((result) {
      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        },
        (trip) {
          setState(() {
            _currentTrip = trip;
          });

          // Si el viaje fue asignado, navegar a siguiente pantalla
          if (trip.status == TripStatus.assigned) {
            _showAssignedDialog(trip);
          }

          // Si el viaje fue cancelado
          if (trip.status == TripStatus.cancelled) {
            _showCancelledDialog();
          }
        },
      );
    });
  }

  void _showAssignedDialog(TripEntity trip) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Row(
          children: [
            const Icon(Icons.check_circle,
                color: AppTheme.successColor, size: 32),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                '¡Conductor asignado!',
                style: const TextStyle(color: AppTheme.textPrimaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tu conductor está en camino',
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow('Conductor', trip.driverName ?? 'N/A'),
            const SizedBox(height: 8),
            _buildInfoRow('Teléfono', trip.driverPhone ?? 'N/A'),
            const SizedBox(height: 8),
            _buildInfoRow('Vehículo', trip.vehiclePlate ?? 'N/A'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              // Navegar a pantalla de tracking
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => TripTrackingPage(tripId: widget.tripId),
                ),
              );
            },
            child: const Text('Ver viaje'),
          ),
        ],
      ),
    );
  }

  void _showCancelledDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Row(
          children: [
            const Icon(Icons.cancel, color: AppTheme.errorColor, size: 32),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'Viaje cancelado',
                style: const TextStyle(color: AppTheme.textPrimaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: const Text(
          'Tu viaje ha sido cancelado.',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).pop(); // Volver a home
            },
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        // Confirmar antes de salir
        final shouldPop = await _showExitConfirmation();
        if (shouldPop == true && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
            onPressed: () async {
              final shouldPop = await _showExitConfirmation();
              if (shouldPop == true && mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          title: const Text(
            'Esperando asignación',
            style: TextStyle(color: AppTheme.textPrimaryColor),
          ),
        ),
        body: _currentTrip == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Animación de pulso
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = 1.0 + (_pulseController.value * 0.1);
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.primaryLightColor,
                                  AppTheme.primaryLightColor.withValues(alpha: 0.6),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryLightColor
                                      .withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.search,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Título
                    Text(
                      _currentTrip!.status.displayName,
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Descripción
                    Text(
                      _currentTrip!.status.description,
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // Detalles del viaje
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
                            'Detalles del viaje',
                            style: TextStyle(
                              color: AppTheme.textPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow('Ruta', _currentTrip!.route.name),
                          const Divider(height: 24),
                          _buildInfoRow('Servicio', _currentTrip!.serviceType),
                          const Divider(height: 24),
                          _buildInfoRow(
                            'Precio',
                            '\$${_currentTrip!.totalPrice.toStringAsFixed(0)} MXN',
                          ),
                          const Divider(height: 24),
                          _buildInfoRow(
                            'Solicitado',
                            _formatTime(_currentTrip!.requestedAt),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Botón cancelar
                    CustomButton(
                      text: 'Cancelar viaje',
                      onPressed: () => _showCancelConfirmation(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Hace un momento';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<bool?> _showExitConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          'Salir',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: const Text(
          'Tu viaje sigue en proceso de asignación. ¿Deseas salir?',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Quedarme'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCancelConfirmation() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text(
          'Cancelar viaje',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        content: const Text(
          '¿Estás seguro de que deseas cancelar este viaje?',
          style: TextStyle(color: AppTheme.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
            ),
            child: const Text('Sí, cancelar'),
          ),
        ],
      ),
    );

    if (shouldCancel == true) {
      // Cancelar viaje
      final result = await _tripRepository.cancelTrip(
        tripId: widget.tripId,
        reason: 'Usuario canceló',
      );

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        },
        (_) {
          Navigator.of(context).pop(); // Volver a home
        },
      );
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _tripSubscription?.cancel();
    super.dispose();
  }
}
