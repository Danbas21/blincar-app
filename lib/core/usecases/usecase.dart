// lib/core/usecases/usecase.dart

import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Caso de uso base para operaciones asincronas
///
/// Implementa el patron Command con generics para type-safety.
///
/// [Output] - Tipo de dato que retorna el caso de uso
/// [Input] - Tipo de parametros que recibe
///
/// Ejemplo:
/// ```dart
/// class LoginUseCase extends UseCase<User, LoginParams> {
///   @override
///   Future<Either<Failure, User>> call(LoginParams params) async {
///     return await repository.login(params.email, params.password);
///   }
/// }
/// ```
abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

/// Caso de uso para operaciones que retornan un Stream
///
/// Util para escuchar cambios en tiempo real (Firebase, WebSockets, etc.)
///
/// [Output] - Tipo de dato que emite el stream
/// [Input] - Tipo de parametros que recibe
///
/// Ejemplo:
/// ```dart
/// class WatchTripUseCase extends StreamUseCase<TripEntity, String> {
///   @override
///   Stream<Either<Failure, TripEntity>> call(String tripId) {
///     return repository.watchTrip(tripId);
///   }
/// }
/// ```
abstract class StreamUseCase<Output, Input> {
  Stream<Either<Failure, Output>> call(Input params);
}

/// Caso de uso para operaciones sin parametros
///
/// Simplifica casos de uso que no necesitan entrada.
///
/// [Output] - Tipo de dato que retorna
///
/// Ejemplo:
/// ```dart
/// class GetCurrentUserUseCase extends NoParamsUseCase<User?> {
///   @override
///   Future<Either<Failure, User?>> call() async {
///     return await repository.getCurrentUser();
///   }
/// }
/// ```
abstract class NoParamsUseCase<Output> {
  Future<Either<Failure, Output>> call();
}

/// Caso de uso para streams sin parametros
///
/// Ejemplo:
/// ```dart
/// class WatchAuthStateUseCase extends NoParamsStreamUseCase<User?> {
///   @override
///   Stream<Either<Failure, User?>> call() {
///     return repository.watchAuthState();
///   }
/// }
/// ```
abstract class NoParamsStreamUseCase<Output> {
  Stream<Either<Failure, Output>> call();
}

/// Clase marcadora para casos de uso sin parametros
///
/// Usada con UseCase<Type, NoParams> para mantener compatibilidad
/// con codigo existente.
class NoParams {
  const NoParams();

  @override
  bool operator ==(Object other) => other is NoParams;

  @override
  int get hashCode => 0;
}
