// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripEntity _$TripEntityFromJson(Map<String, dynamic> json) {
  return _TripEntity.fromJson(json);
}

/// @nodoc
mixin _$TripEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userPhone => throw _privateConstructorUsedError;
  RouteEntity get route => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  TripStatus get status => throw _privateConstructorUsedError;
  DateTime get requestedAt =>
      throw _privateConstructorUsedError; // Datos del conductor (cuando se asigna)
  String? get driverId => throw _privateConstructorUsedError;
  String? get driverName => throw _privateConstructorUsedError;
  String? get driverPhone => throw _privateConstructorUsedError;
  String? get vehicleId => throw _privateConstructorUsedError;
  String? get vehiclePlate => throw _privateConstructorUsedError; // Timestamps
  DateTime? get assignedAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt =>
      throw _privateConstructorUsedError; // Video session
  String? get videoSessionId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userName,
            String userPhone,
            RouteEntity route,
            String serviceType,
            double totalPrice,
            TripStatus status,
            DateTime requestedAt,
            String? driverId,
            String? driverName,
            String? driverPhone,
            String? vehicleId,
            String? vehiclePlate,
            DateTime? assignedAt,
            DateTime? startedAt,
            DateTime? completedAt,
            String? videoSessionId)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String userName,
            String userPhone,
            RouteEntity route,
            String serviceType,
            double totalPrice,
            TripStatus status,
            DateTime requestedAt,
            String? driverId,
            String? driverName,
            String? driverPhone,
            String? vehicleId,
            String? vehiclePlate,
            DateTime? assignedAt,
            DateTime? startedAt,
            DateTime? completedAt,
            String? videoSessionId)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userName,
            String userPhone,
            RouteEntity route,
            String serviceType,
            double totalPrice,
            TripStatus status,
            DateTime requestedAt,
            String? driverId,
            String? driverName,
            String? driverPhone,
            String? vehicleId,
            String? vehiclePlate,
            DateTime? assignedAt,
            DateTime? startedAt,
            DateTime? completedAt,
            String? videoSessionId)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TripEntity value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TripEntity value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TripEntity value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TripEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripEntityCopyWith<TripEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripEntityCopyWith<$Res> {
  factory $TripEntityCopyWith(
          TripEntity value, $Res Function(TripEntity) then) =
      _$TripEntityCopyWithImpl<$Res, TripEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String userName,
      String userPhone,
      RouteEntity route,
      String serviceType,
      double totalPrice,
      TripStatus status,
      DateTime requestedAt,
      String? driverId,
      String? driverName,
      String? driverPhone,
      String? vehicleId,
      String? vehiclePlate,
      DateTime? assignedAt,
      DateTime? startedAt,
      DateTime? completedAt,
      String? videoSessionId});

  $RouteEntityCopyWith<$Res> get route;
}

/// @nodoc
class _$TripEntityCopyWithImpl<$Res, $Val extends TripEntity>
    implements $TripEntityCopyWith<$Res> {
  _$TripEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? route = null,
    Object? serviceType = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? requestedAt = null,
    Object? driverId = freezed,
    Object? driverName = freezed,
    Object? driverPhone = freezed,
    Object? vehicleId = freezed,
    Object? vehiclePlate = freezed,
    Object? assignedAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? videoSessionId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as RouteEntity,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TripStatus,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverPhone: freezed == driverPhone
          ? _value.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String?,
      vehiclePlate: freezed == vehiclePlate
          ? _value.vehiclePlate
          : vehiclePlate // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedAt: freezed == assignedAt
          ? _value.assignedAt
          : assignedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      videoSessionId: freezed == videoSessionId
          ? _value.videoSessionId
          : videoSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TripEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteEntityCopyWith<$Res> get route {
    return $RouteEntityCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripEntityImplCopyWith<$Res>
    implements $TripEntityCopyWith<$Res> {
  factory _$$TripEntityImplCopyWith(
          _$TripEntityImpl value, $Res Function(_$TripEntityImpl) then) =
      __$$TripEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String userName,
      String userPhone,
      RouteEntity route,
      String serviceType,
      double totalPrice,
      TripStatus status,
      DateTime requestedAt,
      String? driverId,
      String? driverName,
      String? driverPhone,
      String? vehicleId,
      String? vehiclePlate,
      DateTime? assignedAt,
      DateTime? startedAt,
      DateTime? completedAt,
      String? videoSessionId});

  @override
  $RouteEntityCopyWith<$Res> get route;
}

/// @nodoc
class __$$TripEntityImplCopyWithImpl<$Res>
    extends _$TripEntityCopyWithImpl<$Res, _$TripEntityImpl>
    implements _$$TripEntityImplCopyWith<$Res> {
  __$$TripEntityImplCopyWithImpl(
      _$TripEntityImpl _value, $Res Function(_$TripEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? route = null,
    Object? serviceType = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? requestedAt = null,
    Object? driverId = freezed,
    Object? driverName = freezed,
    Object? driverPhone = freezed,
    Object? vehicleId = freezed,
    Object? vehiclePlate = freezed,
    Object? assignedAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? videoSessionId = freezed,
  }) {
    return _then(_$TripEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as RouteEntity,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TripStatus,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverPhone: freezed == driverPhone
          ? _value.driverPhone
          : driverPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String?,
      vehiclePlate: freezed == vehiclePlate
          ? _value.vehiclePlate
          : vehiclePlate // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedAt: freezed == assignedAt
          ? _value.assignedAt
          : assignedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      videoSessionId: freezed == videoSessionId
          ? _value.videoSessionId
          : videoSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripEntityImpl extends _TripEntity {
  const _$TripEntityImpl(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.userPhone,
      required this.route,
      required this.serviceType,
      required this.totalPrice,
      required this.status,
      required this.requestedAt,
      this.driverId,
      this.driverName,
      this.driverPhone,
      this.vehicleId,
      this.vehiclePlate,
      this.assignedAt,
      this.startedAt,
      this.completedAt,
      this.videoSessionId})
      : super._();

  factory _$TripEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String userPhone;
  @override
  final RouteEntity route;
  @override
  final String serviceType;
  @override
  final double totalPrice;
  @override
  final TripStatus status;
  @override
  final DateTime requestedAt;
// Datos del conductor (cuando se asigna)
  @override
  final String? driverId;
  @override
  final String? driverName;
  @override
  final String? driverPhone;
  @override
  final String? vehicleId;
  @override
  final String? vehiclePlate;
// Timestamps
  @override
  final DateTime? assignedAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
// Video session
  @override
  final String? videoSessionId;

  @override
  String toString() {
    return 'TripEntity(id: $id, userId: $userId, userName: $userName, userPhone: $userPhone, route: $route, serviceType: $serviceType, totalPrice: $totalPrice, status: $status, requestedAt: $requestedAt, driverId: $driverId, driverName: $driverName, driverPhone: $driverPhone, vehicleId: $vehicleId, vehiclePlate: $vehiclePlate, assignedAt: $assignedAt, startedAt: $startedAt, completedAt: $completedAt, videoSessionId: $videoSessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverPhone, driverPhone) ||
                other.driverPhone == driverPhone) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.vehiclePlate, vehiclePlate) ||
                other.vehiclePlate == vehiclePlate) &&
            (identical(other.assignedAt, assignedAt) ||
                other.assignedAt == assignedAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.videoSessionId, videoSessionId) ||
                other.videoSessionId == videoSessionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      userName,
      userPhone,
      route,
      serviceType,
      totalPrice,
      status,
      requestedAt,
      driverId,
      driverName,
      driverPhone,
      vehicleId,
      vehiclePlate,
      assignedAt,
      startedAt,
      completedAt,
      videoSessionId);

  /// Create a copy of TripEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripEntityImplCopyWith<_$TripEntityImpl> get copyWith =>
      __$$TripEntityImplCopyWithImpl<_$TripEntityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userName,
            String userPhone,
            RouteEntity route,
            String serviceType,
            double totalPrice,
            TripStatus status,
            DateTime requestedAt,
            String? driverId,
            String? driverName,
            String? driverPhone,
            String? vehicleId,
            String? vehiclePlate,
            DateTime? assignedAt,
            DateTime? startedAt,
            DateTime? completedAt,
            String? videoSessionId)
        $default,
  ) {
    return $default(
        id,
        userId,
        userName,
        userPhone,
        route,
        serviceType,
        totalPrice,
        status,
        requestedAt,
        driverId,
        driverName,
        driverPhone,
        vehicleId,
        vehiclePlate,
        assignedAt,
        startedAt,
        completedAt,
        videoSessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String userName,
            String userPhone,
            RouteEntity route,
            String serviceType,
            double totalPrice,
            TripStatus status,
            DateTime requestedAt,
            String? driverId,
            String? driverName,
            String? driverPhone,
            String? vehicleId,
            String? vehiclePlate,
            DateTime? assignedAt,
            DateTime? startedAt,
            DateTime? completedAt,
            String? videoSessionId)?
        $default,
  ) {
    return $default?.call(
        id,
        userId,
        userName,
        userPhone,
        route,
        serviceType,
        totalPrice,
        status,
        requestedAt,
        driverId,
        driverName,
        driverPhone,
        vehicleId,
        vehiclePlate,
        assignedAt,
        startedAt,
        completedAt,
        videoSessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userName,
            String userPhone,
            RouteEntity route,
            String serviceType,
            double totalPrice,
            TripStatus status,
            DateTime requestedAt,
            String? driverId,
            String? driverName,
            String? driverPhone,
            String? vehicleId,
            String? vehiclePlate,
            DateTime? assignedAt,
            DateTime? startedAt,
            DateTime? completedAt,
            String? videoSessionId)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          userId,
          userName,
          userPhone,
          route,
          serviceType,
          totalPrice,
          status,
          requestedAt,
          driverId,
          driverName,
          driverPhone,
          vehicleId,
          vehiclePlate,
          assignedAt,
          startedAt,
          completedAt,
          videoSessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TripEntity value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TripEntity value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TripEntity value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripEntityImplToJson(
      this,
    );
  }
}

abstract class _TripEntity extends TripEntity {
  const factory _TripEntity(
      {required final String id,
      required final String userId,
      required final String userName,
      required final String userPhone,
      required final RouteEntity route,
      required final String serviceType,
      required final double totalPrice,
      required final TripStatus status,
      required final DateTime requestedAt,
      final String? driverId,
      final String? driverName,
      final String? driverPhone,
      final String? vehicleId,
      final String? vehiclePlate,
      final DateTime? assignedAt,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? videoSessionId}) = _$TripEntityImpl;
  const _TripEntity._() : super._();

  factory _TripEntity.fromJson(Map<String, dynamic> json) =
      _$TripEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String get userPhone;
  @override
  RouteEntity get route;
  @override
  String get serviceType;
  @override
  double get totalPrice;
  @override
  TripStatus get status;
  @override
  DateTime get requestedAt; // Datos del conductor (cuando se asigna)
  @override
  String? get driverId;
  @override
  String? get driverName;
  @override
  String? get driverPhone;
  @override
  String? get vehicleId;
  @override
  String? get vehiclePlate; // Timestamps
  @override
  DateTime? get assignedAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt; // Video session
  @override
  String? get videoSessionId;

  /// Create a copy of TripEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripEntityImplCopyWith<_$TripEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
