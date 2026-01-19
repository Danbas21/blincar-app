// lib/domain/usecases/auth/upload_profile_photo_usecase.dart

import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

/// Caso de uso para subir y actualizar la foto de perfil
///
/// Este use case combina dos operaciones:
/// 1. Subir la imagen a Firebase Storage
/// 2. Actualizar la URL de la foto en el perfil del usuario
class UploadProfilePhotoUseCase
    implements UseCase<User, UploadProfilePhotoParams> {
  final AuthRepository repository;

  UploadProfilePhotoUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UploadProfilePhotoParams params) async {
    // 1. Subir la imagen y obtener la URL
    final uploadResult = await repository.uploadProfilePhoto(
      imageFile: params.imageFile,
    );

    return uploadResult.fold(
      (failure) => Left(failure),
      (photoUrl) async {
        // 2. Actualizar la URL en el perfil del usuario
        return await repository.updateProfilePhotoUrl(photoUrl: photoUrl);
      },
    );
  }
}

/// Parámetros para subir la foto de perfil
class UploadProfilePhotoParams {
  final File imageFile;

  const UploadProfilePhotoParams({
    required this.imageFile,
  });
}
