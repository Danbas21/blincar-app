// lib/presentation/bloc/trip/trip_request_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/trip/trip_entity.dart';

part 'trip_request_state.freezed.dart';
part 'trip_request_state.g.dart';

/// Estados del TripRequestBloc
///
/// Representa todos los posibles estados de la UI
/// relacionados con solicitudes de viaje.
///
/// Usando sealed class con Freezed para pattern matching type-safe
@freezed
sealed class TripRequestState with _$TripRequestState {
  /// Estado inicial - No hay operaciones en curso
  const factory TripRequestState.initial() = TripRequestInitial;

  /// Estado: Operación en progreso (loading)
  ///
  /// Se muestra:
  /// - Spinner mientras se crea la solicitud
  /// - Skeleton mientras se carga el viaje activo
  /// - Loading mientras se carga el historial
  const factory TripRequestState.loading({String? message}) =
      TripRequestLoading;

  /// Estado: Solicitud creada exitosamente
  ///
  /// Se muestra:
  /// - Mensaje de éxito
  /// - Navegación automática a página de espera
  /// - El tripId para tracking
  const factory TripRequestState.created(TripEntity trip) = TripRequestCreated;

  /// Estado: Viaje activo encontrado
  ///
  /// Se muestra:
  /// - Banner en home con el viaje actual
  /// - Navegación automática a tracking si el viaje está en progreso
  /// - null si no hay viaje activo
  const factory TripRequestState.activeTripLoaded(TripEntity? trip) =
      ActiveTripLoaded;

  /// Estado: Historial de viajes cargado
  ///
  /// Se muestra:
  /// - Lista de viajes en "Mis Viajes"
  /// - Puede estar vacía si el usuario no tiene viajes
  const factory TripRequestState.historyLoaded(List<TripEntity> trips) =
      TripHistoryLoaded;

  /// Estado: Actualizaciones en tiempo real del viaje
  ///
  /// Se muestra:
  /// - En la pantalla de tracking
  /// - Se actualiza cada vez que Firebase emite un cambio
  const factory TripRequestState.updated(TripEntity trip) = TripUpdated;

  /// Estado: Error en cualquier operación
  ///
  /// Se muestra:
  /// - SnackBar con mensaje de error
  /// - Dialog con detalles del error
  /// - Opción de reintentar
  const factory TripRequestState.error(String message) = TripRequestError;
}
