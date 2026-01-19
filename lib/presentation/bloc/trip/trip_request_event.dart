// lib/presentation/bloc/trip/trip_request_event.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_request_event.freezed.dart';

/// Eventos del TripRequestBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class TripRequestEvent with _$TripRequestEvent {
  /// Evento: Crear una nueva solicitud de viaje
  ///
  /// Se dispara cuando el usuario presiona "Solicitar servicio"
  /// despues de seleccionar origen, destino y paquete.
  const factory TripRequestEvent.create({
    required String userId,
    required String userName,
    required String userPhone,
    required String routeId,
    required String serviceType,
    required double totalPrice,
  }) = CreateTripRequestEvent;

  /// Evento: Obtener el viaje activo del usuario
  ///
  /// Se dispara:
  /// - Al iniciar la app (para verificar si hay viaje en progreso)
  /// - Al volver al home despues de una solicitud
  /// - Para verificar si el usuario puede solicitar un nuevo viaje
  const factory TripRequestEvent.getActiveTrip({
    required String userId,
  }) = GetUserActiveTripEvent;

  /// Evento: Obtener historial de viajes del usuario
  ///
  /// Se dispara:
  /// - Al abrir la pagina "Mis Viajes"
  /// - Para mostrar estadisticas
  const factory TripRequestEvent.getUserTrips({
    required String userId,
  }) = GetUserTripsEvent;

  /// Evento: Escuchar cambios en tiempo real de un viaje
  ///
  /// Se dispara:
  /// - Al entrar a la pantalla de tracking
  /// - Mantiene el stream abierto para recibir actualizaciones
  const factory TripRequestEvent.watchTrip({
    required String tripId,
  }) = WatchTripEvent;

  /// Evento: Cancelar la suscripcion al stream de un viaje
  ///
  /// Se dispara:
  /// - Al salir de la pantalla de tracking
  /// - Para liberar recursos cuando ya no se necesita escuchar
  const factory TripRequestEvent.stopWatching() = StopWatchingTripEvent;

  /// Evento: Resetear el estado del BLoC
  ///
  /// Se dispara:
  /// - Al cerrar sesion
  /// - Para limpiar datos antiguos
  const factory TripRequestEvent.reset() = ResetTripRequestEvent;
}
