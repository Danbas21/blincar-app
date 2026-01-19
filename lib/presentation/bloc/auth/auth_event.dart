// lib/presentation/bloc/auth/auth_event.dart

import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

/// Eventos del AuthBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class AuthEvent with _$AuthEvent {
  // ========================================
  // EVENTOS DE AUTENTICACIÓN
  // ========================================

  /// Evento para verificar el estado de autenticacion actual
  ///
  /// Se dispara automaticamente desde SplashPage para verificar
  /// si hay una sesion activa.
  const factory AuthEvent.checkStatus() = CheckAuthStatus;

  /// Evento para iniciar sesion
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = LoginEvent;

  /// Evento para registrar un nuevo usuario
  const factory AuthEvent.register({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String? emergencyContactName,
    String? emergencyContactPhone,
  }) = RegisterEvent;

  /// Evento para cerrar sesion
  const factory AuthEvent.logout() = LogoutEvent;

  /// Evento para iniciar sesión con Google
  const factory AuthEvent.signInWithGoogle() = SignInWithGoogleEvent;

  /// Evento para iniciar sesión con Apple
  const factory AuthEvent.signInWithApple() = SignInWithAppleEvent;

  // ========================================
  // EVENTOS DE EDICIÓN DE PERFIL
  // ========================================

  /// Evento para actualizar los datos del perfil
  const factory AuthEvent.updateProfile({
    required String fullName,
    String? phoneNumber,
    String? emergencyContactName,
    String? emergencyContactPhone,
  }) = UpdateProfileEvent;

  /// Evento para actualizar el email
  const factory AuthEvent.updateEmail({
    required String newEmail,
    required String currentPassword,
  }) = UpdateEmailEvent;

  /// Evento para actualizar la contraseña
  const factory AuthEvent.updatePassword({
    required String currentPassword,
    required String newPassword,
  }) = UpdatePasswordEvent;

  /// Evento para subir y actualizar la foto de perfil
  const factory AuthEvent.uploadProfilePhoto({
    required File imageFile,
  }) = UploadProfilePhotoEvent;
}
