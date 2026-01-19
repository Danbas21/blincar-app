// lib/domain/usecases/auth/update_email_usecase.dart

import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

/// Caso de uso para actualizar el email del usuario
///
/// Requiere la contraseña actual para re-autenticación por seguridad
class UpdateEmailUseCase implements UseCase<User, UpdateEmailParams> {
  final AuthRepository repository;

  UpdateEmailUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateEmailParams params) async {
    return await repository.updateEmail(
      newEmail: params.newEmail,
      currentPassword: params.currentPassword,
    );
  }
}

/// Parámetros para actualizar el email
class UpdateEmailParams {
  final String newEmail;
  final String currentPassword;

  const UpdateEmailParams({
    required this.newEmail,
    required this.currentPassword,
  });
}
