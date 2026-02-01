import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String emergencyContactName,
    required String emergencyContactPhone,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  // ========================================
  // MÉTODOS DE EDICIÓN DE PERFIL
  // ========================================

  /// Actualiza los datos del perfil del usuario
  ///
  /// Campos actualizables: fullName, phoneNumber, emergencyContactName, emergencyContactPhone
  Future<Either<Failure, User>> updateProfile({
    required String fullName,
    String? phoneNumber,
    String? emergencyContactName,
    String? emergencyContactPhone,
  });

  /// Actualiza el email del usuario
  ///
  /// Requiere la contraseña actual para re-autenticación
  Future<Either<Failure, User>> updateEmail({
    required String newEmail,
    required String currentPassword,
  });

  /// Actualiza la contraseña del usuario
  ///
  /// Requiere la contraseña actual para re-autenticación
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Sube una foto de perfil a Firebase Storage
  ///
  /// Retorna la URL de la imagen subida
  Future<Either<Failure, String>> uploadProfilePhoto({
    required File imageFile,
  });

  /// Actualiza la URL de la foto de perfil
  Future<Either<Failure, User>> updateProfilePhotoUrl({
    required String photoUrl,
  });

  // ========================================
  // MÉTODOS DE AUTENTICACIÓN SOCIAL
  // ========================================

  /// Inicia sesión con Google
  Future<Either<Failure, User>> signInWithGoogle();

  /// Inicia sesión con Apple
  Future<Either<Failure, User>> signInWithApple();

  /// Envía email de recuperación de contraseña
  Future<Either<Failure, void>> sendPasswordResetEmail({
    required String email,
  });

  /// Envía email de recuperación de contraseña personalizado por idioma
  /// usando Cloud Function
  Future<Either<Failure, void>> sendPasswordResetEmailWithLocale({
    required String email,
    required String locale,
  });
}
