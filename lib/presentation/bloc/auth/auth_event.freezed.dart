// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CheckAuthStatusImplCopyWith<$Res> {
  factory _$$CheckAuthStatusImplCopyWith(_$CheckAuthStatusImpl value,
          $Res Function(_$CheckAuthStatusImpl) then) =
      __$$CheckAuthStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAuthStatusImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$CheckAuthStatusImpl>
    implements _$$CheckAuthStatusImplCopyWith<$Res> {
  __$$CheckAuthStatusImplCopyWithImpl(
      _$CheckAuthStatusImpl _value, $Res Function(_$CheckAuthStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckAuthStatusImpl implements CheckAuthStatus {
  const _$CheckAuthStatusImpl();

  @override
  String toString() {
    return 'AuthEvent.checkStatus()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckAuthStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return checkStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return checkStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (checkStatus != null) {
      return checkStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return checkStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return checkStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (checkStatus != null) {
      return checkStatus(this);
    }
    return orElse();
  }
}

abstract class CheckAuthStatus implements AuthEvent {
  const factory CheckAuthStatus() = _$CheckAuthStatusImpl;
}

/// @nodoc
abstract class _$$LoginEventImplCopyWith<$Res> {
  factory _$$LoginEventImplCopyWith(
          _$LoginEventImpl value, $Res Function(_$LoginEventImpl) then) =
      __$$LoginEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginEventImpl>
    implements _$$LoginEventImplCopyWith<$Res> {
  __$$LoginEventImplCopyWithImpl(
      _$LoginEventImpl _value, $Res Function(_$LoginEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginEventImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginEventImpl implements LoginEvent {
  const _$LoginEventImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.login(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginEventImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginEventImplCopyWith<_$LoginEventImpl> get copyWith =>
      __$$LoginEventImplCopyWithImpl<_$LoginEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return login(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return login?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class LoginEvent implements AuthEvent {
  const factory LoginEvent(
      {required final String email,
      required final String password}) = _$LoginEventImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginEventImplCopyWith<_$LoginEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterEventImplCopyWith<$Res> {
  factory _$$RegisterEventImplCopyWith(
          _$RegisterEventImpl value, $Res Function(_$RegisterEventImpl) then) =
      __$$RegisterEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String email,
      String password,
      String fullName,
      String? phoneNumber,
      String? emergencyContactName,
      String? emergencyContactPhone});
}

/// @nodoc
class __$$RegisterEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterEventImpl>
    implements _$$RegisterEventImplCopyWith<$Res> {
  __$$RegisterEventImplCopyWithImpl(
      _$RegisterEventImpl _value, $Res Function(_$RegisterEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
  }) {
    return _then(_$RegisterEventImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _value.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _value.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RegisterEventImpl implements RegisterEvent {
  const _$RegisterEventImpl(
      {required this.email,
      required this.password,
      required this.fullName,
      this.phoneNumber,
      this.emergencyContactName,
      this.emergencyContactPhone});

  @override
  final String email;
  @override
  final String password;
  @override
  final String fullName;
  @override
  final String? phoneNumber;
  @override
  final String? emergencyContactName;
  @override
  final String? emergencyContactPhone;

  @override
  String toString() {
    return 'AuthEvent.register(email: $email, password: $password, fullName: $fullName, phoneNumber: $phoneNumber, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterEventImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactPhone, emergencyContactPhone) ||
                other.emergencyContactPhone == emergencyContactPhone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, fullName,
      phoneNumber, emergencyContactName, emergencyContactPhone);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterEventImplCopyWith<_$RegisterEventImpl> get copyWith =>
      __$$RegisterEventImplCopyWithImpl<_$RegisterEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return register(email, password, fullName, phoneNumber,
        emergencyContactName, emergencyContactPhone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return register?.call(email, password, fullName, phoneNumber,
        emergencyContactName, emergencyContactPhone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(email, password, fullName, phoneNumber,
          emergencyContactName, emergencyContactPhone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }
}

abstract class RegisterEvent implements AuthEvent {
  const factory RegisterEvent(
      {required final String email,
      required final String password,
      required final String fullName,
      final String? phoneNumber,
      final String? emergencyContactName,
      final String? emergencyContactPhone}) = _$RegisterEventImpl;

  String get email;
  String get password;
  String get fullName;
  String? get phoneNumber;
  String? get emergencyContactName;
  String? get emergencyContactPhone;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterEventImplCopyWith<_$RegisterEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutEventImplCopyWith<$Res> {
  factory _$$LogoutEventImplCopyWith(
          _$LogoutEventImpl value, $Res Function(_$LogoutEventImpl) then) =
      __$$LogoutEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutEventImpl>
    implements _$$LogoutEventImplCopyWith<$Res> {
  __$$LogoutEventImplCopyWithImpl(
      _$LogoutEventImpl _value, $Res Function(_$LogoutEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutEventImpl implements LogoutEvent {
  const _$LogoutEventImpl();

  @override
  String toString() {
    return 'AuthEvent.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class LogoutEvent implements AuthEvent {
  const factory LogoutEvent() = _$LogoutEventImpl;
}

/// @nodoc
abstract class _$$SignInWithGoogleEventImplCopyWith<$Res> {
  factory _$$SignInWithGoogleEventImplCopyWith(
          _$SignInWithGoogleEventImpl value,
          $Res Function(_$SignInWithGoogleEventImpl) then) =
      __$$SignInWithGoogleEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInWithGoogleEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInWithGoogleEventImpl>
    implements _$$SignInWithGoogleEventImplCopyWith<$Res> {
  __$$SignInWithGoogleEventImplCopyWithImpl(_$SignInWithGoogleEventImpl _value,
      $Res Function(_$SignInWithGoogleEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignInWithGoogleEventImpl implements SignInWithGoogleEvent {
  const _$SignInWithGoogleEventImpl();

  @override
  String toString() {
    return 'AuthEvent.signInWithGoogle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInWithGoogleEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return signInWithGoogle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return signInWithGoogle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (signInWithGoogle != null) {
      return signInWithGoogle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return signInWithGoogle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return signInWithGoogle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (signInWithGoogle != null) {
      return signInWithGoogle(this);
    }
    return orElse();
  }
}

abstract class SignInWithGoogleEvent implements AuthEvent {
  const factory SignInWithGoogleEvent() = _$SignInWithGoogleEventImpl;
}

/// @nodoc
abstract class _$$SignInWithAppleEventImplCopyWith<$Res> {
  factory _$$SignInWithAppleEventImplCopyWith(_$SignInWithAppleEventImpl value,
          $Res Function(_$SignInWithAppleEventImpl) then) =
      __$$SignInWithAppleEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInWithAppleEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInWithAppleEventImpl>
    implements _$$SignInWithAppleEventImplCopyWith<$Res> {
  __$$SignInWithAppleEventImplCopyWithImpl(_$SignInWithAppleEventImpl _value,
      $Res Function(_$SignInWithAppleEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignInWithAppleEventImpl implements SignInWithAppleEvent {
  const _$SignInWithAppleEventImpl();

  @override
  String toString() {
    return 'AuthEvent.signInWithApple()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInWithAppleEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return signInWithApple();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return signInWithApple?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (signInWithApple != null) {
      return signInWithApple();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return signInWithApple(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return signInWithApple?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (signInWithApple != null) {
      return signInWithApple(this);
    }
    return orElse();
  }
}

abstract class SignInWithAppleEvent implements AuthEvent {
  const factory SignInWithAppleEvent() = _$SignInWithAppleEventImpl;
}

/// @nodoc
abstract class _$$UpdateProfileEventImplCopyWith<$Res> {
  factory _$$UpdateProfileEventImplCopyWith(_$UpdateProfileEventImpl value,
          $Res Function(_$UpdateProfileEventImpl) then) =
      __$$UpdateProfileEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String fullName,
      String? phoneNumber,
      String? emergencyContactName,
      String? emergencyContactPhone});
}

/// @nodoc
class __$$UpdateProfileEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UpdateProfileEventImpl>
    implements _$$UpdateProfileEventImplCopyWith<$Res> {
  __$$UpdateProfileEventImplCopyWithImpl(_$UpdateProfileEventImpl _value,
      $Res Function(_$UpdateProfileEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
  }) {
    return _then(_$UpdateProfileEventImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _value.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _value.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UpdateProfileEventImpl implements UpdateProfileEvent {
  const _$UpdateProfileEventImpl(
      {required this.fullName,
      this.phoneNumber,
      this.emergencyContactName,
      this.emergencyContactPhone});

  @override
  final String fullName;
  @override
  final String? phoneNumber;
  @override
  final String? emergencyContactName;
  @override
  final String? emergencyContactPhone;

  @override
  String toString() {
    return 'AuthEvent.updateProfile(fullName: $fullName, phoneNumber: $phoneNumber, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileEventImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactPhone, emergencyContactPhone) ||
                other.emergencyContactPhone == emergencyContactPhone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullName, phoneNumber,
      emergencyContactName, emergencyContactPhone);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileEventImplCopyWith<_$UpdateProfileEventImpl> get copyWith =>
      __$$UpdateProfileEventImplCopyWithImpl<_$UpdateProfileEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return updateProfile(
        fullName, phoneNumber, emergencyContactName, emergencyContactPhone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return updateProfile?.call(
        fullName, phoneNumber, emergencyContactName, emergencyContactPhone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (updateProfile != null) {
      return updateProfile(
          fullName, phoneNumber, emergencyContactName, emergencyContactPhone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return updateProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return updateProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (updateProfile != null) {
      return updateProfile(this);
    }
    return orElse();
  }
}

abstract class UpdateProfileEvent implements AuthEvent {
  const factory UpdateProfileEvent(
      {required final String fullName,
      final String? phoneNumber,
      final String? emergencyContactName,
      final String? emergencyContactPhone}) = _$UpdateProfileEventImpl;

  String get fullName;
  String? get phoneNumber;
  String? get emergencyContactName;
  String? get emergencyContactPhone;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileEventImplCopyWith<_$UpdateProfileEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateEmailEventImplCopyWith<$Res> {
  factory _$$UpdateEmailEventImplCopyWith(_$UpdateEmailEventImpl value,
          $Res Function(_$UpdateEmailEventImpl) then) =
      __$$UpdateEmailEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newEmail, String currentPassword});
}

/// @nodoc
class __$$UpdateEmailEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UpdateEmailEventImpl>
    implements _$$UpdateEmailEventImplCopyWith<$Res> {
  __$$UpdateEmailEventImplCopyWithImpl(_$UpdateEmailEventImpl _value,
      $Res Function(_$UpdateEmailEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newEmail = null,
    Object? currentPassword = null,
  }) {
    return _then(_$UpdateEmailEventImpl(
      newEmail: null == newEmail
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
      currentPassword: null == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateEmailEventImpl implements UpdateEmailEvent {
  const _$UpdateEmailEventImpl(
      {required this.newEmail, required this.currentPassword});

  @override
  final String newEmail;
  @override
  final String currentPassword;

  @override
  String toString() {
    return 'AuthEvent.updateEmail(newEmail: $newEmail, currentPassword: $currentPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateEmailEventImpl &&
            (identical(other.newEmail, newEmail) ||
                other.newEmail == newEmail) &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newEmail, currentPassword);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateEmailEventImplCopyWith<_$UpdateEmailEventImpl> get copyWith =>
      __$$UpdateEmailEventImplCopyWithImpl<_$UpdateEmailEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return updateEmail(newEmail, currentPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return updateEmail?.call(newEmail, currentPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (updateEmail != null) {
      return updateEmail(newEmail, currentPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return updateEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return updateEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (updateEmail != null) {
      return updateEmail(this);
    }
    return orElse();
  }
}

abstract class UpdateEmailEvent implements AuthEvent {
  const factory UpdateEmailEvent(
      {required final String newEmail,
      required final String currentPassword}) = _$UpdateEmailEventImpl;

  String get newEmail;
  String get currentPassword;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateEmailEventImplCopyWith<_$UpdateEmailEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePasswordEventImplCopyWith<$Res> {
  factory _$$UpdatePasswordEventImplCopyWith(_$UpdatePasswordEventImpl value,
          $Res Function(_$UpdatePasswordEventImpl) then) =
      __$$UpdatePasswordEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String currentPassword, String newPassword});
}

/// @nodoc
class __$$UpdatePasswordEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UpdatePasswordEventImpl>
    implements _$$UpdatePasswordEventImplCopyWith<$Res> {
  __$$UpdatePasswordEventImplCopyWithImpl(_$UpdatePasswordEventImpl _value,
      $Res Function(_$UpdatePasswordEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_$UpdatePasswordEventImpl(
      currentPassword: null == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdatePasswordEventImpl implements UpdatePasswordEvent {
  const _$UpdatePasswordEventImpl(
      {required this.currentPassword, required this.newPassword});

  @override
  final String currentPassword;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'AuthEvent.updatePassword(currentPassword: $currentPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePasswordEventImpl &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentPassword, newPassword);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePasswordEventImplCopyWith<_$UpdatePasswordEventImpl> get copyWith =>
      __$$UpdatePasswordEventImplCopyWithImpl<_$UpdatePasswordEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return updatePassword(currentPassword, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return updatePassword?.call(currentPassword, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (updatePassword != null) {
      return updatePassword(currentPassword, newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return updatePassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return updatePassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (updatePassword != null) {
      return updatePassword(this);
    }
    return orElse();
  }
}

abstract class UpdatePasswordEvent implements AuthEvent {
  const factory UpdatePasswordEvent(
      {required final String currentPassword,
      required final String newPassword}) = _$UpdatePasswordEventImpl;

  String get currentPassword;
  String get newPassword;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePasswordEventImplCopyWith<_$UpdatePasswordEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadProfilePhotoEventImplCopyWith<$Res> {
  factory _$$UploadProfilePhotoEventImplCopyWith(
          _$UploadProfilePhotoEventImpl value,
          $Res Function(_$UploadProfilePhotoEventImpl) then) =
      __$$UploadProfilePhotoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File imageFile});
}

/// @nodoc
class __$$UploadProfilePhotoEventImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UploadProfilePhotoEventImpl>
    implements _$$UploadProfilePhotoEventImplCopyWith<$Res> {
  __$$UploadProfilePhotoEventImplCopyWithImpl(
      _$UploadProfilePhotoEventImpl _value,
      $Res Function(_$UploadProfilePhotoEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageFile = null,
  }) {
    return _then(_$UploadProfilePhotoEventImpl(
      imageFile: null == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$UploadProfilePhotoEventImpl implements UploadProfilePhotoEvent {
  const _$UploadProfilePhotoEventImpl({required this.imageFile});

  @override
  final File imageFile;

  @override
  String toString() {
    return 'AuthEvent.uploadProfilePhoto(imageFile: $imageFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadProfilePhotoEventImpl &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageFile);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadProfilePhotoEventImplCopyWith<_$UploadProfilePhotoEventImpl>
      get copyWith => __$$UploadProfilePhotoEventImplCopyWithImpl<
          _$UploadProfilePhotoEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkStatus,
    required TResult Function(String email, String password) login,
    required TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)
        register,
    required TResult Function() logout,
    required TResult Function() signInWithGoogle,
    required TResult Function() signInWithApple,
    required TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)
        updateProfile,
    required TResult Function(String newEmail, String currentPassword)
        updateEmail,
    required TResult Function(String currentPassword, String newPassword)
        updatePassword,
    required TResult Function(File imageFile) uploadProfilePhoto,
  }) {
    return uploadProfilePhoto(imageFile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkStatus,
    TResult? Function(String email, String password)? login,
    TResult? Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult? Function()? logout,
    TResult? Function()? signInWithGoogle,
    TResult? Function()? signInWithApple,
    TResult? Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult? Function(String newEmail, String currentPassword)? updateEmail,
    TResult? Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult? Function(File imageFile)? uploadProfilePhoto,
  }) {
    return uploadProfilePhoto?.call(imageFile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkStatus,
    TResult Function(String email, String password)? login,
    TResult Function(
            String email,
            String password,
            String fullName,
            String? phoneNumber,
            String? emergencyContactName,
            String? emergencyContactPhone)?
        register,
    TResult Function()? logout,
    TResult Function()? signInWithGoogle,
    TResult Function()? signInWithApple,
    TResult Function(String fullName, String? phoneNumber,
            String? emergencyContactName, String? emergencyContactPhone)?
        updateProfile,
    TResult Function(String newEmail, String currentPassword)? updateEmail,
    TResult Function(String currentPassword, String newPassword)?
        updatePassword,
    TResult Function(File imageFile)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (uploadProfilePhoto != null) {
      return uploadProfilePhoto(imageFile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkStatus,
    required TResult Function(LoginEvent value) login,
    required TResult Function(RegisterEvent value) register,
    required TResult Function(LogoutEvent value) logout,
    required TResult Function(SignInWithGoogleEvent value) signInWithGoogle,
    required TResult Function(SignInWithAppleEvent value) signInWithApple,
    required TResult Function(UpdateProfileEvent value) updateProfile,
    required TResult Function(UpdateEmailEvent value) updateEmail,
    required TResult Function(UpdatePasswordEvent value) updatePassword,
    required TResult Function(UploadProfilePhotoEvent value) uploadProfilePhoto,
  }) {
    return uploadProfilePhoto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkStatus,
    TResult? Function(LoginEvent value)? login,
    TResult? Function(RegisterEvent value)? register,
    TResult? Function(LogoutEvent value)? logout,
    TResult? Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult? Function(SignInWithAppleEvent value)? signInWithApple,
    TResult? Function(UpdateProfileEvent value)? updateProfile,
    TResult? Function(UpdateEmailEvent value)? updateEmail,
    TResult? Function(UpdatePasswordEvent value)? updatePassword,
    TResult? Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
  }) {
    return uploadProfilePhoto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkStatus,
    TResult Function(LoginEvent value)? login,
    TResult Function(RegisterEvent value)? register,
    TResult Function(LogoutEvent value)? logout,
    TResult Function(SignInWithGoogleEvent value)? signInWithGoogle,
    TResult Function(SignInWithAppleEvent value)? signInWithApple,
    TResult Function(UpdateProfileEvent value)? updateProfile,
    TResult Function(UpdateEmailEvent value)? updateEmail,
    TResult Function(UpdatePasswordEvent value)? updatePassword,
    TResult Function(UploadProfilePhotoEvent value)? uploadProfilePhoto,
    required TResult orElse(),
  }) {
    if (uploadProfilePhoto != null) {
      return uploadProfilePhoto(this);
    }
    return orElse();
  }
}

abstract class UploadProfilePhotoEvent implements AuthEvent {
  const factory UploadProfilePhotoEvent({required final File imageFile}) =
      _$UploadProfilePhotoEventImpl;

  File get imageFile;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadProfilePhotoEventImplCopyWith<_$UploadProfilePhotoEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}
