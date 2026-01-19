// lib/domain/usecases/auth/update_password_usecase.dart

import 'package:dartz/dartz.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

/// Caso de uso para actualizar la contraseña del usuario
///
/// Requiere la contraseña actual para re-autenticación por seguridad
class UpdatePasswordUseCase implements UseCase<void, UpdatePasswordParams> {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdatePasswordParams params) async {
    return await repository.updatePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

/// Parámetros para actualizar la contraseña
class UpdatePasswordParams {
  final String currentPassword;
  final String newPassword;

  const UpdatePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });
}
