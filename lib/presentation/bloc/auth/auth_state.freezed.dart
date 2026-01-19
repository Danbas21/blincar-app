// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthInitialImplCopyWith<$Res> {
  factory _$$AuthInitialImplCopyWith(
          _$AuthInitialImpl value, $Res Function(_$AuthInitialImpl) then) =
      __$$AuthInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitialImpl>
    implements _$$AuthInitialImplCopyWith<$Res> {
  __$$AuthInitialImplCopyWithImpl(
      _$AuthInitialImpl _value, $Res Function(_$AuthInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthInitialImpl implements AuthInitial {
  const _$AuthInitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitialImpl;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
          _$AuthLoadingImpl value, $Res Function(_$AuthLoadingImpl) then) =
      __$$AuthLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
      _$AuthLoadingImpl _value, $Res Function(_$AuthLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthLoadingImpl implements AuthLoading {
  const _$AuthLoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoadingImpl;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(_$AuthAuthenticatedImpl value,
          $Res Function(_$AuthAuthenticatedImpl) then) =
      __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(_$AuthAuthenticatedImpl _value,
      $Res Function(_$AuthAuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AuthAuthenticatedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated(final User user) = _$AuthAuthenticatedImpl;

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthUnauthenticatedImplCopyWith(_$AuthUnauthenticatedImpl value,
          $Res Function(_$AuthUnauthenticatedImpl) then) =
      __$$AuthUnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUnauthenticatedImpl>
    implements _$$AuthUnauthenticatedImplCopyWith<$Res> {
  __$$AuthUnauthenticatedImplCopyWithImpl(_$AuthUnauthenticatedImpl _value,
      $Res Function(_$AuthUnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthUnauthenticatedImpl implements AuthUnauthenticated {
  const _$AuthUnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthenticated implements AuthState {
  const factory AuthUnauthenticated() = _$AuthUnauthenticatedImpl;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError(final String message) = _$AuthErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileUpdatingImplCopyWith<$Res> {
  factory _$$ProfileUpdatingImplCopyWith(_$ProfileUpdatingImpl value,
          $Res Function(_$ProfileUpdatingImpl) then) =
      __$$ProfileUpdatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileUpdatingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ProfileUpdatingImpl>
    implements _$$ProfileUpdatingImplCopyWith<$Res> {
  __$$ProfileUpdatingImplCopyWithImpl(
      _$ProfileUpdatingImpl _value, $Res Function(_$ProfileUpdatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileUpdatingImpl implements ProfileUpdating {
  const _$ProfileUpdatingImpl();

  @override
  String toString() {
    return 'AuthState.profileUpdating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileUpdatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return profileUpdating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return profileUpdating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (profileUpdating != null) {
      return profileUpdating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return profileUpdating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return profileUpdating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (profileUpdating != null) {
      return profileUpdating(this);
    }
    return orElse();
  }
}

abstract class ProfileUpdating implements AuthState {
  const factory ProfileUpdating() = _$ProfileUpdatingImpl;
}

/// @nodoc
abstract class _$$ProfileUpdatedImplCopyWith<$Res> {
  factory _$$ProfileUpdatedImplCopyWith(_$ProfileUpdatedImpl value,
          $Res Function(_$ProfileUpdatedImpl) then) =
      __$$ProfileUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user, String message});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$ProfileUpdatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ProfileUpdatedImpl>
    implements _$$ProfileUpdatedImplCopyWith<$Res> {
  __$$ProfileUpdatedImplCopyWithImpl(
      _$ProfileUpdatedImpl _value, $Res Function(_$ProfileUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? message = null,
  }) {
    return _then(_$ProfileUpdatedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$ProfileUpdatedImpl implements ProfileUpdated {
  const _$ProfileUpdatedImpl(this.user, this.message);

  @override
  final User user;
  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.profileUpdated(user: $user, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdatedImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdatedImplCopyWith<_$ProfileUpdatedImpl> get copyWith =>
      __$$ProfileUpdatedImplCopyWithImpl<_$ProfileUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return profileUpdated(user, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return profileUpdated?.call(user, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (profileUpdated != null) {
      return profileUpdated(user, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return profileUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return profileUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (profileUpdated != null) {
      return profileUpdated(this);
    }
    return orElse();
  }
}

abstract class ProfileUpdated implements AuthState {
  const factory ProfileUpdated(final User user, final String message) =
      _$ProfileUpdatedImpl;

  User get user;
  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdatedImplCopyWith<_$ProfileUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileErrorImplCopyWith<$Res> {
  factory _$$ProfileErrorImplCopyWith(
          _$ProfileErrorImpl value, $Res Function(_$ProfileErrorImpl) then) =
      __$$ProfileErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user, String message});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$ProfileErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ProfileErrorImpl>
    implements _$$ProfileErrorImplCopyWith<$Res> {
  __$$ProfileErrorImplCopyWithImpl(
      _$ProfileErrorImpl _value, $Res Function(_$ProfileErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? message = null,
  }) {
    return _then(_$ProfileErrorImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$ProfileErrorImpl implements ProfileError {
  const _$ProfileErrorImpl(this.user, this.message);

  @override
  final User user;
  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.profileError(user: $user, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileErrorImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileErrorImplCopyWith<_$ProfileErrorImpl> get copyWith =>
      __$$ProfileErrorImplCopyWithImpl<_$ProfileErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return profileError(user, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return profileError?.call(user, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (profileError != null) {
      return profileError(user, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return profileError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return profileError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (profileError != null) {
      return profileError(this);
    }
    return orElse();
  }
}

abstract class ProfileError implements AuthState {
  const factory ProfileError(final User user, final String message) =
      _$ProfileErrorImpl;

  User get user;
  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileErrorImplCopyWith<_$ProfileErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadingPhotoImplCopyWith<$Res> {
  factory _$$UploadingPhotoImplCopyWith(_$UploadingPhotoImpl value,
          $Res Function(_$UploadingPhotoImpl) then) =
      __$$UploadingPhotoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UploadingPhotoImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UploadingPhotoImpl>
    implements _$$UploadingPhotoImplCopyWith<$Res> {
  __$$UploadingPhotoImplCopyWithImpl(
      _$UploadingPhotoImpl _value, $Res Function(_$UploadingPhotoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UploadingPhotoImpl implements UploadingPhoto {
  const _$UploadingPhotoImpl();

  @override
  String toString() {
    return 'AuthState.uploadingPhoto()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UploadingPhotoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return uploadingPhoto();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return uploadingPhoto?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (uploadingPhoto != null) {
      return uploadingPhoto();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return uploadingPhoto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return uploadingPhoto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (uploadingPhoto != null) {
      return uploadingPhoto(this);
    }
    return orElse();
  }
}

abstract class UploadingPhoto implements AuthState {
  const factory UploadingPhoto() = _$UploadingPhotoImpl;
}

/// @nodoc
abstract class _$$PasswordUpdatedImplCopyWith<$Res> {
  factory _$$PasswordUpdatedImplCopyWith(_$PasswordUpdatedImpl value,
          $Res Function(_$PasswordUpdatedImpl) then) =
      __$$PasswordUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$PasswordUpdatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$PasswordUpdatedImpl>
    implements _$$PasswordUpdatedImplCopyWith<$Res> {
  __$$PasswordUpdatedImplCopyWithImpl(
      _$PasswordUpdatedImpl _value, $Res Function(_$PasswordUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$PasswordUpdatedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$PasswordUpdatedImpl implements PasswordUpdated {
  const _$PasswordUpdatedImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.passwordUpdated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordUpdatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordUpdatedImplCopyWith<_$PasswordUpdatedImpl> get copyWith =>
      __$$PasswordUpdatedImplCopyWithImpl<_$PasswordUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() profileUpdating,
    required TResult Function(User user, String message) profileUpdated,
    required TResult Function(User user, String message) profileError,
    required TResult Function() uploadingPhoto,
    required TResult Function(User user) passwordUpdated,
  }) {
    return passwordUpdated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? profileUpdating,
    TResult? Function(User user, String message)? profileUpdated,
    TResult? Function(User user, String message)? profileError,
    TResult? Function()? uploadingPhoto,
    TResult? Function(User user)? passwordUpdated,
  }) {
    return passwordUpdated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? profileUpdating,
    TResult Function(User user, String message)? profileUpdated,
    TResult Function(User user, String message)? profileError,
    TResult Function()? uploadingPhoto,
    TResult Function(User user)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (passwordUpdated != null) {
      return passwordUpdated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(ProfileUpdating value) profileUpdating,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(ProfileError value) profileError,
    required TResult Function(UploadingPhoto value) uploadingPhoto,
    required TResult Function(PasswordUpdated value) passwordUpdated,
  }) {
    return passwordUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(ProfileUpdating value)? profileUpdating,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(ProfileError value)? profileError,
    TResult? Function(UploadingPhoto value)? uploadingPhoto,
    TResult? Function(PasswordUpdated value)? passwordUpdated,
  }) {
    return passwordUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(ProfileUpdating value)? profileUpdating,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(ProfileError value)? profileError,
    TResult Function(UploadingPhoto value)? uploadingPhoto,
    TResult Function(PasswordUpdated value)? passwordUpdated,
    required TResult orElse(),
  }) {
    if (passwordUpdated != null) {
      return passwordUpdated(this);
    }
    return orElse();
  }
}

abstract class PasswordUpdated implements AuthState {
  const factory PasswordUpdated(final User user) = _$PasswordUpdatedImpl;

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordUpdatedImplCopyWith<_$PasswordUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
