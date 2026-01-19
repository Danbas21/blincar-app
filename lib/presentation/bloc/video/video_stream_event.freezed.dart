// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_stream_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoStreamEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tripId, String driverId) initialize,
    required TResult Function(String sessionId) startStreaming,
    required TResult Function(String sessionId) stopStreaming,
    required TResult Function(String sessionId, int chunkSize) chunkUploaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tripId, String driverId)? initialize,
    TResult? Function(String sessionId)? startStreaming,
    TResult? Function(String sessionId)? stopStreaming,
    TResult? Function(String sessionId, int chunkSize)? chunkUploaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tripId, String driverId)? initialize,
    TResult Function(String sessionId)? startStreaming,
    TResult Function(String sessionId)? stopStreaming,
    TResult Function(String sessionId, int chunkSize)? chunkUploaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeVideoEvent value) initialize,
    required TResult Function(StartStreamingEvent value) startStreaming,
    required TResult Function(StopStreamingEvent value) stopStreaming,
    required TResult Function(ChunkUploadedEvent value) chunkUploaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeVideoEvent value)? initialize,
    TResult? Function(StartStreamingEvent value)? startStreaming,
    TResult? Function(StopStreamingEvent value)? stopStreaming,
    TResult? Function(ChunkUploadedEvent value)? chunkUploaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeVideoEvent value)? initialize,
    TResult Function(StartStreamingEvent value)? startStreaming,
    TResult Function(StopStreamingEvent value)? stopStreaming,
    TResult Function(ChunkUploadedEvent value)? chunkUploaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStreamEventCopyWith<$Res> {
  factory $VideoStreamEventCopyWith(
          VideoStreamEvent value, $Res Function(VideoStreamEvent) then) =
      _$VideoStreamEventCopyWithImpl<$Res, VideoStreamEvent>;
}

/// @nodoc
class _$VideoStreamEventCopyWithImpl<$Res, $Val extends VideoStreamEvent>
    implements $VideoStreamEventCopyWith<$Res> {
  _$VideoStreamEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeVideoEventImplCopyWith<$Res> {
  factory _$$InitializeVideoEventImplCopyWith(_$InitializeVideoEventImpl value,
          $Res Function(_$InitializeVideoEventImpl) then) =
      __$$InitializeVideoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tripId, String driverId});
}

/// @nodoc
class __$$InitializeVideoEventImplCopyWithImpl<$Res>
    extends _$VideoStreamEventCopyWithImpl<$Res, _$InitializeVideoEventImpl>
    implements _$$InitializeVideoEventImplCopyWith<$Res> {
  __$$InitializeVideoEventImplCopyWithImpl(_$InitializeVideoEventImpl _value,
      $Res Function(_$InitializeVideoEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? driverId = null,
  }) {
    return _then(_$InitializeVideoEventImpl(
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitializeVideoEventImpl implements InitializeVideoEvent {
  const _$InitializeVideoEventImpl(
      {required this.tripId, required this.driverId});

  @override
  final String tripId;
  @override
  final String driverId;

  @override
  String toString() {
    return 'VideoStreamEvent.initialize(tripId: $tripId, driverId: $driverId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializeVideoEventImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tripId, driverId);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializeVideoEventImplCopyWith<_$InitializeVideoEventImpl>
      get copyWith =>
          __$$InitializeVideoEventImplCopyWithImpl<_$InitializeVideoEventImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tripId, String driverId) initialize,
    required TResult Function(String sessionId) startStreaming,
    required TResult Function(String sessionId) stopStreaming,
    required TResult Function(String sessionId, int chunkSize) chunkUploaded,
  }) {
    return initialize(tripId, driverId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tripId, String driverId)? initialize,
    TResult? Function(String sessionId)? startStreaming,
    TResult? Function(String sessionId)? stopStreaming,
    TResult? Function(String sessionId, int chunkSize)? chunkUploaded,
  }) {
    return initialize?.call(tripId, driverId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tripId, String driverId)? initialize,
    TResult Function(String sessionId)? startStreaming,
    TResult Function(String sessionId)? stopStreaming,
    TResult Function(String sessionId, int chunkSize)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(tripId, driverId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeVideoEvent value) initialize,
    required TResult Function(StartStreamingEvent value) startStreaming,
    required TResult Function(StopStreamingEvent value) stopStreaming,
    required TResult Function(ChunkUploadedEvent value) chunkUploaded,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeVideoEvent value)? initialize,
    TResult? Function(StartStreamingEvent value)? startStreaming,
    TResult? Function(StopStreamingEvent value)? stopStreaming,
    TResult? Function(ChunkUploadedEvent value)? chunkUploaded,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeVideoEvent value)? initialize,
    TResult Function(StartStreamingEvent value)? startStreaming,
    TResult Function(StopStreamingEvent value)? stopStreaming,
    TResult Function(ChunkUploadedEvent value)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class InitializeVideoEvent implements VideoStreamEvent {
  const factory InitializeVideoEvent(
      {required final String tripId,
      required final String driverId}) = _$InitializeVideoEventImpl;

  String get tripId;
  String get driverId;

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitializeVideoEventImplCopyWith<_$InitializeVideoEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartStreamingEventImplCopyWith<$Res> {
  factory _$$StartStreamingEventImplCopyWith(_$StartStreamingEventImpl value,
          $Res Function(_$StartStreamingEventImpl) then) =
      __$$StartStreamingEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$StartStreamingEventImplCopyWithImpl<$Res>
    extends _$VideoStreamEventCopyWithImpl<$Res, _$StartStreamingEventImpl>
    implements _$$StartStreamingEventImplCopyWith<$Res> {
  __$$StartStreamingEventImplCopyWithImpl(_$StartStreamingEventImpl _value,
      $Res Function(_$StartStreamingEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
  }) {
    return _then(_$StartStreamingEventImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StartStreamingEventImpl implements StartStreamingEvent {
  const _$StartStreamingEventImpl({required this.sessionId});

  @override
  final String sessionId;

  @override
  String toString() {
    return 'VideoStreamEvent.startStreaming(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartStreamingEventImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartStreamingEventImplCopyWith<_$StartStreamingEventImpl> get copyWith =>
      __$$StartStreamingEventImplCopyWithImpl<_$StartStreamingEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tripId, String driverId) initialize,
    required TResult Function(String sessionId) startStreaming,
    required TResult Function(String sessionId) stopStreaming,
    required TResult Function(String sessionId, int chunkSize) chunkUploaded,
  }) {
    return startStreaming(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tripId, String driverId)? initialize,
    TResult? Function(String sessionId)? startStreaming,
    TResult? Function(String sessionId)? stopStreaming,
    TResult? Function(String sessionId, int chunkSize)? chunkUploaded,
  }) {
    return startStreaming?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tripId, String driverId)? initialize,
    TResult Function(String sessionId)? startStreaming,
    TResult Function(String sessionId)? stopStreaming,
    TResult Function(String sessionId, int chunkSize)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeVideoEvent value) initialize,
    required TResult Function(StartStreamingEvent value) startStreaming,
    required TResult Function(StopStreamingEvent value) stopStreaming,
    required TResult Function(ChunkUploadedEvent value) chunkUploaded,
  }) {
    return startStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeVideoEvent value)? initialize,
    TResult? Function(StartStreamingEvent value)? startStreaming,
    TResult? Function(StopStreamingEvent value)? stopStreaming,
    TResult? Function(ChunkUploadedEvent value)? chunkUploaded,
  }) {
    return startStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeVideoEvent value)? initialize,
    TResult Function(StartStreamingEvent value)? startStreaming,
    TResult Function(StopStreamingEvent value)? stopStreaming,
    TResult Function(ChunkUploadedEvent value)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (startStreaming != null) {
      return startStreaming(this);
    }
    return orElse();
  }
}

abstract class StartStreamingEvent implements VideoStreamEvent {
  const factory StartStreamingEvent({required final String sessionId}) =
      _$StartStreamingEventImpl;

  String get sessionId;

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartStreamingEventImplCopyWith<_$StartStreamingEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StopStreamingEventImplCopyWith<$Res> {
  factory _$$StopStreamingEventImplCopyWith(_$StopStreamingEventImpl value,
          $Res Function(_$StopStreamingEventImpl) then) =
      __$$StopStreamingEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$StopStreamingEventImplCopyWithImpl<$Res>
    extends _$VideoStreamEventCopyWithImpl<$Res, _$StopStreamingEventImpl>
    implements _$$StopStreamingEventImplCopyWith<$Res> {
  __$$StopStreamingEventImplCopyWithImpl(_$StopStreamingEventImpl _value,
      $Res Function(_$StopStreamingEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
  }) {
    return _then(_$StopStreamingEventImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StopStreamingEventImpl implements StopStreamingEvent {
  const _$StopStreamingEventImpl({required this.sessionId});

  @override
  final String sessionId;

  @override
  String toString() {
    return 'VideoStreamEvent.stopStreaming(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopStreamingEventImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StopStreamingEventImplCopyWith<_$StopStreamingEventImpl> get copyWith =>
      __$$StopStreamingEventImplCopyWithImpl<_$StopStreamingEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tripId, String driverId) initialize,
    required TResult Function(String sessionId) startStreaming,
    required TResult Function(String sessionId) stopStreaming,
    required TResult Function(String sessionId, int chunkSize) chunkUploaded,
  }) {
    return stopStreaming(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tripId, String driverId)? initialize,
    TResult? Function(String sessionId)? startStreaming,
    TResult? Function(String sessionId)? stopStreaming,
    TResult? Function(String sessionId, int chunkSize)? chunkUploaded,
  }) {
    return stopStreaming?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tripId, String driverId)? initialize,
    TResult Function(String sessionId)? startStreaming,
    TResult Function(String sessionId)? stopStreaming,
    TResult Function(String sessionId, int chunkSize)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (stopStreaming != null) {
      return stopStreaming(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeVideoEvent value) initialize,
    required TResult Function(StartStreamingEvent value) startStreaming,
    required TResult Function(StopStreamingEvent value) stopStreaming,
    required TResult Function(ChunkUploadedEvent value) chunkUploaded,
  }) {
    return stopStreaming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeVideoEvent value)? initialize,
    TResult? Function(StartStreamingEvent value)? startStreaming,
    TResult? Function(StopStreamingEvent value)? stopStreaming,
    TResult? Function(ChunkUploadedEvent value)? chunkUploaded,
  }) {
    return stopStreaming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeVideoEvent value)? initialize,
    TResult Function(StartStreamingEvent value)? startStreaming,
    TResult Function(StopStreamingEvent value)? stopStreaming,
    TResult Function(ChunkUploadedEvent value)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (stopStreaming != null) {
      return stopStreaming(this);
    }
    return orElse();
  }
}

abstract class StopStreamingEvent implements VideoStreamEvent {
  const factory StopStreamingEvent({required final String sessionId}) =
      _$StopStreamingEventImpl;

  String get sessionId;

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StopStreamingEventImplCopyWith<_$StopStreamingEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChunkUploadedEventImplCopyWith<$Res> {
  factory _$$ChunkUploadedEventImplCopyWith(_$ChunkUploadedEventImpl value,
          $Res Function(_$ChunkUploadedEventImpl) then) =
      __$$ChunkUploadedEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId, int chunkSize});
}

/// @nodoc
class __$$ChunkUploadedEventImplCopyWithImpl<$Res>
    extends _$VideoStreamEventCopyWithImpl<$Res, _$ChunkUploadedEventImpl>
    implements _$$ChunkUploadedEventImplCopyWith<$Res> {
  __$$ChunkUploadedEventImplCopyWithImpl(_$ChunkUploadedEventImpl _value,
      $Res Function(_$ChunkUploadedEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? chunkSize = null,
  }) {
    return _then(_$ChunkUploadedEventImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      chunkSize: null == chunkSize
          ? _value.chunkSize
          : chunkSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ChunkUploadedEventImpl implements ChunkUploadedEvent {
  const _$ChunkUploadedEventImpl(
      {required this.sessionId, required this.chunkSize});

  @override
  final String sessionId;
  @override
  final int chunkSize;

  @override
  String toString() {
    return 'VideoStreamEvent.chunkUploaded(sessionId: $sessionId, chunkSize: $chunkSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChunkUploadedEventImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.chunkSize, chunkSize) ||
                other.chunkSize == chunkSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId, chunkSize);

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChunkUploadedEventImplCopyWith<_$ChunkUploadedEventImpl> get copyWith =>
      __$$ChunkUploadedEventImplCopyWithImpl<_$ChunkUploadedEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tripId, String driverId) initialize,
    required TResult Function(String sessionId) startStreaming,
    required TResult Function(String sessionId) stopStreaming,
    required TResult Function(String sessionId, int chunkSize) chunkUploaded,
  }) {
    return chunkUploaded(sessionId, chunkSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tripId, String driverId)? initialize,
    TResult? Function(String sessionId)? startStreaming,
    TResult? Function(String sessionId)? stopStreaming,
    TResult? Function(String sessionId, int chunkSize)? chunkUploaded,
  }) {
    return chunkUploaded?.call(sessionId, chunkSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tripId, String driverId)? initialize,
    TResult Function(String sessionId)? startStreaming,
    TResult Function(String sessionId)? stopStreaming,
    TResult Function(String sessionId, int chunkSize)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (chunkUploaded != null) {
      return chunkUploaded(sessionId, chunkSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeVideoEvent value) initialize,
    required TResult Function(StartStreamingEvent value) startStreaming,
    required TResult Function(StopStreamingEvent value) stopStreaming,
    required TResult Function(ChunkUploadedEvent value) chunkUploaded,
  }) {
    return chunkUploaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeVideoEvent value)? initialize,
    TResult? Function(StartStreamingEvent value)? startStreaming,
    TResult? Function(StopStreamingEvent value)? stopStreaming,
    TResult? Function(ChunkUploadedEvent value)? chunkUploaded,
  }) {
    return chunkUploaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeVideoEvent value)? initialize,
    TResult Function(StartStreamingEvent value)? startStreaming,
    TResult Function(StopStreamingEvent value)? stopStreaming,
    TResult Function(ChunkUploadedEvent value)? chunkUploaded,
    required TResult orElse(),
  }) {
    if (chunkUploaded != null) {
      return chunkUploaded(this);
    }
    return orElse();
  }
}

abstract class ChunkUploadedEvent implements VideoStreamEvent {
  const factory ChunkUploadedEvent(
      {required final String sessionId,
      required final int chunkSize}) = _$ChunkUploadedEventImpl;

  String get sessionId;
  int get chunkSize;

  /// Create a copy of VideoStreamEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChunkUploadedEventImplCopyWith<_$ChunkUploadedEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
