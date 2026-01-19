// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripRequestState _$TripRequestStateFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'Initial':
      return TripRequestInitial.fromJson(json);
    case 'Loading':
      return TripRequestLoading.fromJson(json);
    case 'Created':
      return TripRequestCreated.fromJson(json);
    case 'ActiveTripLoaded':
      return ActiveTripLoaded.fromJson(json);
    case 'HistoryLoaded':
      return TripHistoryLoaded.fromJson(json);
    case 'Updated':
      return TripUpdated.fromJson(json);
    case 'Error':
      return TripRequestError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'TripRequestState',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$TripRequestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TripRequestState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripRequestStateCopyWith<$Res> {
  factory $TripRequestStateCopyWith(
          TripRequestState value, $Res Function(TripRequestState) then) =
      _$TripRequestStateCopyWithImpl<$Res, TripRequestState>;
}

/// @nodoc
class _$TripRequestStateCopyWithImpl<$Res, $Val extends TripRequestState>
    implements $TripRequestStateCopyWith<$Res> {
  _$TripRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TripRequestInitialImplCopyWith<$Res> {
  factory _$$TripRequestInitialImplCopyWith(_$TripRequestInitialImpl value,
          $Res Function(_$TripRequestInitialImpl) then) =
      __$$TripRequestInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TripRequestInitialImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripRequestInitialImpl>
    implements _$$TripRequestInitialImplCopyWith<$Res> {
  __$$TripRequestInitialImplCopyWithImpl(_$TripRequestInitialImpl _value,
      $Res Function(_$TripRequestInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$TripRequestInitialImpl implements TripRequestInitial {
  const _$TripRequestInitialImpl({final String? $type})
      : $type = $type ?? 'Initial';

  factory _$TripRequestInitialImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripRequestInitialImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TripRequestInitialImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
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
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripRequestInitialImplToJson(
      this,
    );
  }
}

abstract class TripRequestInitial implements TripRequestState {
  const factory TripRequestInitial() = _$TripRequestInitialImpl;

  factory TripRequestInitial.fromJson(Map<String, dynamic> json) =
      _$TripRequestInitialImpl.fromJson;
}

/// @nodoc
abstract class _$$TripRequestLoadingImplCopyWith<$Res> {
  factory _$$TripRequestLoadingImplCopyWith(_$TripRequestLoadingImpl value,
          $Res Function(_$TripRequestLoadingImpl) then) =
      __$$TripRequestLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$TripRequestLoadingImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripRequestLoadingImpl>
    implements _$$TripRequestLoadingImplCopyWith<$Res> {
  __$$TripRequestLoadingImplCopyWithImpl(_$TripRequestLoadingImpl _value,
      $Res Function(_$TripRequestLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$TripRequestLoadingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripRequestLoadingImpl implements TripRequestLoading {
  const _$TripRequestLoadingImpl({this.message, final String? $type})
      : $type = $type ?? 'Loading';

  factory _$TripRequestLoadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripRequestLoadingImplFromJson(json);

  @override
  final String? message;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripRequestLoadingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripRequestLoadingImplCopyWith<_$TripRequestLoadingImpl> get copyWith =>
      __$$TripRequestLoadingImplCopyWithImpl<_$TripRequestLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripRequestLoadingImplToJson(
      this,
    );
  }
}

abstract class TripRequestLoading implements TripRequestState {
  const factory TripRequestLoading({final String? message}) =
      _$TripRequestLoadingImpl;

  factory TripRequestLoading.fromJson(Map<String, dynamic> json) =
      _$TripRequestLoadingImpl.fromJson;

  String? get message;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripRequestLoadingImplCopyWith<_$TripRequestLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TripRequestCreatedImplCopyWith<$Res> {
  factory _$$TripRequestCreatedImplCopyWith(_$TripRequestCreatedImpl value,
          $Res Function(_$TripRequestCreatedImpl) then) =
      __$$TripRequestCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TripEntity trip});

  $TripEntityCopyWith<$Res> get trip;
}

/// @nodoc
class __$$TripRequestCreatedImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripRequestCreatedImpl>
    implements _$$TripRequestCreatedImplCopyWith<$Res> {
  __$$TripRequestCreatedImplCopyWithImpl(_$TripRequestCreatedImpl _value,
      $Res Function(_$TripRequestCreatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trip = null,
  }) {
    return _then(_$TripRequestCreatedImpl(
      null == trip
          ? _value.trip
          : trip // ignore: cast_nullable_to_non_nullable
              as TripEntity,
    ));
  }

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TripEntityCopyWith<$Res> get trip {
    return $TripEntityCopyWith<$Res>(_value.trip, (value) {
      return _then(_value.copyWith(trip: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TripRequestCreatedImpl implements TripRequestCreated {
  const _$TripRequestCreatedImpl(this.trip, {final String? $type})
      : $type = $type ?? 'Created';

  factory _$TripRequestCreatedImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripRequestCreatedImplFromJson(json);

  @override
  final TripEntity trip;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.created(trip: $trip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripRequestCreatedImpl &&
            (identical(other.trip, trip) || other.trip == trip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trip);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripRequestCreatedImplCopyWith<_$TripRequestCreatedImpl> get copyWith =>
      __$$TripRequestCreatedImplCopyWithImpl<_$TripRequestCreatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return created(trip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return created?.call(trip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(trip);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripRequestCreatedImplToJson(
      this,
    );
  }
}

abstract class TripRequestCreated implements TripRequestState {
  const factory TripRequestCreated(final TripEntity trip) =
      _$TripRequestCreatedImpl;

  factory TripRequestCreated.fromJson(Map<String, dynamic> json) =
      _$TripRequestCreatedImpl.fromJson;

  TripEntity get trip;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripRequestCreatedImplCopyWith<_$TripRequestCreatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveTripLoadedImplCopyWith<$Res> {
  factory _$$ActiveTripLoadedImplCopyWith(_$ActiveTripLoadedImpl value,
          $Res Function(_$ActiveTripLoadedImpl) then) =
      __$$ActiveTripLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TripEntity? trip});

  $TripEntityCopyWith<$Res>? get trip;
}

/// @nodoc
class __$$ActiveTripLoadedImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$ActiveTripLoadedImpl>
    implements _$$ActiveTripLoadedImplCopyWith<$Res> {
  __$$ActiveTripLoadedImplCopyWithImpl(_$ActiveTripLoadedImpl _value,
      $Res Function(_$ActiveTripLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trip = freezed,
  }) {
    return _then(_$ActiveTripLoadedImpl(
      freezed == trip
          ? _value.trip
          : trip // ignore: cast_nullable_to_non_nullable
              as TripEntity?,
    ));
  }

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TripEntityCopyWith<$Res>? get trip {
    if (_value.trip == null) {
      return null;
    }

    return $TripEntityCopyWith<$Res>(_value.trip!, (value) {
      return _then(_value.copyWith(trip: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveTripLoadedImpl implements ActiveTripLoaded {
  const _$ActiveTripLoadedImpl(this.trip, {final String? $type})
      : $type = $type ?? 'ActiveTripLoaded';

  factory _$ActiveTripLoadedImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveTripLoadedImplFromJson(json);

  @override
  final TripEntity? trip;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.activeTripLoaded(trip: $trip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveTripLoadedImpl &&
            (identical(other.trip, trip) || other.trip == trip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trip);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveTripLoadedImplCopyWith<_$ActiveTripLoadedImpl> get copyWith =>
      __$$ActiveTripLoadedImplCopyWithImpl<_$ActiveTripLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return activeTripLoaded(trip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return activeTripLoaded?.call(trip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (activeTripLoaded != null) {
      return activeTripLoaded(trip);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return activeTripLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return activeTripLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (activeTripLoaded != null) {
      return activeTripLoaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveTripLoadedImplToJson(
      this,
    );
  }
}

abstract class ActiveTripLoaded implements TripRequestState {
  const factory ActiveTripLoaded(final TripEntity? trip) =
      _$ActiveTripLoadedImpl;

  factory ActiveTripLoaded.fromJson(Map<String, dynamic> json) =
      _$ActiveTripLoadedImpl.fromJson;

  TripEntity? get trip;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveTripLoadedImplCopyWith<_$ActiveTripLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TripHistoryLoadedImplCopyWith<$Res> {
  factory _$$TripHistoryLoadedImplCopyWith(_$TripHistoryLoadedImpl value,
          $Res Function(_$TripHistoryLoadedImpl) then) =
      __$$TripHistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TripEntity> trips});
}

/// @nodoc
class __$$TripHistoryLoadedImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripHistoryLoadedImpl>
    implements _$$TripHistoryLoadedImplCopyWith<$Res> {
  __$$TripHistoryLoadedImplCopyWithImpl(_$TripHistoryLoadedImpl _value,
      $Res Function(_$TripHistoryLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trips = null,
  }) {
    return _then(_$TripHistoryLoadedImpl(
      null == trips
          ? _value._trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<TripEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripHistoryLoadedImpl implements TripHistoryLoaded {
  const _$TripHistoryLoadedImpl(final List<TripEntity> trips,
      {final String? $type})
      : _trips = trips,
        $type = $type ?? 'HistoryLoaded';

  factory _$TripHistoryLoadedImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripHistoryLoadedImplFromJson(json);

  final List<TripEntity> _trips;
  @override
  List<TripEntity> get trips {
    if (_trips is EqualUnmodifiableListView) return _trips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trips);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.historyLoaded(trips: $trips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripHistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._trips, _trips));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_trips));

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripHistoryLoadedImplCopyWith<_$TripHistoryLoadedImpl> get copyWith =>
      __$$TripHistoryLoadedImplCopyWithImpl<_$TripHistoryLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return historyLoaded(trips);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return historyLoaded?.call(trips);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(trips);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return historyLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return historyLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripHistoryLoadedImplToJson(
      this,
    );
  }
}

abstract class TripHistoryLoaded implements TripRequestState {
  const factory TripHistoryLoaded(final List<TripEntity> trips) =
      _$TripHistoryLoadedImpl;

  factory TripHistoryLoaded.fromJson(Map<String, dynamic> json) =
      _$TripHistoryLoadedImpl.fromJson;

  List<TripEntity> get trips;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripHistoryLoadedImplCopyWith<_$TripHistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TripUpdatedImplCopyWith<$Res> {
  factory _$$TripUpdatedImplCopyWith(
          _$TripUpdatedImpl value, $Res Function(_$TripUpdatedImpl) then) =
      __$$TripUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TripEntity trip});

  $TripEntityCopyWith<$Res> get trip;
}

/// @nodoc
class __$$TripUpdatedImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripUpdatedImpl>
    implements _$$TripUpdatedImplCopyWith<$Res> {
  __$$TripUpdatedImplCopyWithImpl(
      _$TripUpdatedImpl _value, $Res Function(_$TripUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trip = null,
  }) {
    return _then(_$TripUpdatedImpl(
      null == trip
          ? _value.trip
          : trip // ignore: cast_nullable_to_non_nullable
              as TripEntity,
    ));
  }

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TripEntityCopyWith<$Res> get trip {
    return $TripEntityCopyWith<$Res>(_value.trip, (value) {
      return _then(_value.copyWith(trip: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TripUpdatedImpl implements TripUpdated {
  const _$TripUpdatedImpl(this.trip, {final String? $type})
      : $type = $type ?? 'Updated';

  factory _$TripUpdatedImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripUpdatedImplFromJson(json);

  @override
  final TripEntity trip;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.updated(trip: $trip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripUpdatedImpl &&
            (identical(other.trip, trip) || other.trip == trip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trip);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripUpdatedImplCopyWith<_$TripUpdatedImpl> get copyWith =>
      __$$TripUpdatedImplCopyWithImpl<_$TripUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return updated(trip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return updated?.call(trip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(trip);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripUpdatedImplToJson(
      this,
    );
  }
}

abstract class TripUpdated implements TripRequestState {
  const factory TripUpdated(final TripEntity trip) = _$TripUpdatedImpl;

  factory TripUpdated.fromJson(Map<String, dynamic> json) =
      _$TripUpdatedImpl.fromJson;

  TripEntity get trip;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripUpdatedImplCopyWith<_$TripUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TripRequestErrorImplCopyWith<$Res> {
  factory _$$TripRequestErrorImplCopyWith(_$TripRequestErrorImpl value,
          $Res Function(_$TripRequestErrorImpl) then) =
      __$$TripRequestErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TripRequestErrorImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripRequestErrorImpl>
    implements _$$TripRequestErrorImplCopyWith<$Res> {
  __$$TripRequestErrorImplCopyWithImpl(_$TripRequestErrorImpl _value,
      $Res Function(_$TripRequestErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TripRequestErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripRequestErrorImpl implements TripRequestError {
  const _$TripRequestErrorImpl(this.message, {final String? $type})
      : $type = $type ?? 'Error';

  factory _$TripRequestErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripRequestErrorImplFromJson(json);

  @override
  final String message;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TripRequestState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripRequestErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripRequestErrorImplCopyWith<_$TripRequestErrorImpl> get copyWith =>
      __$$TripRequestErrorImplCopyWithImpl<_$TripRequestErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(TripEntity trip) created,
    required TResult Function(TripEntity? trip) activeTripLoaded,
    required TResult Function(List<TripEntity> trips) historyLoaded,
    required TResult Function(TripEntity trip) updated,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(TripEntity trip)? created,
    TResult? Function(TripEntity? trip)? activeTripLoaded,
    TResult? Function(List<TripEntity> trips)? historyLoaded,
    TResult? Function(TripEntity trip)? updated,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(TripEntity trip)? created,
    TResult Function(TripEntity? trip)? activeTripLoaded,
    TResult Function(List<TripEntity> trips)? historyLoaded,
    TResult Function(TripEntity trip)? updated,
    TResult Function(String message)? error,
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
    required TResult Function(TripRequestInitial value) initial,
    required TResult Function(TripRequestLoading value) loading,
    required TResult Function(TripRequestCreated value) created,
    required TResult Function(ActiveTripLoaded value) activeTripLoaded,
    required TResult Function(TripHistoryLoaded value) historyLoaded,
    required TResult Function(TripUpdated value) updated,
    required TResult Function(TripRequestError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TripRequestInitial value)? initial,
    TResult? Function(TripRequestLoading value)? loading,
    TResult? Function(TripRequestCreated value)? created,
    TResult? Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult? Function(TripHistoryLoaded value)? historyLoaded,
    TResult? Function(TripUpdated value)? updated,
    TResult? Function(TripRequestError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TripRequestInitial value)? initial,
    TResult Function(TripRequestLoading value)? loading,
    TResult Function(TripRequestCreated value)? created,
    TResult Function(ActiveTripLoaded value)? activeTripLoaded,
    TResult Function(TripHistoryLoaded value)? historyLoaded,
    TResult Function(TripUpdated value)? updated,
    TResult Function(TripRequestError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TripRequestErrorImplToJson(
      this,
    );
  }
}

abstract class TripRequestError implements TripRequestState {
  const factory TripRequestError(final String message) = _$TripRequestErrorImpl;

  factory TripRequestError.fromJson(Map<String, dynamic> json) =
      _$TripRequestErrorImpl.fromJson;

  String get message;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripRequestErrorImplCopyWith<_$TripRequestErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
