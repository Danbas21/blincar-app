// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return _Driver.fromJson(json);
}

/// @nodoc
mixin _$Driver {
  String get id => throw _privateConstructorUsedError;
  String get firebaseUid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get licenseNumber => throw _privateConstructorUsedError;
  DateTime? get licenseExpiryDate => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get currentTripId => throw _privateConstructorUsedError;
  Coordinates? get currentLocation => throw _privateConstructorUsedError;
  String? get profilePhotoUrl => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int get totalTrips => throw _privateConstructorUsedError;
  DateTime? get lastUpdate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String firebaseUid,
            String email,
            String phoneNumber,
            String fullName,
            String? licenseNumber,
            DateTime? licenseExpiryDate,
            bool isAvailable,
            bool isActive,
            String? currentTripId,
            Coordinates? currentLocation,
            String? profilePhotoUrl,
            double? rating,
            int totalTrips,
            DateTime? lastUpdate)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String firebaseUid,
            String email,
            String phoneNumber,
            String fullName,
            String? licenseNumber,
            DateTime? licenseExpiryDate,
            bool isAvailable,
            bool isActive,
            String? currentTripId,
            Coordinates? currentLocation,
            String? profilePhotoUrl,
            double? rating,
            int totalTrips,
            DateTime? lastUpdate)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String firebaseUid,
            String email,
            String phoneNumber,
            String fullName,
            String? licenseNumber,
            DateTime? licenseExpiryDate,
            bool isAvailable,
            bool isActive,
            String? currentTripId,
            Coordinates? currentLocation,
            String? profilePhotoUrl,
            double? rating,
            int totalTrips,
            DateTime? lastUpdate)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Driver value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Driver value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Driver value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Driver to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverCopyWith<Driver> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverCopyWith<$Res> {
  factory $DriverCopyWith(Driver value, $Res Function(Driver) then) =
      _$DriverCopyWithImpl<$Res, Driver>;
  @useResult
  $Res call(
      {String id,
      String firebaseUid,
      String email,
      String phoneNumber,
      String fullName,
      String? licenseNumber,
      DateTime? licenseExpiryDate,
      bool isAvailable,
      bool isActive,
      String? currentTripId,
      Coordinates? currentLocation,
      String? profilePhotoUrl,
      double? rating,
      int totalTrips,
      DateTime? lastUpdate});

  $CoordinatesCopyWith<$Res>? get currentLocation;
}

/// @nodoc
class _$DriverCopyWithImpl<$Res, $Val extends Driver>
    implements $DriverCopyWith<$Res> {
  _$DriverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firebaseUid = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? fullName = null,
    Object? licenseNumber = freezed,
    Object? licenseExpiryDate = freezed,
    Object? isAvailable = null,
    Object? isActive = null,
    Object? currentTripId = freezed,
    Object? currentLocation = freezed,
    Object? profilePhotoUrl = freezed,
    Object? rating = freezed,
    Object? totalTrips = null,
    Object? lastUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseUid: null == firebaseUid
          ? _value.firebaseUid
          : firebaseUid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNumber: freezed == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      licenseExpiryDate: freezed == licenseExpiryDate
          ? _value.licenseExpiryDate
          : licenseExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTripId: freezed == currentTripId
          ? _value.currentTripId
          : currentTripId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalTrips: null == totalTrips
          ? _value.totalTrips
          : totalTrips // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinatesCopyWith<$Res>? get currentLocation {
    if (_value.currentLocation == null) {
      return null;
    }

    return $CoordinatesCopyWith<$Res>(_value.currentLocation!, (value) {
      return _then(_value.copyWith(currentLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverImplCopyWith<$Res> implements $DriverCopyWith<$Res> {
  factory _$$DriverImplCopyWith(
          _$DriverImpl value, $Res Function(_$DriverImpl) then) =
      __$$DriverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firebaseUid,
      String email,
      String phoneNumber,
      String fullName,
      String? licenseNumber,
      DateTime? licenseExpiryDate,
      bool isAvailable,
      bool isActive,
      String? currentTripId,
      Coordinates? currentLocation,
      String? profilePhotoUrl,
      double? rating,
      int totalTrips,
      DateTime? lastUpdate});

  @override
  $CoordinatesCopyWith<$Res>? get currentLocation;
}

/// @nodoc
class __$$DriverImplCopyWithImpl<$Res>
    extends _$DriverCopyWithImpl<$Res, _$DriverImpl>
    implements _$$DriverImplCopyWith<$Res> {
  __$$DriverImplCopyWithImpl(
      _$DriverImpl _value, $Res Function(_$DriverImpl) _then)
      : super(_value, _then);

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firebaseUid = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? fullName = null,
    Object? licenseNumber = freezed,
    Object? licenseExpiryDate = freezed,
    Object? isAvailable = null,
    Object? isActive = null,
    Object? currentTripId = freezed,
    Object? currentLocation = freezed,
    Object? profilePhotoUrl = freezed,
    Object? rating = freezed,
    Object? totalTrips = null,
    Object? lastUpdate = freezed,
  }) {
    return _then(_$DriverImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseUid: null == firebaseUid
          ? _value.firebaseUid
          : firebaseUid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNumber: freezed == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      licenseExpiryDate: freezed == licenseExpiryDate
          ? _value.licenseExpiryDate
          : licenseExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTripId: freezed == currentTripId
          ? _value.currentTripId
          : currentTripId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalTrips: null == totalTrips
          ? _value.totalTrips
          : totalTrips // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverImpl extends _Driver {
  const _$DriverImpl(
      {required this.id,
      required this.firebaseUid,
      required this.email,
      required this.phoneNumber,
      required this.fullName,
      this.licenseNumber,
      this.licenseExpiryDate,
      this.isAvailable = true,
      this.isActive = true,
      this.currentTripId,
      this.currentLocation,
      this.profilePhotoUrl,
      this.rating,
      this.totalTrips = 0,
      this.lastUpdate})
      : super._();

  factory _$DriverImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverImplFromJson(json);

  @override
  final String id;
  @override
  final String firebaseUid;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final String fullName;
  @override
  final String? licenseNumber;
  @override
  final DateTime? licenseExpiryDate;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? currentTripId;
  @override
  final Coordinates? currentLocation;
  @override
  final String? profilePhotoUrl;
  @override
  final double? rating;
  @override
  @JsonKey()
  final int totalTrips;
  @override
  final DateTime? lastUpdate;

  @override
  String toString() {
    return 'Driver(id: $id, firebaseUid: $firebaseUid, email: $email, phoneNumber: $phoneNumber, fullName: $fullName, licenseNumber: $licenseNumber, licenseExpiryDate: $licenseExpiryDate, isAvailable: $isAvailable, isActive: $isActive, currentTripId: $currentTripId, currentLocation: $currentLocation, profilePhotoUrl: $profilePhotoUrl, rating: $rating, totalTrips: $totalTrips, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firebaseUid, firebaseUid) ||
                other.firebaseUid == firebaseUid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.licenseNumber, licenseNumber) ||
                other.licenseNumber == licenseNumber) &&
            (identical(other.licenseExpiryDate, licenseExpiryDate) ||
                other.licenseExpiryDate == licenseExpiryDate) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.currentTripId, currentTripId) ||
                other.currentTripId == currentTripId) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalTrips, totalTrips) ||
                other.totalTrips == totalTrips) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firebaseUid,
      email,
      phoneNumber,
      fullName,
      licenseNumber,
      licenseExpiryDate,
      isAvailable,
      isActive,
      currentTripId,
      currentLocation,
      profilePhotoUrl,
      rating,
      totalTrips,
      lastUpdate);

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverImplCopyWith<_$DriverImpl> get copyWith =>
      __$$DriverImplCopyWithImpl<_$DriverImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String firebaseUid,
            String email,
            String phoneNumber,
            String fullName,
            String? licenseNumber,
            DateTime? licenseExpiryDate,
            bool isAvailable,
            bool isActive,
            String? currentTripId,
            Coordinates? currentLocation,
            String? profilePhotoUrl,
            double? rating,
            int totalTrips,
            DateTime? lastUpdate)
        $default,
  ) {
    return $default(
        id,
        firebaseUid,
        email,
        phoneNumber,
        fullName,
        licenseNumber,
        licenseExpiryDate,
        isAvailable,
        isActive,
        currentTripId,
        currentLocation,
        profilePhotoUrl,
        rating,
        totalTrips,
        lastUpdate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String firebaseUid,
            String email,
            String phoneNumber,
            String fullName,
            String? licenseNumber,
            DateTime? licenseExpiryDate,
            bool isAvailable,
            bool isActive,
            String? currentTripId,
            Coordinates? currentLocation,
            String? profilePhotoUrl,
            double? rating,
            int totalTrips,
            DateTime? lastUpdate)?
        $default,
  ) {
    return $default?.call(
        id,
        firebaseUid,
        email,
        phoneNumber,
        fullName,
        licenseNumber,
        licenseExpiryDate,
        isAvailable,
        isActive,
        currentTripId,
        currentLocation,
        profilePhotoUrl,
        rating,
        totalTrips,
        lastUpdate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String firebaseUid,
            String email,
            String phoneNumber,
            String fullName,
            String? licenseNumber,
            DateTime? licenseExpiryDate,
            bool isAvailable,
            bool isActive,
            String? currentTripId,
            Coordinates? currentLocation,
            String? profilePhotoUrl,
            double? rating,
            int totalTrips,
            DateTime? lastUpdate)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          firebaseUid,
          email,
          phoneNumber,
          fullName,
          licenseNumber,
          licenseExpiryDate,
          isAvailable,
          isActive,
          currentTripId,
          currentLocation,
          profilePhotoUrl,
          rating,
          totalTrips,
          lastUpdate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Driver value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Driver value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Driver value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverImplToJson(
      this,
    );
  }
}

abstract class _Driver extends Driver {
  const factory _Driver(
      {required final String id,
      required final String firebaseUid,
      required final String email,
      required final String phoneNumber,
      required final String fullName,
      final String? licenseNumber,
      final DateTime? licenseExpiryDate,
      final bool isAvailable,
      final bool isActive,
      final String? currentTripId,
      final Coordinates? currentLocation,
      final String? profilePhotoUrl,
      final double? rating,
      final int totalTrips,
      final DateTime? lastUpdate}) = _$DriverImpl;
  const _Driver._() : super._();

  factory _Driver.fromJson(Map<String, dynamic> json) = _$DriverImpl.fromJson;

  @override
  String get id;
  @override
  String get firebaseUid;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  String get fullName;
  @override
  String? get licenseNumber;
  @override
  DateTime? get licenseExpiryDate;
  @override
  bool get isAvailable;
  @override
  bool get isActive;
  @override
  String? get currentTripId;
  @override
  Coordinates? get currentLocation;
  @override
  String? get profilePhotoUrl;
  @override
  double? get rating;
  @override
  int get totalTrips;
  @override
  DateTime? get lastUpdate;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverImplCopyWith<_$DriverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
