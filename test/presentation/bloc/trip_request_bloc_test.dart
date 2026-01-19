// test/presentation/bloc/trip_request_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:blincar_app/core/errors/failures.dart';
import 'package:blincar_app/domain/entities/trip/trip_entity.dart';
import 'package:blincar_app/domain/entities/trip/route_entity.dart';
import 'package:blincar_app/domain/usecases/trip/create_trip_request_usecase.dart';
import 'package:blincar_app/domain/usecases/trip/get_user_active_trip_usecase.dart';
import 'package:blincar_app/domain/usecases/trip/get_user_trips_usecase.dart';
import 'package:blincar_app/domain/usecases/trip/watch_trip_usecase.dart';
import 'package:blincar_app/presentation/bloc/trip/trip_request_bloc.dart';
import 'package:blincar_app/presentation/bloc/trip/trip_request_event.dart';
import 'package:blincar_app/presentation/bloc/trip/trip_request_state.dart';

// Mocks
class MockCreateTripRequestUseCase extends Mock
    implements CreateTripRequestUseCase {}

class MockGetUserActiveTripUseCase extends Mock
    implements GetUserActiveTripUseCase {}

class MockGetUserTripsUseCase extends Mock implements GetUserTripsUseCase {}

class MockWatchTripUseCase extends Mock implements WatchTripUseCase {}

void main() {
  late TripRequestBloc tripBloc;
  late MockCreateTripRequestUseCase mockCreateTripUseCase;
  late MockGetUserActiveTripUseCase mockGetActiveTripUseCase;
  late MockGetUserTripsUseCase mockGetUserTripsUseCase;
  late MockWatchTripUseCase mockWatchTripUseCase;

  // Test data
  final testRoute = RouteEntity(
    id: 'route-001',
    name: 'AICM - Centro',
    origin: const LocationPoint(
      name: 'Aeropuerto Internacional CDMX',
      address: 'Terminal 1, AICM',
      latitude: 19.4363,
      longitude: -99.0721,
    ),
    destination: const LocationPoint(
      name: 'Zocalo CDMX',
      address: 'Plaza de la Constitucion',
      latitude: 19.4326,
      longitude: -99.1332,
    ),
    distanceKm: 12.5,
    estimatedDurationMinutes: 45,
    basePrice: 150.0,
    category: RouteCategory.airport,
  );

  final testTrip = TripEntity(
    id: 'trip-123',
    userId: 'user-456',
    userName: 'Test User',
    userPhone: '+52 55 1234 5678',
    route: testRoute,
    serviceType: 'standard',
    status: TripStatus.pending,
    totalPrice: 150.0,
    requestedAt: DateTime(2024, 1, 15, 10, 30),
  );

  setUp(() {
    mockCreateTripUseCase = MockCreateTripRequestUseCase();
    mockGetActiveTripUseCase = MockGetUserActiveTripUseCase();
    mockGetUserTripsUseCase = MockGetUserTripsUseCase();
    mockWatchTripUseCase = MockWatchTripUseCase();

    tripBloc = TripRequestBloc(
      createTripRequestUseCase: mockCreateTripUseCase,
      getUserActiveTripUseCase: mockGetActiveTripUseCase,
      getUserTripsUseCase: mockGetUserTripsUseCase,
      watchTripUseCase: mockWatchTripUseCase,
    );
  });

  tearDown(() {
    tripBloc.close();
  });

  setUpAll(() {
    registerFallbackValue(
      const CreateTripRequestParams(
        userId: '',
        userName: '',
        userPhone: '',
        routeId: '',
        serviceType: '',
        totalPrice: 0.0,
      ),
    );
  });

  group('TripRequestBloc', () {
    test('initial state should be TripRequestInitial', () {
      expect(tripBloc.state, const TripRequestState.initial());
    });

    group('CreateTripRequest Event', () {
      blocTest<TripRequestBloc, TripRequestState>(
        'emits [loading, created] when trip creation succeeds',
        build: () {
          when(() => mockCreateTripUseCase(any()))
              .thenAnswer((_) async => Right(testTrip));
          return tripBloc;
        },
        act: (bloc) => bloc.add(const TripRequestEvent.create(
          userId: 'user-456',
          userName: 'Test User',
          userPhone: '+52 55 1234 5678',
          routeId: 'route-001',
          serviceType: 'standard',
          totalPrice: 150.0,
        )),
        expect: () => [
          isA<TripRequestLoading>(),
          TripRequestState.created(testTrip),
        ],
        verify: (_) {
          verify(() => mockCreateTripUseCase(any())).called(1);
        },
      );

      blocTest<TripRequestBloc, TripRequestState>(
        'emits [loading, error] when trip creation fails',
        build: () {
          when(() => mockCreateTripUseCase(any())).thenAnswer(
            (_) async => const Left(ServerFailure('Error al crear viaje')),
          );
          return tripBloc;
        },
        act: (bloc) => bloc.add(const TripRequestEvent.create(
          userId: 'user-456',
          userName: 'Test User',
          userPhone: '+52 55 1234 5678',
          routeId: 'route-001',
          serviceType: 'standard',
          totalPrice: 150.0,
        )),
        expect: () => [
          isA<TripRequestLoading>(),
          const TripRequestState.error('Error al crear viaje'),
        ],
      );
    });

    group('GetActiveTrip Event', () {
      blocTest<TripRequestBloc, TripRequestState>(
        'emits [loading, activeTripLoaded] when active trip exists',
        build: () {
          when(() => mockGetActiveTripUseCase(any()))
              .thenAnswer((_) async => Right(testTrip));
          return tripBloc;
        },
        act: (bloc) => bloc.add(const TripRequestEvent.getActiveTrip(
          userId: 'user-456',
        )),
        expect: () => [
          isA<TripRequestLoading>(),
          TripRequestState.activeTripLoaded(testTrip),
        ],
      );

      blocTest<TripRequestBloc, TripRequestState>(
        'emits [loading, activeTripLoaded(null)] when no active trip',
        build: () {
          when(() => mockGetActiveTripUseCase(any()))
              .thenAnswer((_) async => const Right(null));
          return tripBloc;
        },
        act: (bloc) => bloc.add(const TripRequestEvent.getActiveTrip(
          userId: 'user-456',
        )),
        expect: () => [
          isA<TripRequestLoading>(),
          const TripRequestState.activeTripLoaded(null),
        ],
      );
    });

    group('GetUserTrips Event', () {
      blocTest<TripRequestBloc, TripRequestState>(
        'emits [loading, historyLoaded] when trips loaded successfully',
        build: () {
          when(() => mockGetUserTripsUseCase(any()))
              .thenAnswer((_) async => Right([testTrip]));
          return tripBloc;
        },
        act: (bloc) => bloc.add(const TripRequestEvent.getUserTrips(
          userId: 'user-456',
        )),
        expect: () => [
          isA<TripRequestLoading>(),
          TripRequestState.historyLoaded([testTrip]),
        ],
      );

      blocTest<TripRequestBloc, TripRequestState>(
        'emits [loading, historyLoaded([])] when no trips',
        build: () {
          when(() => mockGetUserTripsUseCase(any()))
              .thenAnswer((_) async => const Right(<TripEntity>[]));
          return tripBloc;
        },
        act: (bloc) => bloc.add(const TripRequestEvent.getUserTrips(
          userId: 'user-456',
        )),
        expect: () => [
          isA<TripRequestLoading>(),
          const TripRequestState.historyLoaded(<TripEntity>[]),
        ],
      );
    });

    group('Reset Event', () {
      blocTest<TripRequestBloc, TripRequestState>(
        'emits [initial] when reset is called',
        build: () => tripBloc,
        act: (bloc) => bloc.add(const TripRequestEvent.reset()),
        expect: () => [
          const TripRequestState.initial(),
        ],
      );
    });
  });
}
