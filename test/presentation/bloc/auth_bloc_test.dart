// test/presentation/bloc/auth_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:blincar_app/core/errors/failures.dart';
import 'package:blincar_app/domain/entities/user.dart';
import 'package:blincar_app/domain/repositories/auth_repository.dart';
import 'package:blincar_app/domain/usecases/auth/login_usecase.dart';
import 'package:blincar_app/domain/usecases/auth/register_usecase.dart';
import 'package:blincar_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:blincar_app/presentation/bloc/auth/auth_event.dart';
import 'package:blincar_app/presentation/bloc/auth/auth_state.dart';

// Mocks
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockAuthRepository mockAuthRepository;

  // Test user
  final testUser = User(
    id: 'user-123',
    email: 'test@blincar.com',
    phoneNumber: '+52 55 1234 5678',
    fullName: 'Test User',
    createdAt: DateTime(2024, 1, 1),
  );

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockAuthRepository = MockAuthRepository();

    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      authRepository: mockAuthRepository,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  // Register fallback values for mocktail
  setUpAll(() {
    registerFallbackValue(
      const LoginParams(email: '', password: ''),
    );
    registerFallbackValue(
      RegisterParams(
        email: '',
        password: '',
        fullName: '',
        phoneNumber: '',
        emergencyContactName: '',
        emergencyContactPhone: '',
      ),
    );
  });

  group('AuthBloc', () {
    test('initial state should be AuthInitial', () {
      expect(authBloc.state, const AuthState.initial());
    });

    group('Login Event', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when login succeeds',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.login(
          email: 'test@blincar.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase(any())).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, error] when login fails with invalid credentials',
        build: () {
          when(() => mockLoginUseCase(any())).thenAnswer((_) async =>
              const Left(AuthenticationFailure('Credenciales incorrectas')));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.login(
          email: 'test@blincar.com',
          password: 'wrongpassword',
        )),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error('Credenciales incorrectas'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, error] when login fails with network error',
        build: () {
          when(() => mockLoginUseCase(any())).thenAnswer(
              (_) async => const Left(NetworkFailure('Sin conexion')));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.login(
          email: 'test@blincar.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error('Sin conexion'),
        ],
      );
    });

    group('Register Event', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when registration succeeds',
        build: () {
          when(() => mockRegisterUseCase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.register(
          email: 'new@blincar.com',
          password: 'password123',
          fullName: 'New User',
          phoneNumber: '+52 55 9876 5432',
          emergencyContactName: 'Emergency Contact',
          emergencyContactPhone: '+52 55 1111 2222',
        )),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
        verify: (_) {
          verify(() => mockRegisterUseCase(any())).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, error] when registration fails with existing email',
        build: () {
          when(() => mockRegisterUseCase(any())).thenAnswer((_) async =>
              const Left(AuthenticationFailure('Email ya registrado')));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.register(
          email: 'existing@blincar.com',
          password: 'password123',
          fullName: 'Existing User',
          phoneNumber: '+52 55 1111 2222',
          emergencyContactName: 'Emergency',
          emergencyContactPhone: '+52 55 3333 4444',
        )),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error('Email ya registrado'),
        ],
      );
    });

    group('CheckStatus Event', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when user is logged in',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.checkStatus()),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when getCurrentUser fails',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Left(AuthenticationFailure('No user logged in')));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.checkStatus()),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
      );
    });

    group('Logout Event', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when logout succeeds',
        build: () {
          when(() => mockAuthRepository.logout())
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.logout()),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.logout()).called(1);
        },
      );
    });
  });
}
