// lib/domain/usecases/auth/update_profile_usecase.dart

import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

/// Caso de uso para actualizar el perfil del usuario
///
/// Actualiza los campos: fullName, phoneNumber, emergencyContactName, emergencyContactPhone
class UpdateProfileUseCase implements UseCase<User, UpdateProfileParams> {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(
      fullName: params.fullName,
      phoneNumber: params.phoneNumber,
      emergencyContactName: params.emergencyContactName,
      emergencyContactPhone: params.emergencyContactPhone,
    );
  }
}

/// Parámetros para actualizar el perfil
class UpdateProfileParams {
  final String fullName;
  final String? phoneNumber;
  final String? emergencyContactName;
  final String? emergencyContactPhone;

  const UpdateProfileParams({
    required this.fullName,
    this.phoneNumber,
    this.emergencyContactName,
    this.emergencyContactPhone,
  });
}
