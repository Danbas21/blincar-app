// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_request_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TripRequestEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripRequestEventCopyWith<$Res> {
  factory $TripRequestEventCopyWith(
          TripRequestEvent value, $Res Function(TripRequestEvent) then) =
      _$TripRequestEventCopyWithImpl<$Res, TripRequestEvent>;
}

/// @nodoc
class _$TripRequestEventCopyWithImpl<$Res, $Val extends TripRequestEvent>
    implements $TripRequestEventCopyWith<$Res> {
  _$TripRequestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreateTripRequestEventImplCopyWith<$Res> {
  factory _$$CreateTripRequestEventImplCopyWith(
          _$CreateTripRequestEventImpl value,
          $Res Function(_$CreateTripRequestEventImpl) then) =
      __$$CreateTripRequestEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String userId,
      String userName,
      String userPhone,
      String routeId,
      String serviceType,
      double totalPrice});
}

/// @nodoc
class __$$CreateTripRequestEventImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$CreateTripRequestEventImpl>
    implements _$$CreateTripRequestEventImplCopyWith<$Res> {
  __$$CreateTripRequestEventImplCopyWithImpl(
      _$CreateTripRequestEventImpl _value,
      $Res Function(_$CreateTripRequestEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? userPhone = null,
    Object? routeId = null,
    Object? serviceType = null,
    Object? totalPrice = null,
  }) {
    return _then(_$CreateTripRequestEventImpl(
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
      routeId: null == routeId
          ? _value.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CreateTripRequestEventImpl implements CreateTripRequestEvent {
  const _$CreateTripRequestEventImpl(
      {required this.userId,
      required this.userName,
      required this.userPhone,
      required this.routeId,
      required this.serviceType,
      required this.totalPrice});

  @override
  final String userId;
  @override
  final String userName;
  @override
  final String userPhone;
  @override
  final String routeId;
  @override
  final String serviceType;
  @override
  final double totalPrice;

  @override
  String toString() {
    return 'TripRequestEvent.create(userId: $userId, userName: $userName, userPhone: $userPhone, routeId: $routeId, serviceType: $serviceType, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTripRequestEventImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, userName, userPhone,
      routeId, serviceType, totalPrice);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTripRequestEventImplCopyWith<_$CreateTripRequestEventImpl>
      get copyWith => __$$CreateTripRequestEventImplCopyWithImpl<
          _$CreateTripRequestEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) {
    return create(
        userId, userName, userPhone, routeId, serviceType, totalPrice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) {
    return create?.call(
        userId, userName, userPhone, routeId, serviceType, totalPrice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(
          userId, userName, userPhone, routeId, serviceType, totalPrice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class CreateTripRequestEvent implements TripRequestEvent {
  const factory CreateTripRequestEvent(
      {required final String userId,
      required final String userName,
      required final String userPhone,
      required final String routeId,
      required final String serviceType,
      required final double totalPrice}) = _$CreateTripRequestEventImpl;

  String get userId;
  String get userName;
  String get userPhone;
  String get routeId;
  String get serviceType;
  double get totalPrice;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTripRequestEventImplCopyWith<_$CreateTripRequestEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetUserActiveTripEventImplCopyWith<$Res> {
  factory _$$GetUserActiveTripEventImplCopyWith(
          _$GetUserActiveTripEventImpl value,
          $Res Function(_$GetUserActiveTripEventImpl) then) =
      __$$GetUserActiveTripEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$GetUserActiveTripEventImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$GetUserActiveTripEventImpl>
    implements _$$GetUserActiveTripEventImplCopyWith<$Res> {
  __$$GetUserActiveTripEventImplCopyWithImpl(
      _$GetUserActiveTripEventImpl _value,
      $Res Function(_$GetUserActiveTripEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$GetUserActiveTripEventImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetUserActiveTripEventImpl implements GetUserActiveTripEvent {
  const _$GetUserActiveTripEventImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'TripRequestEvent.getActiveTrip(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetUserActiveTripEventImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetUserActiveTripEventImplCopyWith<_$GetUserActiveTripEventImpl>
      get copyWith => __$$GetUserActiveTripEventImplCopyWithImpl<
          _$GetUserActiveTripEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) {
    return getActiveTrip(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) {
    return getActiveTrip?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (getActiveTrip != null) {
      return getActiveTrip(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) {
    return getActiveTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) {
    return getActiveTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) {
    if (getActiveTrip != null) {
      return getActiveTrip(this);
    }
    return orElse();
  }
}

abstract class GetUserActiveTripEvent implements TripRequestEvent {
  const factory GetUserActiveTripEvent({required final String userId}) =
      _$GetUserActiveTripEventImpl;

  String get userId;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetUserActiveTripEventImplCopyWith<_$GetUserActiveTripEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetUserTripsEventImplCopyWith<$Res> {
  factory _$$GetUserTripsEventImplCopyWith(_$GetUserTripsEventImpl value,
          $Res Function(_$GetUserTripsEventImpl) then) =
      __$$GetUserTripsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$GetUserTripsEventImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$GetUserTripsEventImpl>
    implements _$$GetUserTripsEventImplCopyWith<$Res> {
  __$$GetUserTripsEventImplCopyWithImpl(_$GetUserTripsEventImpl _value,
      $Res Function(_$GetUserTripsEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$GetUserTripsEventImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetUserTripsEventImpl implements GetUserTripsEvent {
  const _$GetUserTripsEventImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'TripRequestEvent.getUserTrips(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetUserTripsEventImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetUserTripsEventImplCopyWith<_$GetUserTripsEventImpl> get copyWith =>
      __$$GetUserTripsEventImplCopyWithImpl<_$GetUserTripsEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) {
    return getUserTrips(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) {
    return getUserTrips?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (getUserTrips != null) {
      return getUserTrips(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) {
    return getUserTrips(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) {
    return getUserTrips?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) {
    if (getUserTrips != null) {
      return getUserTrips(this);
    }
    return orElse();
  }
}

abstract class GetUserTripsEvent implements TripRequestEvent {
  const factory GetUserTripsEvent({required final String userId}) =
      _$GetUserTripsEventImpl;

  String get userId;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetUserTripsEventImplCopyWith<_$GetUserTripsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchTripEventImplCopyWith<$Res> {
  factory _$$WatchTripEventImplCopyWith(_$WatchTripEventImpl value,
          $Res Function(_$WatchTripEventImpl) then) =
      __$$WatchTripEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tripId});
}

/// @nodoc
class __$$WatchTripEventImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$WatchTripEventImpl>
    implements _$$WatchTripEventImplCopyWith<$Res> {
  __$$WatchTripEventImplCopyWithImpl(
      _$WatchTripEventImpl _value, $Res Function(_$WatchTripEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
  }) {
    return _then(_$WatchTripEventImpl(
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WatchTripEventImpl implements WatchTripEvent {
  const _$WatchTripEventImpl({required this.tripId});

  @override
  final String tripId;

  @override
  String toString() {
    return 'TripRequestEvent.watchTrip(tripId: $tripId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchTripEventImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tripId);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchTripEventImplCopyWith<_$WatchTripEventImpl> get copyWith =>
      __$$WatchTripEventImplCopyWithImpl<_$WatchTripEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) {
    return watchTrip(tripId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) {
    return watchTrip?.call(tripId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (watchTrip != null) {
      return watchTrip(tripId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) {
    return watchTrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) {
    return watchTrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) {
    if (watchTrip != null) {
      return watchTrip(this);
    }
    return orElse();
  }
}

abstract class WatchTripEvent implements TripRequestEvent {
  const factory WatchTripEvent({required final String tripId}) =
      _$WatchTripEventImpl;

  String get tripId;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchTripEventImplCopyWith<_$WatchTripEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StopWatchingTripEventImplCopyWith<$Res> {
  factory _$$StopWatchingTripEventImplCopyWith(
          _$StopWatchingTripEventImpl value,
          $Res Function(_$StopWatchingTripEventImpl) then) =
      __$$StopWatchingTripEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopWatchingTripEventImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$StopWatchingTripEventImpl>
    implements _$$StopWatchingTripEventImplCopyWith<$Res> {
  __$$StopWatchingTripEventImplCopyWithImpl(_$StopWatchingTripEventImpl _value,
      $Res Function(_$StopWatchingTripEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopWatchingTripEventImpl implements StopWatchingTripEvent {
  const _$StopWatchingTripEventImpl();

  @override
  String toString() {
    return 'TripRequestEvent.stopWatching()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopWatchingTripEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) {
    return stopWatching();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) {
    return stopWatching?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (stopWatching != null) {
      return stopWatching();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) {
    return stopWatching(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) {
    return stopWatching?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) {
    if (stopWatching != null) {
      return stopWatching(this);
    }
    return orElse();
  }
}

abstract class StopWatchingTripEvent implements TripRequestEvent {
  const factory StopWatchingTripEvent() = _$StopWatchingTripEventImpl;
}

/// @nodoc
abstract class _$$ResetTripRequestEventImplCopyWith<$Res> {
  factory _$$ResetTripRequestEventImplCopyWith(
          _$ResetTripRequestEventImpl value,
          $Res Function(_$ResetTripRequestEventImpl) then) =
      __$$ResetTripRequestEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetTripRequestEventImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$ResetTripRequestEventImpl>
    implements _$$ResetTripRequestEventImplCopyWith<$Res> {
  __$$ResetTripRequestEventImplCopyWithImpl(_$ResetTripRequestEventImpl _value,
      $Res Function(_$ResetTripRequestEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetTripRequestEventImpl implements ResetTripRequestEvent {
  const _$ResetTripRequestEventImpl();

  @override
  String toString() {
    return 'TripRequestEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetTripRequestEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)
        create,
    required TResult Function(String userId) getActiveTrip,
    required TResult Function(String userId) getUserTrips,
    required TResult Function(String tripId) watchTrip,
    required TResult Function() stopWatching,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult? Function(String userId)? getActiveTrip,
    TResult? Function(String userId)? getUserTrips,
    TResult? Function(String tripId)? watchTrip,
    TResult? Function()? stopWatching,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String userName, String userPhone,
            String routeId, String serviceType, double totalPrice)?
        create,
    TResult Function(String userId)? getActiveTrip,
    TResult Function(String userId)? getUserTrips,
    TResult Function(String tripId)? watchTrip,
    TResult Function()? stopWatching,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateTripRequestEvent value) create,
    required TResult Function(GetUserActiveTripEvent value) getActiveTrip,
    required TResult Function(GetUserTripsEvent value) getUserTrips,
    required TResult Function(WatchTripEvent value) watchTrip,
    required TResult Function(StopWatchingTripEvent value) stopWatching,
    required TResult Function(ResetTripRequestEvent value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateTripRequestEvent value)? create,
    TResult? Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult? Function(GetUserTripsEvent value)? getUserTrips,
    TResult? Function(WatchTripEvent value)? watchTrip,
    TResult? Function(StopWatchingTripEvent value)? stopWatching,
    TResult? Function(ResetTripRequestEvent value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateTripRequestEvent value)? create,
    TResult Function(GetUserActiveTripEvent value)? getActiveTrip,
    TResult Function(GetUserTripsEvent value)? getUserTrips,
    TResult Function(WatchTripEvent value)? watchTrip,
    TResult Function(StopWatchingTripEvent value)? stopWatching,
    TResult Function(ResetTripRequestEvent value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class ResetTripRequestEvent implements TripRequestEvent {
  const factory ResetTripRequestEvent() = _$ResetTripRequestEventImpl;
}
