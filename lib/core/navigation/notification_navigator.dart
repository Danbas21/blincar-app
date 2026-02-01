// lib/core/navigation/notification_navigator.dart

import 'package:flutter/material.dart';
import '../../presentation/pages/trip/trip_tracking_page.dart';
import '../../presentation/pages/trip/trip_history_page.dart';
import '../../presentation/pages/reservations/reservations_page.dart';
import '../../presentation/pages/panic/panic_page.dart';
import '../../presentation/pages/payment/payment_history_page.dart';
import '../../presentation/pages/notifications/notifications_page.dart';

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

  /// Navega a detalles del viaje (TripTrackingPage)
  void _navigateToTripDetails(BuildContext context, String tripId) {
    debugPrint('[NotificationNavigator] Navigate to trip: $tripId');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TripTrackingPage(tripId: tripId),
      ),
    );
  }

  /// Navega a viaje activo (mapa en vivo) - mismo que detalles
  void _navigateToActiveTrip(BuildContext context, String tripId) {
    debugPrint('[NotificationNavigator] Navigate to active trip: $tripId');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TripTrackingPage(tripId: tripId),
      ),
    );
  }

  /// Navega a historial de viajes
  void _navigateToTripsHistory(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to trips history');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TripHistoryPage(),
      ),
    );
  }

  /// Navega a detalles de reserva
  void _navigateToReservationDetails(
      BuildContext context, String reservationId) {
    debugPrint(
        '[NotificationNavigator] Navigate to reservation: $reservationId');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReservationsPage(reservationId: reservationId),
      ),
    );
  }

  /// Navega a lista de reservas
  void _navigateToReservations(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to reservations');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ReservationsPage(),
      ),
    );
  }

  /// Navega a alertas de pánico
  void _navigateToPanicAlerts(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to panic alerts');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PanicPage(),
      ),
    );
  }

  /// Navega a historial de pagos
  void _navigateToPaymentHistory(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to payment history');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PaymentHistoryPage(),
      ),
    );
  }

  /// Navega a lista de notificaciones
  void _navigateToNotifications(BuildContext context) {
    debugPrint('[NotificationNavigator] Navigate to notifications');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NotificationsPage(),
      ),
    );
  }
}
