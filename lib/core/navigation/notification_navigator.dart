// lib/core/navigation/notification_navigator.dart

import 'package:flutter/material.dart';

/// Navigator que maneja la navegación desde notificaciones push
///
/// Cuando el usuario toca una notificación, este servicio determina
/// a qué pantalla navegar según el tipo de notificación y los datos.
class NotificationNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  NotificationNavigator({required this.navigatorKey});

  /// Maneja el tap en una notificación y navega a la pantalla correcta
  void handleNotificationTap(Map<String, dynamic> data) {
    debugPrint('[NotificationNavigator] Handling tap: $data');

    // Extraer datos de la notificación
    final type = data['type'] as String?;
    final tripId = data['tripId'] as String?;
    final reservationId = data['reservationId'] as String?;

    // Verificar que tengamos un context válido
    final context = navigatorKey.currentContext;
    if (context == null) {
      debugPrint('[NotificationNavigator] No context available');
      return;
    }

    // Navegar según el tipo de notificación
    switch (type) {
      // ========== VIAJES ==========
      case 'trip_request':
      case 'trip_accepted':
      case 'driver_arrived':
      case 'trip_started':
      case 'trip_completed':
      case 'trip_cancelled':
        if (tripId != null) {
          _navigateToTripDetails(context, tripId);
        } else {
          _navigateToTripsHistory(context);
        }
        break;

      // ========== RESERVAS ==========
      case 'new_reservation':
      case 'reservation_assigned':
        if (reservationId != null) {
          _navigateToReservationDetails(context, reservationId);
        } else {
          _navigateToReservations(context);
        }
        break;

      // ========== RUTA ==========
      case 'route_change':
        if (tripId != null) {
          _navigateToActiveTrip(context, tripId);
        }
        break;

      // ========== PÁNICO ==========
      case 'panic_alert':
        _navigateToPanicAlerts(context);
        break;

      // ========== PAGOS ==========
      case 'payment_confirmed':
      case 'payment_failed':
        if (tripId != null) {
          _navigateToTripDetails(context, tripId);
        } else {
          _navigateToPaymentHistory(context);
        }
        break;

      // ========== DEFAULT ==========
      default:
        // Si no reconocemos el tipo, ir a notificaciones
        _navigateToNotifications(context);
    }
  }

  // ========== MÉTODOS DE NAVEGACIÓN ==========

  /// Navega a detalles del viaje
  void _navigateToTripDetails(BuildContext context, String tripId) {
    debugPrint('[NotificationNavigator] Navigate to trip: $tripId');

    // TODO: Reemplazar con la ruta real de tu app
    // Navigator.of(context).pushNamed('/trip-details', arguments: tripId);

    // Por ahora, mostrar snackbar (temporal)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegar a viaje: $tripId'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Navega a viaje activo (mapa en vivo)
  void _navigateToActiveTrip(BuildContext context, String tripId) {
    debugPrint('[NotificationNavigator] Navigate to active trip: $tripId');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/active-trip', arguments: tripId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegar a viaje activo: $tripId'),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Navega a historial de viajes
  void _navigateToTripsHistory(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to trips history');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/trips-history');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegar a historial de viajes'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Navega a detalles de reserva
  void _navigateToReservationDetails(BuildContext context, String reservationId) {
    debugPrint('[NotificationNavigator] Navigate to reservation: $reservationId');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/reservation-details', arguments: reservationId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegar a reserva: $reservationId'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  /// Navega a lista de reservas
  void _navigateToReservations(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to reservations');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/reservations');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegar a reservas'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  /// Navega a alertas de pánico (admin)
  void _navigateToPanicAlerts(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to panic alerts');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/panic-alerts');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ALERTA DE PÁNICO - Ver panel admin'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  /// Navega a historial de pagos
  void _navigateToPaymentHistory(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to payment history');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/payment-history');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegar a historial de pagos'),
        backgroundColor: Colors.amber,
      ),
    );
  }

  /// Navega a lista de notificaciones
  void _navigateToNotifications(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to notifications');

    // TODO: Reemplazar con la ruta real
    // Navigator.of(context).pushNamed('/notifications');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegar a notificaciones'),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
