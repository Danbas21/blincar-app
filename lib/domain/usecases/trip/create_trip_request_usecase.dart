// lib/domain/usecases/trip/create_trip_request_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/trip/trip_entity.dart';
import '../../repositories/trip_repository.dart';

/// Use Case para crear una nueva solicitud de viaje
///
/// Este use case encapsula la lógica de negocio para crear
/// una solicitud de viaje (TripRequest) que luego será asignada
/// por el monitor a un conductor.
///
/// Flujo:
/// 1. Usuario selecciona origen, destino y paquete de servicio
/// 2. Se calcula precio estimado
/// 3. Se crea la solicitud con estado 'pending'
/// 4. El monitor será notificado automáticamente (Firebase)
///
/// Principio SOLID aplicado: Single Responsibility
/// - Este use case solo se encarga de crear la solicitud
/// - No maneja asignación, pago ni tracking (eso son otros use cases)
class CreateTripRequestUseCase
    implements UseCase<TripEntity, CreateTripRequestParams> {
  final TripRepository repository;

  CreateTripRequestUseCase(this.repository);

  @override
  Future<Either<Failure, TripEntity>> call(
      CreateTripRequestParams params) async {
    // Validaciones de negocio (opcional, dependiendo de requisitos)
    if (params.totalPrice <= 0) {
      return Left(ValidationFailure('El precio debe ser mayor a 0'));
    }

    if (params.routeId.isEmpty) {
      return Left(ValidationFailure('Debe seleccionar una ruta'));
    }

    if (params.serviceType.isEmpty) {
      return Left(ValidationFailure('Debe seleccionar un tipo de servicio'));
    }

    // Delegar al repositorio la creación
    return await repository.createTripRequest(
      userId: params.userId,
      userName: params.userName,
      userPhone: params.userPhone,
      routeId: params.routeId,
      serviceType: params.serviceType,
      totalPrice: params.totalPrice,
    );
  }
}

/// Parámetros para crear una solicitud de viaje
///
/// Encapsula todos los datos necesarios para la solicitud.
class CreateTripRequestParams {
  final String userId;
  final String userName;
  final String userPhone;
  final String routeId;
  final String serviceType;
  final double totalPrice;

  const CreateTripRequestParams({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.routeId,
    required this.serviceType,
    required this.totalPrice,
  });

  @override
  String toString() => 'CreateTripRequestParams('
      'user: $userName, '
      'route: $routeId, '
      'service: $serviceType, '
      'price: \$$totalPrice)';
}
