// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationPoint _$LocationPointFromJson(Map<String, dynamic> json) {
  return _LocationPoint.fromJson(json);
}

/// @nodoc
mixin _$LocationPoint {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String name, String address, double latitude, double longitude)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String name, String address, double latitude, double longitude)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String name, String address, double latitude, double longitude)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LocationPoint value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LocationPoint value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LocationPoint value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this LocationPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationPointCopyWith<LocationPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPointCopyWith<$Res> {
  factory $LocationPointCopyWith(
          LocationPoint value, $Res Function(LocationPoint) then) =
      _$LocationPointCopyWithImpl<$Res, LocationPoint>;
  @useResult
  $Res call({String name, String address, double latitude, double longitude});
}

/// @nodoc
class _$LocationPointCopyWithImpl<$Res, $Val extends LocationPoint>
    implements $LocationPointCopyWith<$Res> {
  _$LocationPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationPointImplCopyWith<$Res>
    implements $LocationPointCopyWith<$Res> {
  factory _$$LocationPointImplCopyWith(
          _$LocationPointImpl value, $Res Function(_$LocationPointImpl) then) =
      __$$LocationPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String address, double latitude, double longitude});
}

/// @nodoc
class __$$LocationPointImplCopyWithImpl<$Res>
    extends _$LocationPointCopyWithImpl<$Res, _$LocationPointImpl>
    implements _$$LocationPointImplCopyWith<$Res> {
  __$$LocationPointImplCopyWithImpl(
      _$LocationPointImpl _value, $Res Function(_$LocationPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LocationPointImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationPointImpl extends _LocationPoint {
  const _$LocationPointImpl(
      {required this.name,
      required this.address,
      required this.latitude,
      required this.longitude})
      : super._();

  factory _$LocationPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationPointImplFromJson(json);

  @override
  final String name;
  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'LocationPoint(name: $name, address: $address, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPointImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, address, latitude, longitude);

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPointImplCopyWith<_$LocationPointImpl> get copyWith =>
      __$$LocationPointImplCopyWithImpl<_$LocationPointImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String name, String address, double latitude, double longitude)
        $default,
  ) {
    return $default(name, address, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String name, String address, double latitude, double longitude)?
        $default,
  ) {
    return $default?.call(name, address, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String name, String address, double latitude, double longitude)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(name, address, latitude, longitude);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LocationPoint value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LocationPoint value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LocationPoint value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationPointImplToJson(
      this,
    );
  }
}

abstract class _LocationPoint extends LocationPoint {
  const factory _LocationPoint(
      {required final String name,
      required final String address,
      required final double latitude,
      required final double longitude}) = _$LocationPointImpl;
  const _LocationPoint._() : super._();

  factory _LocationPoint.fromJson(Map<String, dynamic> json) =
      _$LocationPointImpl.fromJson;

  @override
  String get name;
  @override
  String get address;
  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of LocationPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationPointImplCopyWith<_$LocationPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteEntity _$RouteEntityFromJson(Map<String, dynamic> json) {
  return _RouteEntity.fromJson(json);
}

/// @nodoc
mixin _$RouteEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  LocationPoint get origin => throw _privateConstructorUsedError;
  LocationPoint get destination => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;
  int get estimatedDurationMinutes => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError; // MXN
  double? get tollCost => throw _privateConstructorUsedError; // MXN (casetas)
  RouteCategory get category => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            LocationPoint origin,
            LocationPoint destination,
            double distanceKm,
            int estimatedDurationMinutes,
            double basePrice,
            double? tollCost,
            RouteCategory category)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            LocationPoint origin,
            LocationPoint destination,
            double distanceKm,
            int estimatedDurationMinutes,
            double basePrice,
            double? tollCost,
            RouteCategory category)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            LocationPoint origin,
            LocationPoint destination,
            double distanceKm,
            int estimatedDurationMinutes,
            double basePrice,
            double? tollCost,
            RouteCategory category)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RouteEntity value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RouteEntity value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RouteEntity value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this RouteEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteEntityCopyWith<RouteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteEntityCopyWith<$Res> {
  factory $RouteEntityCopyWith(
          RouteEntity value, $Res Function(RouteEntity) then) =
      _$RouteEntityCopyWithImpl<$Res, RouteEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      LocationPoint origin,
      LocationPoint destination,
      double distanceKm,
      int estimatedDurationMinutes,
      double basePrice,
      double? tollCost,
      RouteCategory category});

  $LocationPointCopyWith<$Res> get origin;
  $LocationPointCopyWith<$Res> get destination;
}

/// @nodoc
class _$RouteEntityCopyWithImpl<$Res, $Val extends RouteEntity>
    implements $RouteEntityCopyWith<$Res> {
  _$RouteEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? origin = null,
    Object? destination = null,
    Object? distanceKm = null,
    Object? estimatedDurationMinutes = null,
    Object? basePrice = null,
    Object? tollCost = freezed,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      distanceKm: null == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      tollCost: freezed == tollCost
          ? _value.tollCost
          : tollCost // ignore: cast_nullable_to_non_nullable
              as double?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as RouteCategory,
    ) as $Val);
  }

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get origin {
    return $LocationPointCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationPointCopyWith<$Res> get destination {
    return $LocationPointCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteEntityImplCopyWith<$Res>
    implements $RouteEntityCopyWith<$Res> {
  factory _$$RouteEntityImplCopyWith(
          _$RouteEntityImpl value, $Res Function(_$RouteEntityImpl) then) =
      __$$RouteEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      LocationPoint origin,
      LocationPoint destination,
      double distanceKm,
      int estimatedDurationMinutes,
      double basePrice,
      double? tollCost,
      RouteCategory category});

  @override
  $LocationPointCopyWith<$Res> get origin;
  @override
  $LocationPointCopyWith<$Res> get destination;
}

/// @nodoc
class __$$RouteEntityImplCopyWithImpl<$Res>
    extends _$RouteEntityCopyWithImpl<$Res, _$RouteEntityImpl>
    implements _$$RouteEntityImplCopyWith<$Res> {
  __$$RouteEntityImplCopyWithImpl(
      _$RouteEntityImpl _value, $Res Function(_$RouteEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? origin = null,
    Object? destination = null,
    Object? distanceKm = null,
    Object? estimatedDurationMinutes = null,
    Object? basePrice = null,
    Object? tollCost = freezed,
    Object? category = null,
  }) {
    return _then(_$RouteEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as LocationPoint,
      distanceKm: null == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      tollCost: freezed == tollCost
          ? _value.tollCost
          : tollCost // ignore: cast_nullable_to_non_nullable
              as double?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as RouteCategory,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteEntityImpl extends _RouteEntity {
  const _$RouteEntityImpl(
      {required this.id,
      required this.name,
      required this.origin,
      required this.destination,
      required this.distanceKm,
      required this.estimatedDurationMinutes,
      required this.basePrice,
      this.tollCost,
      required this.category})
      : super._();

  factory _$RouteEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final LocationPoint origin;
  @override
  final LocationPoint destination;
  @override
  final double distanceKm;
  @override
  final int estimatedDurationMinutes;
  @override
  final double basePrice;
// MXN
  @override
  final double? tollCost;
// MXN (casetas)
  @override
  final RouteCategory category;

  @override
  String toString() {
    return 'RouteEntity(id: $id, name: $name, origin: $origin, destination: $destination, distanceKm: $distanceKm, estimatedDurationMinutes: $estimatedDurationMinutes, basePrice: $basePrice, tollCost: $tollCost, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(
                    other.estimatedDurationMinutes, estimatedDurationMinutes) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.tollCost, tollCost) ||
                other.tollCost == tollCost) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, origin, destination,
      distanceKm, estimatedDurationMinutes, basePrice, tollCost, category);

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteEntityImplCopyWith<_$RouteEntityImpl> get copyWith =>
      __$$RouteEntityImplCopyWithImpl<_$RouteEntityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            LocationPoint origin,
            LocationPoint destination,
            double distanceKm,
            int estimatedDurationMinutes,
            double basePrice,
            double? tollCost,
            RouteCategory category)
        $default,
  ) {
    return $default(id, name, origin, destination, distanceKm,
        estimatedDurationMinutes, basePrice, tollCost, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            LocationPoint origin,
            LocationPoint destination,
            double distanceKm,
            int estimatedDurationMinutes,
            double basePrice,
            double? tollCost,
            RouteCategory category)?
        $default,
  ) {
    return $default?.call(id, name, origin, destination, distanceKm,
        estimatedDurationMinutes, basePrice, tollCost, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            LocationPoint origin,
            LocationPoint destination,
            double distanceKm,
            int estimatedDurationMinutes,
            double basePrice,
            double? tollCost,
            RouteCategory category)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, name, origin, destination, distanceKm,
          estimatedDurationMinutes, basePrice, tollCost, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RouteEntity value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RouteEntity value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RouteEntity value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteEntityImplToJson(
      this,
    );
  }
}

abstract class _RouteEntity extends RouteEntity {
  const factory _RouteEntity(
      {required final String id,
      required final String name,
      required final LocationPoint origin,
      required final LocationPoint destination,
      required final double distanceKm,
      required final int estimatedDurationMinutes,
      required final double basePrice,
      final double? tollCost,
      required final RouteCategory category}) = _$RouteEntityImpl;
  const _RouteEntity._() : super._();

  factory _RouteEntity.fromJson(Map<String, dynamic> json) =
      _$RouteEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  LocationPoint get origin;
  @override
  LocationPoint get destination;
  @override
  double get distanceKm;
  @override
  int get estimatedDurationMinutes;
  @override
  double get basePrice; // MXN
  @override
  double? get tollCost; // MXN (casetas)
  @override
  RouteCategory get category;

  /// Create a copy of RouteEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteEntityImplCopyWith<_$RouteEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
