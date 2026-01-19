// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return _Vehicle.fromJson(json);
}

/// @nodoc
mixin _$Vehicle {
  String get id => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  VehicleType get type => throw _privateConstructorUsedError;
  String get licensePlate => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  bool get isArmored => throw _privateConstructorUsedError;
  String? get armorLevel =>
      throw _privateConstructorUsedError; // "Nivel III", etc.
  String get color => throw _privateConstructorUsedError;
  String? get interiors => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  String? get currentDriverId => throw _privateConstructorUsedError;
  String? get currentTripId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String brand,
            String model,
            int year,
            VehicleType type,
            String licensePlate,
            int capacity,
            bool isArmored,
            String? armorLevel,
            String color,
            String? interiors,
            String? photoUrl,
            bool isAvailable,
            String? currentDriverId,
            String? currentTripId)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String brand,
            String model,
            int year,
            VehicleType type,
            String licensePlate,
            int capacity,
            bool isArmored,
            String? armorLevel,
            String color,
            String? interiors,
            String? photoUrl,
            bool isAvailable,
            String? currentDriverId,
            String? currentTripId)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String brand,
            String model,
            int year,
            VehicleType type,
            String licensePlate,
            int capacity,
            bool isArmored,
            String? armorLevel,
            String color,
            String? interiors,
            String? photoUrl,
            bool isAvailable,
            String? currentDriverId,
            String? currentTripId)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Vehicle value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Vehicle value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Vehicle value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res, Vehicle>;
  @useResult
  $Res call(
      {String id,
      String brand,
      String model,
      int year,
      VehicleType type,
      String licensePlate,
      int capacity,
      bool isArmored,
      String? armorLevel,
      String color,
      String? interiors,
      String? photoUrl,
      bool isAvailable,
      String? currentDriverId,
      String? currentTripId});
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res, $Val extends Vehicle>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brand = null,
    Object? model = null,
    Object? year = null,
    Object? type = null,
    Object? licensePlate = null,
    Object? capacity = null,
    Object? isArmored = null,
    Object? armorLevel = freezed,
    Object? color = null,
    Object? interiors = freezed,
    Object? photoUrl = freezed,
    Object? isAvailable = null,
    Object? currentDriverId = freezed,
    Object? currentTripId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VehicleType,
      licensePlate: null == licensePlate
          ? _value.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      isArmored: null == isArmored
          ? _value.isArmored
          : isArmored // ignore: cast_nullable_to_non_nullable
              as bool,
      armorLevel: freezed == armorLevel
          ? _value.armorLevel
          : armorLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      interiors: freezed == interiors
          ? _value.interiors
          : interiors // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      currentDriverId: freezed == currentDriverId
          ? _value.currentDriverId
          : currentDriverId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTripId: freezed == currentTripId
          ? _value.currentTripId
          : currentTripId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleImplCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$$VehicleImplCopyWith(
          _$VehicleImpl value, $Res Function(_$VehicleImpl) then) =
      __$$VehicleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String brand,
      String model,
      int year,
      VehicleType type,
      String licensePlate,
      int capacity,
      bool isArmored,
      String? armorLevel,
      String color,
      String? interiors,
      String? photoUrl,
      bool isAvailable,
      String? currentDriverId,
      String? currentTripId});
}

/// @nodoc
class __$$VehicleImplCopyWithImpl<$Res>
    extends _$VehicleCopyWithImpl<$Res, _$VehicleImpl>
    implements _$$VehicleImplCopyWith<$Res> {
  __$$VehicleImplCopyWithImpl(
      _$VehicleImpl _value, $Res Function(_$VehicleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brand = null,
    Object? model = null,
    Object? year = null,
    Object? type = null,
    Object? licensePlate = null,
    Object? capacity = null,
    Object? isArmored = null,
    Object? armorLevel = freezed,
    Object? color = null,
    Object? interiors = freezed,
    Object? photoUrl = freezed,
    Object? isAvailable = null,
    Object? currentDriverId = freezed,
    Object? currentTripId = freezed,
  }) {
    return _then(_$VehicleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VehicleType,
      licensePlate: null == licensePlate
          ? _value.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      isArmored: null == isArmored
          ? _value.isArmored
          : isArmored // ignore: cast_nullable_to_non_nullable
              as bool,
      armorLevel: freezed == armorLevel
          ? _value.armorLevel
          : armorLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      interiors: freezed == interiors
          ? _value.interiors
          : interiors // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      currentDriverId: freezed == currentDriverId
          ? _value.currentDriverId
          : currentDriverId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTripId: freezed == currentTripId
          ? _value.currentTripId
          : currentTripId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleImpl extends _Vehicle {
  const _$VehicleImpl(
      {required this.id,
      required this.brand,
      required this.model,
      required this.year,
      required this.type,
      required this.licensePlate,
      required this.capacity,
      this.isArmored = false,
      this.armorLevel,
      required this.color,
      this.interiors,
      this.photoUrl,
      this.isAvailable = true,
      this.currentDriverId,
      this.currentTripId})
      : super._();

  factory _$VehicleImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleImplFromJson(json);

  @override
  final String id;
  @override
  final String brand;
  @override
  final String model;
  @override
  final int year;
  @override
  final VehicleType type;
  @override
  final String licensePlate;
  @override
  final int capacity;
  @override
  @JsonKey()
  final bool isArmored;
  @override
  final String? armorLevel;
// "Nivel III", etc.
  @override
  final String color;
  @override
  final String? interiors;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  final String? currentDriverId;
  @override
  final String? currentTripId;

  @override
  String toString() {
    return 'Vehicle(id: $id, brand: $brand, model: $model, year: $year, type: $type, licensePlate: $licensePlate, capacity: $capacity, isArmored: $isArmored, armorLevel: $armorLevel, color: $color, interiors: $interiors, photoUrl: $photoUrl, isAvailable: $isAvailable, currentDriverId: $currentDriverId, currentTripId: $currentTripId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.licensePlate, licensePlate) ||
                other.licensePlate == licensePlate) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.isArmored, isArmored) ||
                other.isArmored == isArmored) &&
            (identical(other.armorLevel, armorLevel) ||
                other.armorLevel == armorLevel) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.interiors, interiors) ||
                other.interiors == interiors) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.currentDriverId, currentDriverId) ||
                other.currentDriverId == currentDriverId) &&
            (identical(other.currentTripId, currentTripId) ||
                other.currentTripId == currentTripId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      brand,
      model,
      year,
      type,
      licensePlate,
      capacity,
      isArmored,
      armorLevel,
      color,
      interiors,
      photoUrl,
      isAvailable,
      currentDriverId,
      currentTripId);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      __$$VehicleImplCopyWithImpl<_$VehicleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String brand,
            String model,
            int year,
            VehicleType type,
            String licensePlate,
            int capacity,
            bool isArmored,
            String? armorLevel,
            String color,
            String? interiors,
            String? photoUrl,
            bool isAvailable,
            String? currentDriverId,
            String? currentTripId)
        $default,
  ) {
    return $default(
        id,
        brand,
        model,
        year,
        type,
        licensePlate,
        capacity,
        isArmored,
        armorLevel,
        color,
        interiors,
        photoUrl,
        isAvailable,
        currentDriverId,
        currentTripId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String brand,
            String model,
            int year,
            VehicleType type,
            String licensePlate,
            int capacity,
            bool isArmored,
            String? armorLevel,
            String color,
            String? interiors,
            String? photoUrl,
            bool isAvailable,
            String? currentDriverId,
            String? currentTripId)?
        $default,
  ) {
    return $default?.call(
        id,
        brand,
        model,
        year,
        type,
        licensePlate,
        capacity,
        isArmored,
        armorLevel,
        color,
        interiors,
        photoUrl,
        isAvailable,
        currentDriverId,
        currentTripId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String brand,
            String model,
            int year,
            VehicleType type,
            String licensePlate,
            int capacity,
            bool isArmored,
            String? armorLevel,
            String color,
            String? interiors,
            String? photoUrl,
            bool isAvailable,
            String? currentDriverId,
            String? currentTripId)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          brand,
          model,
          year,
          type,
          licensePlate,
          capacity,
          isArmored,
          armorLevel,
          color,
          interiors,
          photoUrl,
          isAvailable,
          currentDriverId,
          currentTripId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Vehicle value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Vehicle value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Vehicle value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleImplToJson(
      this,
    );
  }
}

abstract class _Vehicle extends Vehicle {
  const factory _Vehicle(
      {required final String id,
      required final String brand,
      required final String model,
      required final int year,
      required final VehicleType type,
      required final String licensePlate,
      required final int capacity,
      final bool isArmored,
      final String? armorLevel,
      required final String color,
      final String? interiors,
      final String? photoUrl,
      final bool isAvailable,
      final String? currentDriverId,
      final String? currentTripId}) = _$VehicleImpl;
  const _Vehicle._() : super._();

  factory _Vehicle.fromJson(Map<String, dynamic> json) = _$VehicleImpl.fromJson;

  @override
  String get id;
  @override
  String get brand;
  @override
  String get model;
  @override
  int get year;
  @override
  VehicleType get type;
  @override
  String get licensePlate;
  @override
  int get capacity;
  @override
  bool get isArmored;
  @override
  String? get armorLevel; // "Nivel III", etc.
  @override
  String get color;
  @override
  String? get interiors;
  @override
  String? get photoUrl;
  @override
  bool get isAvailable;
  @override
  String? get currentDriverId;
  @override
  String? get currentTripId;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
