// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripRequest _$TripRequestFromJson(Map<String, dynamic> json) {
  return _TripRequest.fromJson(json);
}

/// @nodoc
mixin _$TripRequest {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userEmail => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get servicePackageId => throw _privateConstructorUsedError;
  String get servicePackageName => throw _privateConstructorUsedError;
  Location get origin => throw _privateConstructorUsedError;
  Location get destination => throw _privateConstructorUsedError;
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  double get estimatedDistance =>
      throw _privateConstructorUsedError; // En kilometros
  int get estimatedDuration => throw _privateConstructorUsedError; // En minutos
  double get estimatedPrice => throw _privateConstructorUsedError; // En MXN
  TripRequestStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Campos de asignacion (llenados por el Monitor)
  String? get assignedDriverId => throw _privateConstructorUsedError;
  String? get assignedVehicleId => throw _privateConstructorUsedError;
  String? get assignedByMonitorId => throw _privateConstructorUsedError;
  DateTime? get assignedAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userEmail,
            String userName,
            String servicePackageId,
            String servicePackageName,
            Location origin,
            Location destination,
            DateTime scheduledTime,
            double estimatedDistance,
            int estimatedDuration,
            double estimatedPrice,
            TripRequestStatus status,
            DateTime createdAt,
            String? assignedDriverId,
            String? assignedVehicleId,
            String? assignedByMonitorId,
            DateTime? assignedAt)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String userEmail,
            String userName,
            String servicePackageId,
            String servicePackageName,
            Location origin,
            Location destination,
            DateTime scheduledTime,
            double estimatedDistance,
            int estimatedDuration,
            double estimatedPrice,
            TripRequestStatus status,
            DateTime createdAt,
            String? assignedDriverId,
            String? assignedVehicleId,
            String? assignedByMonitorId,
            DateTime? assignedAt)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userEmail,
            String userName,
            String servicePackageId,
            String servicePackageName,
            Location origin,
            Location destination,
            DateTime scheduledTime,
            double estimatedDistance,
            int estimatedDuration,
            double estimatedPrice,
            TripRequestStatus status,
            DateTime createdAt,
            String? assignedDriverId,
            String? assignedVehicleId,
            String? assignedByMonitorId,
            DateTime? assignedAt)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TripRequest value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TripRequest value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TripRequest value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TripRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripRequestCopyWith<TripRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripRequestCopyWith<$Res> {
  factory $TripRequestCopyWith(
          TripRequest value, $Res Function(TripRequest) then) =
      _$TripRequestCopyWithImpl<$Res, TripRequest>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String userEmail,
      String userName,
      String servicePackageId,
      String servicePackageName,
      Location origin,
      Location destination,
      DateTime scheduledTime,
      double estimatedDistance,
      int estimatedDuration,
      double estimatedPrice,
      TripRequestStatus status,
      DateTime createdAt,
      String? assignedDriverId,
      String? assignedVehicleId,
      String? assignedByMonitorId,
      DateTime? assignedAt});

  $LocationCopyWith<$Res> get origin;
  $LocationCopyWith<$Res> get destination;
}

/// @nodoc
class _$TripRequestCopyWithImpl<$Res, $Val extends TripRequest>
    implements $TripRequestCopyWith<$Res> {
  _$TripRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = null,
    Object? userName = null,
    Object? servicePackageId = null,
    Object? servicePackageName = null,
    Object? origin = null,
    Object? destination = null,
    Object? scheduledTime = null,
    Object? estimatedDistance = null,
    Object? estimatedDuration = null,
    Object? estimatedPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? assignedDriverId = freezed,
    Object? assignedVehicleId = freezed,
    Object? assignedByMonitorId = freezed,
    Object? assignedAt = freezed,
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
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      servicePackageId: null == servicePackageId
          ? _value.servicePackageId
          : servicePackageId // ignore: cast_nullable_to_non_nullable
              as String,
      servicePackageName: null == servicePackageName
          ? _value.servicePackageName
          : servicePackageName // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Location,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Location,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedDistance: null == estimatedDistance
          ? _value.estimatedDistance
          : estimatedDistance // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedPrice: null == estimatedPrice
          ? _value.estimatedPrice
          : estimatedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TripRequestStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedDriverId: freezed == assignedDriverId
          ? _value.assignedDriverId
          : assignedDriverId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedVehicleId: freezed == assignedVehicleId
          ? _value.assignedVehicleId
          : assignedVehicleId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedByMonitorId: freezed == assignedByMonitorId
          ? _value.assignedByMonitorId
          : assignedByMonitorId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedAt: freezed == assignedAt
          ? _value.assignedAt
          : assignedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get origin {
    return $LocationCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get destination {
    return $LocationCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripRequestImplCopyWith<$Res>
    implements $TripRequestCopyWith<$Res> {
  factory _$$TripRequestImplCopyWith(
          _$TripRequestImpl value, $Res Function(_$TripRequestImpl) then) =
      __$$TripRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String userEmail,
      String userName,
      String servicePackageId,
      String servicePackageName,
      Location origin,
      Location destination,
      DateTime scheduledTime,
      double estimatedDistance,
      int estimatedDuration,
      double estimatedPrice,
      TripRequestStatus status,
      DateTime createdAt,
      String? assignedDriverId,
      String? assignedVehicleId,
      String? assignedByMonitorId,
      DateTime? assignedAt});

  @override
  $LocationCopyWith<$Res> get origin;
  @override
  $LocationCopyWith<$Res> get destination;
}

/// @nodoc
class __$$TripRequestImplCopyWithImpl<$Res>
    extends _$TripRequestCopyWithImpl<$Res, _$TripRequestImpl>
    implements _$$TripRequestImplCopyWith<$Res> {
  __$$TripRequestImplCopyWithImpl(
      _$TripRequestImpl _value, $Res Function(_$TripRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = null,
    Object? userName = null,
    Object? servicePackageId = null,
    Object? servicePackageName = null,
    Object? origin = null,
    Object? destination = null,
    Object? scheduledTime = null,
    Object? estimatedDistance = null,
    Object? estimatedDuration = null,
    Object? estimatedPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? assignedDriverId = freezed,
    Object? assignedVehicleId = freezed,
    Object? assignedByMonitorId = freezed,
    Object? assignedAt = freezed,
  }) {
    return _then(_$TripRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      servicePackageId: null == servicePackageId
          ? _value.servicePackageId
          : servicePackageId // ignore: cast_nullable_to_non_nullable
              as String,
      servicePackageName: null == servicePackageName
          ? _value.servicePackageName
          : servicePackageName // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Location,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Location,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedDistance: null == estimatedDistance
          ? _value.estimatedDistance
          : estimatedDistance // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedPrice: null == estimatedPrice
          ? _value.estimatedPrice
          : estimatedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TripRequestStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedDriverId: freezed == assignedDriverId
          ? _value.assignedDriverId
          : assignedDriverId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedVehicleId: freezed == assignedVehicleId
          ? _value.assignedVehicleId
          : assignedVehicleId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedByMonitorId: freezed == assignedByMonitorId
          ? _value.assignedByMonitorId
          : assignedByMonitorId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedAt: freezed == assignedAt
          ? _value.assignedAt
          : assignedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripRequestImpl extends _TripRequest {
  const _$TripRequestImpl(
      {required this.id,
      required this.userId,
      required this.userEmail,
      required this.userName,
      required this.servicePackageId,
      required this.servicePackageName,
      required this.origin,
      required this.destination,
      required this.scheduledTime,
      required this.estimatedDistance,
      required this.estimatedDuration,
      required this.estimatedPrice,
      required this.status,
      required this.createdAt,
      this.assignedDriverId,
      this.assignedVehicleId,
      this.assignedByMonitorId,
      this.assignedAt})
      : super._();

  factory _$TripRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userEmail;
  @override
  final String userName;
  @override
  final String servicePackageId;
  @override
  final String servicePackageName;
  @override
  final Location origin;
  @override
  final Location destination;
  @override
  final DateTime scheduledTime;
  @override
  final double estimatedDistance;
// En kilometros
  @override
  final int estimatedDuration;
// En minutos
  @override
  final double estimatedPrice;
// En MXN
  @override
  final TripRequestStatus status;
  @override
  final DateTime createdAt;
// Campos de asignacion (llenados por el Monitor)
  @override
  final String? assignedDriverId;
  @override
  final String? assignedVehicleId;
  @override
  final String? assignedByMonitorId;
  @override
  final DateTime? assignedAt;

  @override
  String toString() {
    return 'TripRequest(id: $id, userId: $userId, userEmail: $userEmail, userName: $userName, servicePackageId: $servicePackageId, servicePackageName: $servicePackageName, origin: $origin, destination: $destination, scheduledTime: $scheduledTime, estimatedDistance: $estimatedDistance, estimatedDuration: $estimatedDuration, estimatedPrice: $estimatedPrice, status: $status, createdAt: $createdAt, assignedDriverId: $assignedDriverId, assignedVehicleId: $assignedVehicleId, assignedByMonitorId: $assignedByMonitorId, assignedAt: $assignedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.servicePackageId, servicePackageId) ||
                other.servicePackageId == servicePackageId) &&
            (identical(other.servicePackageName, servicePackageName) ||
                other.servicePackageName == servicePackageName) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.estimatedDistance, estimatedDistance) ||
                other.estimatedDistance == estimatedDistance) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.estimatedPrice, estimatedPrice) ||
                other.estimatedPrice == estimatedPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.assignedDriverId, assignedDriverId) ||
                other.assignedDriverId == assignedDriverId) &&
            (identical(other.assignedVehicleId, assignedVehicleId) ||
                other.assignedVehicleId == assignedVehicleId) &&
            (identical(other.assignedByMonitorId, assignedByMonitorId) ||
                other.assignedByMonitorId == assignedByMonitorId) &&
            (identical(other.assignedAt, assignedAt) ||
                other.assignedAt == assignedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      userEmail,
      userName,
      servicePackageId,
      servicePackageName,
      origin,
      destination,
      scheduledTime,
      estimatedDistance,
      estimatedDuration,
      estimatedPrice,
      status,
      createdAt,
      assignedDriverId,
      assignedVehicleId,
      assignedByMonitorId,
      assignedAt);

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripRequestImplCopyWith<_$TripRequestImpl> get copyWith =>
      __$$TripRequestImplCopyWithImpl<_$TripRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userEmail,
            String userName,
            String servicePackageId,
            String servicePackageName,
            Location origin,
            Location destination,
            DateTime scheduledTime,
            double estimatedDistance,
            int estimatedDuration,
            double estimatedPrice,
            TripRequestStatus status,
            DateTime createdAt,
            String? assignedDriverId,
            String? assignedVehicleId,
            String? assignedByMonitorId,
            DateTime? assignedAt)
        $default,
  ) {
    return $default(
        id,
        userId,
        userEmail,
        userName,
        servicePackageId,
        servicePackageName,
        origin,
        destination,
        scheduledTime,
        estimatedDistance,
        estimatedDuration,
        estimatedPrice,
        status,
        createdAt,
        assignedDriverId,
        assignedVehicleId,
        assignedByMonitorId,
        assignedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String userEmail,
            String userName,
            String servicePackageId,
            String servicePackageName,
            Location origin,
            Location destination,
            DateTime scheduledTime,
            double estimatedDistance,
            int estimatedDuration,
            double estimatedPrice,
            TripRequestStatus status,
            DateTime createdAt,
            String? assignedDriverId,
            String? assignedVehicleId,
            String? assignedByMonitorId,
            DateTime? assignedAt)?
        $default,
  ) {
    return $default?.call(
        id,
        userId,
        userEmail,
        userName,
        servicePackageId,
        servicePackageName,
        origin,
        destination,
        scheduledTime,
        estimatedDistance,
        estimatedDuration,
        estimatedPrice,
        status,
        createdAt,
        assignedDriverId,
        assignedVehicleId,
        assignedByMonitorId,
        assignedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String userEmail,
            String userName,
            String servicePackageId,
            String servicePackageName,
            Location origin,
            Location destination,
            DateTime scheduledTime,
            double estimatedDistance,
            int estimatedDuration,
            double estimatedPrice,
            TripRequestStatus status,
            DateTime createdAt,
            String? assignedDriverId,
            String? assignedVehicleId,
            String? assignedByMonitorId,
            DateTime? assignedAt)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          userId,
          userEmail,
          userName,
          servicePackageId,
          servicePackageName,
          origin,
          destination,
          scheduledTime,
          estimatedDistance,
          estimatedDuration,
          estimatedPrice,
          status,
          createdAt,
          assignedDriverId,
          assignedVehicleId,
          assignedByMonitorId,
          assignedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TripRequest value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TripRequest value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TripRequest value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripRequestImplToJson(
      this,
    );
  }
}

abstract class _TripRequest extends TripRequest {
  const factory _TripRequest(
      {required final String id,
      required final String userId,
      required final String userEmail,
      required final String userName,
      required final String servicePackageId,
      required final String servicePackageName,
      required final Location origin,
      required final Location destination,
      required final DateTime scheduledTime,
      required final double estimatedDistance,
      required final int estimatedDuration,
      required final double estimatedPrice,
      required final TripRequestStatus status,
      required final DateTime createdAt,
      final String? assignedDriverId,
      final String? assignedVehicleId,
      final String? assignedByMonitorId,
      final DateTime? assignedAt}) = _$TripRequestImpl;
  const _TripRequest._() : super._();

  factory _TripRequest.fromJson(Map<String, dynamic> json) =
      _$TripRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userEmail;
  @override
  String get userName;
  @override
  String get servicePackageId;
  @override
  String get servicePackageName;
  @override
  Location get origin;
  @override
  Location get destination;
  @override
  DateTime get scheduledTime;
  @override
  double get estimatedDistance; // En kilometros
  @override
  int get estimatedDuration; // En minutos
  @override
  double get estimatedPrice; // En MXN
  @override
  TripRequestStatus get status;
  @override
  DateTime get createdAt; // Campos de asignacion (llenados por el Monitor)
  @override
  String? get assignedDriverId;
  @override
  String? get assignedVehicleId;
  @override
  String? get assignedByMonitorId;
  @override
  DateTime? get assignedAt;

  /// Create a copy of TripRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripRequestImplCopyWith<_$TripRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
