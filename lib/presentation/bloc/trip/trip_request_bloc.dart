// lib/presentation/bloc/trip/trip_request_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/trip/create_trip_request_usecase.dart';
import '../../../domain/usecases/trip/get_user_active_trip_usecase.dart';
import '../../../domain/usecases/trip/get_user_trips_usecase.dart';
import '../../../domain/usecases/trip/watch_trip_usecase.dart';

import 'trip_request_event.dart';
import 'trip_request_state.dart';

/// BLoC para gestionar solicitudes de viaje
///
/// Responsabilidades:
/// - Crear nuevas solicitudes de viaje
/// - Obtener viaje activo del usuario
/// - Obtener historial de viajes
/// - Escuchar actualizaciones en tiempo real de un viaje
///
/// Principios SOLID aplicados:
/// - Single Responsibility: Solo maneja logica de solicitudes de viaje
/// - Dependency Inversion: Depende de abstracciones (use cases), no implementaciones
/// - Open/Closed: Facil extender con nuevos eventos sin modificar existentes
class TripRequestBloc extends Bloc<TripRequestEvent, TripRequestState> {
  final CreateTripRequestUseCase createTripRequestUseCase;
  final GetUserActiveTripUseCase getUserActiveTripUseCase;
  final GetUserTripsUseCase getUserTripsUseCase;
  final WatchTripUseCase watchTripUseCase;

  // Stream subscription para el watch de viajes
  StreamSubscription? _tripSubscription;

  TripRequestBloc({
    required this.createTripRequestUseCase,
    required this.getUserActiveTripUseCase,
    required this.getUserTripsUseCase,
    required this.watchTripUseCase,
  }) : super(const TripRequestState.initial()) {
    // Registrar handlers para cada evento
    on<CreateTripRequestEvent>(_onCreateTripRequest);
    on<GetUserActiveTripEvent>(_onGetUserActiveTrip);
    on<GetUserTripsEvent>(_onGetUserTrips);
    on<WatchTripEvent>(_onWatchTrip);
    on<StopWatchingTripEvent>(_onStopWatchingTrip);
    on<ResetTripRequestEvent>(_onReset);
  }

  /// Handler: Crear nueva solicitud de viaje
  Future<void> _onCreateTripRequest(
    CreateTripRequestEvent event,
    Emitter<TripRequestState> emit,
  ) async {
    emit(const TripRequestState.loading(
        message: 'Creando solicitud de viaje...'));

    final params = CreateTripRequestParams(
      userId: event.userId,
      userName: event.userName,
      userPhone: event.userPhone,
      routeId: event.routeId,
      serviceType: event.serviceType,
      totalPrice: event.totalPrice,
    );

    final result = await createTripRequestUseCase(params);

    result.fold(
      (failure) => emit(TripRequestState.error(failure.message)),
      (trip) => emit(TripRequestState.created(trip)),
    );
  }

  /// Handler: Obtener viaje activo del usuario
  Future<void> _onGetUserActiveTrip(
    GetUserActiveTripEvent event,
    Emitter<TripRequestState> emit,
  ) async {
    emit(const TripRequestState.loading(message: 'Verificando viaje activo...'));

    final result = await getUserActiveTripUseCase(event.userId);

    result.fold(
      (failure) => emit(TripRequestState.error(failure.message)),
      (trip) => emit(TripRequestState.activeTripLoaded(trip)),
    );
  }

  /// Handler: Obtener historial de viajes
  Future<void> _onGetUserTrips(
    GetUserTripsEvent event,
    Emitter<TripRequestState> emit,
  ) async {
    emit(const TripRequestState.loading(message: 'Cargando historial...'));

    final result = await getUserTripsUseCase(event.userId);

    result.fold(
      (failure) => emit(TripRequestState.error(failure.message)),
      (trips) => emit(TripRequestState.historyLoaded(trips)),
    );
  }

  /// Handler: Escuchar cambios en tiempo real de un viaje
  Future<void> _onWatchTrip(
    WatchTripEvent event,
    Emitter<TripRequestState> emit,
  ) async {
    // Cancelar suscripcion anterior si existe
    await _tripSubscription?.cancel();

    emit(const TripRequestState.loading(message: 'Conectando...'));

    // Crear nueva suscripcion al stream
    _tripSubscription = watchTripUseCase(event.tripId).listen(
      (result) {
        result.fold(
          (failure) => emit(TripRequestState.error(failure.message)),
          (trip) => emit(TripRequestState.updated(trip)),
        );
      },
      onError: (error) {
        emit(TripRequestState.error('Error escuchando viaje: $error'));
      },
    );
  }

  /// Handler: Detener suscripcion al stream
  Future<void> _onStopWatchingTrip(
    StopWatchingTripEvent event,
    Emitter<TripRequestState> emit,
  ) async {
    await _tripSubscription?.cancel();
    _tripSubscription = null;
    emit(const TripRequestState.initial());
  }

  /// Handler: Resetear estado
  Future<void> _onReset(
    ResetTripRequestEvent event,
    Emitter<TripRequestState> emit,
  ) async {
    await _tripSubscription?.cancel();
    _tripSubscription = null;
    emit(const TripRequestState.initial());
  }

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}
