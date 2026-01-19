// lib/presentation/bloc/auth/auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';
import '../../../domain/usecases/auth/update_email_usecase.dart';
import '../../../domain/usecases/auth/update_password_usecase.dart';
import '../../../domain/usecases/auth/upload_profile_photo_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC que maneja la autenticación y perfil de usuarios
///
/// Responsabilidades (SOLID - Single Responsibility):
/// - Gestionar estados de autenticación
/// - Coordinar use cases de login/register/logout
/// - Verificar estado de sesión actual
/// - Gestionar actualización de perfil
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final AuthRepository authRepository;
  final UpdateProfileUseCase? updateProfileUseCase;
  final UpdateEmailUseCase? updateEmailUseCase;
  final UpdatePasswordUseCase? updatePasswordUseCase;
  final UploadProfilePhotoUseCase? uploadProfilePhotoUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.authRepository,
    this.updateProfileUseCase,
    this.updateEmailUseCase,
    this.updatePasswordUseCase,
    this.uploadProfilePhotoUseCase,
  }) : super(const AuthInitial()) {
    // Handlers de autenticación
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignInWithAppleEvent>(_onSignInWithApple);

    // Handlers de edición de perfil
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<UpdateEmailEvent>(_onUpdateEmail);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<UploadProfilePhotoEvent>(_onUploadProfilePhoto);
  }

  // ========================================
  // HANDLERS DE AUTENTICACIÓN
  // ========================================

  /// Verifica si hay una sesión activa
  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await authRepository.getCurrentUser();

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Maneja el evento de login
  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Maneja el evento de registro
  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await registerUseCase(
      RegisterParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        phoneNumber: event.phoneNumber ?? '',
        emergencyContactName: event.emergencyContactName ?? '',
        emergencyContactPhone: event.emergencyContactPhone ?? '',
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Maneja el evento de logout
  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await authRepository.logout();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  /// Maneja el inicio de sesión con Google
  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await authRepository.signInWithGoogle();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Maneja el inicio de sesión con Apple
  Future<void> _onSignInWithApple(
    SignInWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await authRepository.signInWithApple();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // ========================================
  // HANDLERS DE EDICIÓN DE PERFIL
  // ========================================

  /// Maneja la actualización del perfil
  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (updateProfileUseCase == null) {
      emit(const AuthError('Función no disponible'));
      return;
    }

    emit(const ProfileUpdating());

    final result = await updateProfileUseCase!(
      UpdateProfileParams(
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        emergencyContactName: event.emergencyContactName,
        emergencyContactPhone: event.emergencyContactPhone,
      ),
    );

    await result.fold(
      (failure) async {
        // Obtener usuario actual para mantener la sesión
        await _emitProfileErrorWithCurrentUser(emit, failure.message);
      },
      (user) async => emit(ProfileUpdated(user, 'Perfil actualizado correctamente')),
    );
  }

  /// Maneja la actualización del email
  Future<void> _onUpdateEmail(
    UpdateEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (updateEmailUseCase == null) {
      emit(const AuthError('Función no disponible'));
      return;
    }

    emit(const ProfileUpdating());

    final result = await updateEmailUseCase!(
      UpdateEmailParams(
        newEmail: event.newEmail,
        currentPassword: event.currentPassword,
      ),
    );

    await result.fold(
      (failure) async {
        await _emitProfileErrorWithCurrentUser(emit, failure.message);
      },
      (user) async => emit(ProfileUpdated(
        user,
        'Se ha enviado un correo de verificación a ${event.newEmail}',
      )),
    );
  }

  /// Maneja la actualización de la contraseña
  Future<void> _onUpdatePassword(
    UpdatePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (updatePasswordUseCase == null) {
      emit(const AuthError('Función no disponible'));
      return;
    }

    emit(const ProfileUpdating());

    final result = await updatePasswordUseCase!(
      UpdatePasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ),
    );

    await result.fold(
      (failure) async {
        await _emitProfileErrorWithCurrentUser(emit, failure.message);
      },
      (_) async {
        // Obtener usuario actual después de actualizar contraseña
        final userResult = await authRepository.getCurrentUser();
        userResult.fold(
          (failure) => emit(const AuthUnauthenticated()),
          (user) => emit(PasswordUpdated(user)),
        );
      },
    );
  }

  /// Maneja la subida de foto de perfil
  Future<void> _onUploadProfilePhoto(
    UploadProfilePhotoEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (uploadProfilePhotoUseCase == null) {
      emit(const AuthError('Función no disponible'));
      return;
    }

    emit(const UploadingPhoto());

    final result = await uploadProfilePhotoUseCase!(
      UploadProfilePhotoParams(imageFile: event.imageFile),
    );

    await result.fold(
      (failure) async {
        await _emitProfileErrorWithCurrentUser(emit, failure.message);
      },
      (user) async => emit(ProfileUpdated(user, 'Foto de perfil actualizada')),
    );
  }

  // ========================================
  // HELPERS
  // ========================================

  /// Emite un ProfileError manteniendo el usuario actual
  Future<void> _emitProfileErrorWithCurrentUser(
    Emitter<AuthState> emit,
    String message,
  ) async {
    final userResult = await authRepository.getCurrentUser();
    userResult.fold(
      (failure) => emit(AuthError(message)),
      (user) => emit(ProfileError(user, message)),
    );
  }
}
