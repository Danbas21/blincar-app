// lib/presentation/bloc/auth/auth_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user.dart';

part 'auth_state.freezed.dart';

/// Estados del AuthBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class AuthState with _$AuthState {
  // ========================================
  // ESTADOS DE AUTENTICACIÓN
  // ========================================

  /// Estado inicial - Verificando autenticacion
  const factory AuthState.initial() = AuthInitial;

  /// Estado de carga (login/register en proceso)
  const factory AuthState.loading() = AuthLoading;

  /// Usuario autenticado exitosamente
  const factory AuthState.authenticated(User user) = AuthAuthenticated;

  /// Usuario NO autenticado
  const factory AuthState.unauthenticated() = AuthUnauthenticated;

  /// Error de autenticacion
  const factory AuthState.error(String message) = AuthError;

  /// Email de recuperación enviado
  const factory AuthState.passwordResetEmailSent(String email) = PasswordResetEmailSent;

  // ========================================
  // ESTADOS DE EDICIÓN DE PERFIL
  // ========================================

  /// Actualizando perfil en proceso
  const factory AuthState.profileUpdating() = ProfileUpdating;

  /// Perfil actualizado exitosamente
  const factory AuthState.profileUpdated(User user, String message) =
      ProfileUpdated;

  /// Error al actualizar perfil
  const factory AuthState.profileError(User user, String message) =
      ProfileError;

  /// Subiendo foto de perfil
  const factory AuthState.uploadingPhoto() = UploadingPhoto;

  /// Contraseña actualizada exitosamente
  const factory AuthState.passwordUpdated(User user) = PasswordUpdated;
}
