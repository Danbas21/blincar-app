// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActiveTrip _$ActiveTripFromJson(Map<String, dynamic> json) {
  return _ActiveTrip.fromJson(json);
}

/// @nodoc
mixin _$ActiveTrip {
  String get id => throw _privateConstructorUsedError;
  String get requestId =>
      throw _privateConstructorUsedError; // Referencia a la TripRequest original
  String get userId => throw _privateConstructorUsedError;
  String get driverId => throw _privateConstructorUsedError;
  String get vehicleId => throw _privateConstructorUsedError;
  String get monitorId =>
      throw _privateConstructorUsedError; // Monitor que asigno el viaje
  ActiveTripStatus get status =>
      throw _privateConstructorUsedError; // Datos en tiempo real
  Coordinates? get currentLocation => throw _privateConstructorUsedError;
  double? get currentSpeed => throw _privateConstructorUsedError; // km/h
  double? get currentHeading =>
      throw _privateConstructorUsedError; // Grados (0-360)
// Video y grabacion
  String? get videoStreamUrl =>
      throw _privateConstructorUsedError; // URL RTSP de la camara Hikvision
  bool get recordingStarted =>
      throw _privateConstructorUsedError; // Contactos de emergencia
  bool get emergencyContactNotified =>
      throw _privateConstructorUsedError; // Tiempos
  DateTime? get startTime =>
      throw _privateConstructorUsedError; // Cuando driver presiona "Iniciar"
  DateTime? get estimatedEndTime => throw _privateConstructorUsedError;
  DateTime? get completedAt =>
      throw _privateConstructorUsedError; // Precio y calificacion
  double get actualPrice => throw _privateConstructorUsedError;
  int? get serviceRating =>
      throw _privateConstructorUsedError; // 1-5 estrellas (null hasta que usuario califique)
  String? get serviceFeedback => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String requestId,
            String userId,
            String driverId,
            String vehicleId,
            String monitorId,
            ActiveTripStatus status,
            Coordinates? currentLocation,
            double? currentSpeed,
            double? currentHeading,
            String? videoStreamUrl,
            bool recordingStarted,
            bool emergencyContactNotified,
            DateTime? startTime,
            DateTime? estimatedEndTime,
            DateTime? completedAt,
            double actualPrice,
            int? serviceRating,
            String? serviceFeedback)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String requestId,
            String userId,
            String driverId,
            String vehicleId,
            String monitorId,
            ActiveTripStatus status,
            Coordinates? currentLocation,
            double? currentSpeed,
            double? currentHeading,
            String? videoStreamUrl,
            bool recordingStarted,
            bool emergencyContactNotified,
            DateTime? startTime,
            DateTime? estimatedEndTime,
            DateTime? completedAt,
            double actualPrice,
            int? serviceRating,
            String? serviceFeedback)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String requestId,
            String userId,
            String driverId,
            String vehicleId,
            String monitorId,
            ActiveTripStatus status,
            Coordinates? currentLocation,
            double? currentSpeed,
            double? currentHeading,
            String? videoStreamUrl,
            bool recordingStarted,
            bool emergencyContactNotified,
            DateTime? startTime,
            DateTime? estimatedEndTime,
            DateTime? completedAt,
            double actualPrice,
            int? serviceRating,
            String? serviceFeedback)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ActiveTrip value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ActiveTrip value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ActiveTrip value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ActiveTrip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveTrip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveTripCopyWith<ActiveTrip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveTripCopyWith<$Res> {
  factory $ActiveTripCopyWith(
          ActiveTrip value, $Res Function(ActiveTrip) then) =
      _$ActiveTripCopyWithImpl<$Res, ActiveTrip>;
  @useResult
  $Res call(
      {String id,
      String requestId,
      String userId,
      String driverId,
      String vehicleId,
      String monitorId,
      ActiveTripStatus status,
      Coordinates? currentLocation,
      double? currentSpeed,
      double? currentHeading,
      String? videoStreamUrl,
      bool recordingStarted,
      bool emergencyContactNotified,
      DateTime? startTime,
      DateTime? estimatedEndTime,
      DateTime? completedAt,
      double actualPrice,
      int? serviceRating,
      String? serviceFeedback});

  $CoordinatesCopyWith<$Res>? get currentLocation;
}

/// @nodoc
class _$ActiveTripCopyWithImpl<$Res, $Val extends ActiveTrip>
    implements $ActiveTripCopyWith<$Res> {
  _$ActiveTripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveTrip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? userId = null,
    Object? driverId = null,
    Object? vehicleId = null,
    Object? monitorId = null,
    Object? status = null,
    Object? currentLocation = freezed,
    Object? currentSpeed = freezed,
    Object? currentHeading = freezed,
    Object? videoStreamUrl = freezed,
    Object? recordingStarted = null,
    Object? emergencyContactNotified = null,
    Object? startTime = freezed,
    Object? estimatedEndTime = freezed,
    Object? completedAt = freezed,
    Object? actualPrice = null,
    Object? serviceRating = freezed,
    Object? serviceFeedback = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      monitorId: null == monitorId
          ? _value.monitorId
          : monitorId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActiveTripStatus,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
      currentSpeed: freezed == currentSpeed
          ? _value.currentSpeed
          : currentSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      currentHeading: freezed == currentHeading
          ? _value.currentHeading
          : currentHeading // ignore: cast_nullable_to_non_nullable
              as double?,
      videoStreamUrl: freezed == videoStreamUrl
          ? _value.videoStreamUrl
          : videoStreamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recordingStarted: null == recordingStarted
          ? _value.recordingStarted
          : recordingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyContactNotified: null == emergencyContactNotified
          ? _value.emergencyContactNotified
          : emergencyContactNotified // ignore: cast_nullable_to_non_nullable
              as bool,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedEndTime: freezed == estimatedEndTime
          ? _value.estimatedEndTime
          : estimatedEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualPrice: null == actualPrice
          ? _value.actualPrice
          : actualPrice // ignore: cast_nullable_to_non_nullable
              as double,
      serviceRating: freezed == serviceRating
          ? _value.serviceRating
          : serviceRating // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceFeedback: freezed == serviceFeedback
          ? _value.serviceFeedback
          : serviceFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ActiveTrip
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
abstract class _$$ActiveTripImplCopyWith<$Res>
    implements $ActiveTripCopyWith<$Res> {
  factory _$$ActiveTripImplCopyWith(
          _$ActiveTripImpl value, $Res Function(_$ActiveTripImpl) then) =
      __$$ActiveTripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String requestId,
      String userId,
      String driverId,
      String vehicleId,
      String monitorId,
      ActiveTripStatus status,
      Coordinates? currentLocation,
      double? currentSpeed,
      double? currentHeading,
      String? videoStreamUrl,
      bool recordingStarted,
      bool emergencyContactNotified,
      DateTime? startTime,
      DateTime? estimatedEndTime,
      DateTime? completedAt,
      double actualPrice,
      int? serviceRating,
      String? serviceFeedback});

  @override
  $CoordinatesCopyWith<$Res>? get currentLocation;
}

/// @nodoc
class __$$ActiveTripImplCopyWithImpl<$Res>
    extends _$ActiveTripCopyWithImpl<$Res, _$ActiveTripImpl>
    implements _$$ActiveTripImplCopyWith<$Res> {
  __$$ActiveTripImplCopyWithImpl(
      _$ActiveTripImpl _value, $Res Function(_$ActiveTripImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveTrip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? userId = null,
    Object? driverId = null,
    Object? vehicleId = null,
    Object? monitorId = null,
    Object? status = null,
    Object? currentLocation = freezed,
    Object? currentSpeed = freezed,
    Object? currentHeading = freezed,
    Object? videoStreamUrl = freezed,
    Object? recordingStarted = null,
    Object? emergencyContactNotified = null,
    Object? startTime = freezed,
    Object? estimatedEndTime = freezed,
    Object? completedAt = freezed,
    Object? actualPrice = null,
    Object? serviceRating = freezed,
    Object? serviceFeedback = freezed,
  }) {
    return _then(_$ActiveTripImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      monitorId: null == monitorId
          ? _value.monitorId
          : monitorId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActiveTripStatus,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
      currentSpeed: freezed == currentSpeed
          ? _value.currentSpeed
          : currentSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      currentHeading: freezed == currentHeading
          ? _value.currentHeading
          : currentHeading // ignore: cast_nullable_to_non_nullable
              as double?,
      videoStreamUrl: freezed == videoStreamUrl
          ? _value.videoStreamUrl
          : videoStreamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recordingStarted: null == recordingStarted
          ? _value.recordingStarted
          : recordingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyContactNotified: null == emergencyContactNotified
          ? _value.emergencyContactNotified
          : emergencyContactNotified // ignore: cast_nullable_to_non_nullable
              as bool,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedEndTime: freezed == estimatedEndTime
          ? _value.estimatedEndTime
          : estimatedEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualPrice: null == actualPrice
          ? _value.actualPrice
          : actualPrice // ignore: cast_nullable_to_non_nullable
              as double,
      serviceRating: freezed == serviceRating
          ? _value.serviceRating
          : serviceRating // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceFeedback: freezed == serviceFeedback
          ? _value.serviceFeedback
          : serviceFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveTripImpl extends _ActiveTrip {
  const _$ActiveTripImpl(
      {required this.id,
      required this.requestId,
      required this.userId,
      required this.driverId,
      required this.vehicleId,
      required this.monitorId,
      required this.status,
      this.currentLocation,
      this.currentSpeed,
      this.currentHeading,
      this.videoStreamUrl,
      this.recordingStarted = false,
      this.emergencyContactNotified = false,
      this.startTime,
      this.estimatedEndTime,
      this.completedAt,
      required this.actualPrice,
      this.serviceRating,
      this.serviceFeedback})
      : super._();

  factory _$ActiveTripImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveTripImplFromJson(json);

  @override
  final String id;
  @override
  final String requestId;
// Referencia a la TripRequest original
  @override
  final String userId;
  @override
  final String driverId;
  @override
  final String vehicleId;
  @override
  final String monitorId;
// Monitor que asigno el viaje
  @override
  final ActiveTripStatus status;
// Datos en tiempo real
  @override
  final Coordinates? currentLocation;
  @override
  final double? currentSpeed;
// km/h
  @override
  final double? currentHeading;
// Grados (0-360)
// Video y grabacion
  @override
  final String? videoStreamUrl;
// URL RTSP de la camara Hikvision
  @override
  @JsonKey()
  final bool recordingStarted;
// Contactos de emergencia
  @override
  @JsonKey()
  final bool emergencyContactNotified;
// Tiempos
  @override
  final DateTime? startTime;
// Cuando driver presiona "Iniciar"
  @override
  final DateTime? estimatedEndTime;
  @override
  final DateTime? completedAt;
// Precio y calificacion
  @override
  final double actualPrice;
  @override
  final int? serviceRating;
// 1-5 estrellas (null hasta que usuario califique)
  @override
  final String? serviceFeedback;

  @override
  String toString() {
    return 'ActiveTrip(id: $id, requestId: $requestId, userId: $userId, driverId: $driverId, vehicleId: $vehicleId, monitorId: $monitorId, status: $status, currentLocation: $currentLocation, currentSpeed: $currentSpeed, currentHeading: $currentHeading, videoStreamUrl: $videoStreamUrl, recordingStarted: $recordingStarted, emergencyContactNotified: $emergencyContactNotified, startTime: $startTime, estimatedEndTime: $estimatedEndTime, completedAt: $completedAt, actualPrice: $actualPrice, serviceRating: $serviceRating, serviceFeedback: $serviceFeedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveTripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.monitorId, monitorId) ||
                other.monitorId == monitorId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.currentSpeed, currentSpeed) ||
                other.currentSpeed == currentSpeed) &&
            (identical(other.currentHeading, currentHeading) ||
                other.currentHeading == currentHeading) &&
            (identical(other.videoStreamUrl, videoStreamUrl) ||
                other.videoStreamUrl == videoStreamUrl) &&
            (identical(other.recordingStarted, recordingStarted) ||
                other.recordingStarted == recordingStarted) &&
            (identical(
                    other.emergencyContactNotified, emergencyContactNotified) ||
                other.emergencyContactNotified == emergencyContactNotified) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.estimatedEndTime, estimatedEndTime) ||
                other.estimatedEndTime == estimatedEndTime) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.actualPrice, actualPrice) ||
                other.actualPrice == actualPrice) &&
            (identical(other.serviceRating, serviceRating) ||
                other.serviceRating == serviceRating) &&
            (identical(other.serviceFeedback, serviceFeedback) ||
                other.serviceFeedback == serviceFeedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        requestId,
        userId,
        driverId,
        vehicleId,
        monitorId,
        status,
        currentLocation,
        currentSpeed,
        currentHeading,
        videoStreamUrl,
        recordingStarted,
        emergencyContactNotified,
        startTime,
        estimatedEndTime,
        completedAt,
        actualPrice,
        serviceRating,
        serviceFeedback
      ]);

  /// Create a copy of ActiveTrip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveTripImplCopyWith<_$ActiveTripImpl> get copyWith =>
      __$$ActiveTripImplCopyWithImpl<_$ActiveTripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String requestId,
            String userId,
            String driverId,
            String vehicleId,
            String monitorId,
            ActiveTripStatus status,
            Coordinates? currentLocation,
            double? currentSpeed,
            double? currentHeading,
            String? videoStreamUrl,
            bool recordingStarted,
            bool emergencyContactNotified,
            DateTime? startTime,
            DateTime? estimatedEndTime,
            DateTime? completedAt,
            double actualPrice,
            int? serviceRating,
            String? serviceFeedback)
        $default,
  ) {
    return $default(
        id,
        requestId,
        userId,
        driverId,
        vehicleId,
        monitorId,
        status,
        currentLocation,
        currentSpeed,
        currentHeading,
        videoStreamUrl,
        recordingStarted,
        emergencyContactNotified,
        startTime,
        estimatedEndTime,
        completedAt,
        actualPrice,
        serviceRating,
        serviceFeedback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String requestId,
            String userId,
            String driverId,
            String vehicleId,
            String monitorId,
            ActiveTripStatus status,
            Coordinates? currentLocation,
            double? currentSpeed,
            double? currentHeading,
            String? videoStreamUrl,
            bool recordingStarted,
            bool emergencyContactNotified,
            DateTime? startTime,
            DateTime? estimatedEndTime,
            DateTime? completedAt,
            double actualPrice,
            int? serviceRating,
            String? serviceFeedback)?
        $default,
  ) {
    return $default?.call(
        id,
        requestId,
        userId,
        driverId,
        vehicleId,
        monitorId,
        status,
        currentLocation,
        currentSpeed,
        currentHeading,
        videoStreamUrl,
        recordingStarted,
        emergencyContactNotified,
        startTime,
        estimatedEndTime,
        completedAt,
        actualPrice,
        serviceRating,
        serviceFeedback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String requestId,
            String userId,
            String driverId,
            String vehicleId,
            String monitorId,
            ActiveTripStatus status,
            Coordinates? currentLocation,
            double? currentSpeed,
            double? currentHeading,
            String? videoStreamUrl,
            bool recordingStarted,
            bool emergencyContactNotified,
            DateTime? startTime,
            DateTime? estimatedEndTime,
            DateTime? completedAt,
            double actualPrice,
            int? serviceRating,
            String? serviceFeedback)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          id,
          requestId,
          userId,
          driverId,
          vehicleId,
          monitorId,
          status,
          currentLocation,
          currentSpeed,
          currentHeading,
          videoStreamUrl,
          recordingStarted,
          emergencyContactNotified,
          startTime,
          estimatedEndTime,
          completedAt,
          actualPrice,
          serviceRating,
          serviceFeedback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ActiveTrip value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ActiveTrip value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ActiveTrip value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveTripImplToJson(
      this,
    );
  }
}

abstract class _ActiveTrip extends ActiveTrip {
  const factory _ActiveTrip(
      {required final String id,
      required final String requestId,
      required final String userId,
      required final String driverId,
      required final String vehicleId,
      required final String monitorId,
      required final ActiveTripStatus status,
      final Coordinates? currentLocation,
      final double? currentSpeed,
      final double? currentHeading,
      final String? videoStreamUrl,
      final bool recordingStarted,
      final bool emergencyContactNotified,
      final DateTime? startTime,
      final DateTime? estimatedEndTime,
      final DateTime? completedAt,
      required final double actualPrice,
      final int? serviceRating,
      final String? serviceFeedback}) = _$ActiveTripImpl;
  const _ActiveTrip._() : super._();

  factory _ActiveTrip.fromJson(Map<String, dynamic> json) =
      _$ActiveTripImpl.fromJson;

  @override
  String get id;
  @override
  String get requestId; // Referencia a la TripRequest original
  @override
  String get userId;
  @override
  String get driverId;
  @override
  String get vehicleId;
  @override
  String get monitorId; // Monitor que asigno el viaje
  @override
  ActiveTripStatus get status; // Datos en tiempo real
  @override
  Coordinates? get currentLocation;
  @override
  double? get currentSpeed; // km/h
  @override
  double? get currentHeading; // Grados (0-360)
// Video y grabacion
  @override
  String? get videoStreamUrl; // URL RTSP de la camara Hikvision
  @override
  bool get recordingStarted; // Contactos de emergencia
  @override
  bool get emergencyContactNotified; // Tiempos
  @override
  DateTime? get startTime; // Cuando driver presiona "Iniciar"
  @override
  DateTime? get estimatedEndTime;
  @override
  DateTime? get completedAt; // Precio y calificacion
  @override
  double get actualPrice;
  @override
  int? get serviceRating; // 1-5 estrellas (null hasta que usuario califique)
  @override
  String? get serviceFeedback;

  /// Create a copy of ActiveTrip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveTripImplCopyWith<_$ActiveTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
