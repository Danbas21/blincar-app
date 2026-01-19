// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_stream_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoStreamState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStreamStateCopyWith<$Res> {
  factory $VideoStreamStateCopyWith(
          VideoStreamState value, $Res Function(VideoStreamState) then) =
      _$VideoStreamStateCopyWithImpl<$Res, VideoStreamState>;
}

/// @nodoc
class _$VideoStreamStateCopyWithImpl<$Res, $Val extends VideoStreamState>
    implements $VideoStreamStateCopyWith<$Res> {
  _$VideoStreamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$VideoStreamInitialImplCopyWith<$Res> {
  factory _$$VideoStreamInitialImplCopyWith(_$VideoStreamInitialImpl value,
          $Res Function(_$VideoStreamInitialImpl) then) =
      __$$VideoStreamInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VideoStreamInitialImplCopyWithImpl<$Res>
    extends _$VideoStreamStateCopyWithImpl<$Res, _$VideoStreamInitialImpl>
    implements _$$VideoStreamInitialImplCopyWith<$Res> {
  __$$VideoStreamInitialImplCopyWithImpl(_$VideoStreamInitialImpl _value,
      $Res Function(_$VideoStreamInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VideoStreamInitialImpl implements VideoStreamInitial {
  const _$VideoStreamInitialImpl();

  @override
  String toString() {
    return 'VideoStreamState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VideoStreamInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
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
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class VideoStreamInitial implements VideoStreamState {
  const factory VideoStreamInitial() = _$VideoStreamInitialImpl;
}

/// @nodoc
abstract class _$$VideoStreamInitializingImplCopyWith<$Res> {
  factory _$$VideoStreamInitializingImplCopyWith(
          _$VideoStreamInitializingImpl value,
          $Res Function(_$VideoStreamInitializingImpl) then) =
      __$$VideoStreamInitializingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VideoStreamInitializingImplCopyWithImpl<$Res>
    extends _$VideoStreamStateCopyWithImpl<$Res, _$VideoStreamInitializingImpl>
    implements _$$VideoStreamInitializingImplCopyWith<$Res> {
  __$$VideoStreamInitializingImplCopyWithImpl(
      _$VideoStreamInitializingImpl _value,
      $Res Function(_$VideoStreamInitializingImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VideoStreamInitializingImpl implements VideoStreamInitializing {
  const _$VideoStreamInitializingImpl();

  @override
  String toString() {
    return 'VideoStreamState.initializing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStreamInitializingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) {
    return initializing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class VideoStreamInitializing implements VideoStreamState {
  const factory VideoStreamInitializing() = _$VideoStreamInitializingImpl;
}

/// @nodoc
abstract class _$$VideoStreamReadyImplCopyWith<$Res> {
  factory _$$VideoStreamReadyImplCopyWith(_$VideoStreamReadyImpl value,
          $Res Function(_$VideoStreamReadyImpl) then) =
      __$$VideoStreamReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$VideoStreamReadyImplCopyWithImpl<$Res>
    extends _$VideoStreamStateCopyWithImpl<$Res, _$VideoStreamReadyImpl>
    implements _$$VideoStreamReadyImplCopyWith<$Res> {
  __$$VideoStreamReadyImplCopyWithImpl(_$VideoStreamReadyImpl _value,
      $Res Function(_$VideoStreamReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
  }) {
    return _then(_$VideoStreamReadyImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VideoStreamReadyImpl implements VideoStreamReady {
  const _$VideoStreamReadyImpl({required this.sessionId});

  @override
  final String sessionId;

  @override
  String toString() {
    return 'VideoStreamState.ready(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStreamReadyImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStreamReadyImplCopyWith<_$VideoStreamReadyImpl> get copyWith =>
      __$$VideoStreamReadyImplCopyWithImpl<_$VideoStreamReadyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) {
    return ready(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) {
    return ready?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class VideoStreamReady implements VideoStreamState {
  const factory VideoStreamReady({required final String sessionId}) =
      _$VideoStreamReadyImpl;

  String get sessionId;

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStreamReadyImplCopyWith<_$VideoStreamReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VideoStreamActiveImplCopyWith<$Res> {
  factory _$$VideoStreamActiveImplCopyWith(_$VideoStreamActiveImpl value,
          $Res Function(_$VideoStreamActiveImpl) then) =
      __$$VideoStreamActiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId, int chunksUploaded, int totalSizeMB});
}

/// @nodoc
class __$$VideoStreamActiveImplCopyWithImpl<$Res>
    extends _$VideoStreamStateCopyWithImpl<$Res, _$VideoStreamActiveImpl>
    implements _$$VideoStreamActiveImplCopyWith<$Res> {
  __$$VideoStreamActiveImplCopyWithImpl(_$VideoStreamActiveImpl _value,
      $Res Function(_$VideoStreamActiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? chunksUploaded = null,
    Object? totalSizeMB = null,
  }) {
    return _then(_$VideoStreamActiveImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      chunksUploaded: null == chunksUploaded
          ? _value.chunksUploaded
          : chunksUploaded // ignore: cast_nullable_to_non_nullable
              as int,
      totalSizeMB: null == totalSizeMB
          ? _value.totalSizeMB
          : totalSizeMB // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VideoStreamActiveImpl implements VideoStreamActive {
  const _$VideoStreamActiveImpl(
      {required this.sessionId,
      required this.chunksUploaded,
      required this.totalSizeMB});

  @override
  final String sessionId;
  @override
  final int chunksUploaded;
  @override
  final int totalSizeMB;

  @override
  String toString() {
    return 'VideoStreamState.active(sessionId: $sessionId, chunksUploaded: $chunksUploaded, totalSizeMB: $totalSizeMB)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStreamActiveImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.chunksUploaded, chunksUploaded) ||
                other.chunksUploaded == chunksUploaded) &&
            (identical(other.totalSizeMB, totalSizeMB) ||
                other.totalSizeMB == totalSizeMB));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, chunksUploaded, totalSizeMB);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStreamActiveImplCopyWith<_$VideoStreamActiveImpl> get copyWith =>
      __$$VideoStreamActiveImplCopyWithImpl<_$VideoStreamActiveImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) {
    return active(sessionId, chunksUploaded, totalSizeMB);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) {
    return active?.call(sessionId, chunksUploaded, totalSizeMB);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(sessionId, chunksUploaded, totalSizeMB);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class VideoStreamActive implements VideoStreamState {
  const factory VideoStreamActive(
      {required final String sessionId,
      required final int chunksUploaded,
      required final int totalSizeMB}) = _$VideoStreamActiveImpl;

  String get sessionId;
  int get chunksUploaded;
  int get totalSizeMB;

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStreamActiveImplCopyWith<_$VideoStreamActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VideoStreamStoppedImplCopyWith<$Res> {
  factory _$$VideoStreamStoppedImplCopyWith(_$VideoStreamStoppedImpl value,
          $Res Function(_$VideoStreamStoppedImpl) then) =
      __$$VideoStreamStoppedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int totalChunks, int totalSizeMB});
}

/// @nodoc
class __$$VideoStreamStoppedImplCopyWithImpl<$Res>
    extends _$VideoStreamStateCopyWithImpl<$Res, _$VideoStreamStoppedImpl>
    implements _$$VideoStreamStoppedImplCopyWith<$Res> {
  __$$VideoStreamStoppedImplCopyWithImpl(_$VideoStreamStoppedImpl _value,
      $Res Function(_$VideoStreamStoppedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalChunks = null,
    Object? totalSizeMB = null,
  }) {
    return _then(_$VideoStreamStoppedImpl(
      totalChunks: null == totalChunks
          ? _value.totalChunks
          : totalChunks // ignore: cast_nullable_to_non_nullable
              as int,
      totalSizeMB: null == totalSizeMB
          ? _value.totalSizeMB
          : totalSizeMB // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VideoStreamStoppedImpl implements VideoStreamStopped {
  const _$VideoStreamStoppedImpl(
      {required this.totalChunks, required this.totalSizeMB});

  @override
  final int totalChunks;
  @override
  final int totalSizeMB;

  @override
  String toString() {
    return 'VideoStreamState.stopped(totalChunks: $totalChunks, totalSizeMB: $totalSizeMB)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStreamStoppedImpl &&
            (identical(other.totalChunks, totalChunks) ||
                other.totalChunks == totalChunks) &&
            (identical(other.totalSizeMB, totalSizeMB) ||
                other.totalSizeMB == totalSizeMB));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalChunks, totalSizeMB);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStreamStoppedImplCopyWith<_$VideoStreamStoppedImpl> get copyWith =>
      __$$VideoStreamStoppedImplCopyWithImpl<_$VideoStreamStoppedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) {
    return stopped(totalChunks, totalSizeMB);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) {
    return stopped?.call(totalChunks, totalSizeMB);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped(totalChunks, totalSizeMB);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) {
    return stopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) {
    return stopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped(this);
    }
    return orElse();
  }
}

abstract class VideoStreamStopped implements VideoStreamState {
  const factory VideoStreamStopped(
      {required final int totalChunks,
      required final int totalSizeMB}) = _$VideoStreamStoppedImpl;

  int get totalChunks;
  int get totalSizeMB;

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStreamStoppedImplCopyWith<_$VideoStreamStoppedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VideoStreamErrorImplCopyWith<$Res> {
  factory _$$VideoStreamErrorImplCopyWith(_$VideoStreamErrorImpl value,
          $Res Function(_$VideoStreamErrorImpl) then) =
      __$$VideoStreamErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$VideoStreamErrorImplCopyWithImpl<$Res>
    extends _$VideoStreamStateCopyWithImpl<$Res, _$VideoStreamErrorImpl>
    implements _$$VideoStreamErrorImplCopyWith<$Res> {
  __$$VideoStreamErrorImplCopyWithImpl(_$VideoStreamErrorImpl _value,
      $Res Function(_$VideoStreamErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$VideoStreamErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VideoStreamErrorImpl implements VideoStreamError {
  const _$VideoStreamErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'VideoStreamState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStreamErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStreamErrorImplCopyWith<_$VideoStreamErrorImpl> get copyWith =>
      __$$VideoStreamErrorImplCopyWithImpl<_$VideoStreamErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() initializing,
    required TResult Function(String sessionId) ready,
    required TResult Function(
            String sessionId, int chunksUploaded, int totalSizeMB)
        active,
    required TResult Function(int totalChunks, int totalSizeMB) stopped,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? initializing,
    TResult? Function(String sessionId)? ready,
    TResult? Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult? Function(int totalChunks, int totalSizeMB)? stopped,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? initializing,
    TResult Function(String sessionId)? ready,
    TResult Function(String sessionId, int chunksUploaded, int totalSizeMB)?
        active,
    TResult Function(int totalChunks, int totalSizeMB)? stopped,
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
    required TResult Function(VideoStreamInitial value) initial,
    required TResult Function(VideoStreamInitializing value) initializing,
    required TResult Function(VideoStreamReady value) ready,
    required TResult Function(VideoStreamActive value) active,
    required TResult Function(VideoStreamStopped value) stopped,
    required TResult Function(VideoStreamError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VideoStreamInitial value)? initial,
    TResult? Function(VideoStreamInitializing value)? initializing,
    TResult? Function(VideoStreamReady value)? ready,
    TResult? Function(VideoStreamActive value)? active,
    TResult? Function(VideoStreamStopped value)? stopped,
    TResult? Function(VideoStreamError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VideoStreamInitial value)? initial,
    TResult Function(VideoStreamInitializing value)? initializing,
    TResult Function(VideoStreamReady value)? ready,
    TResult Function(VideoStreamActive value)? active,
    TResult Function(VideoStreamStopped value)? stopped,
    TResult Function(VideoStreamError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class VideoStreamError implements VideoStreamState {
  const factory VideoStreamError({required final String message}) =
      _$VideoStreamErrorImpl;

  String get message;

  /// Create a copy of VideoStreamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStreamErrorImplCopyWith<_$VideoStreamErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
