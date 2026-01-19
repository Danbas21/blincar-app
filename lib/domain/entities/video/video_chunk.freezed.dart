// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_chunk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoChunkMetadata _$VideoChunkMetadataFromJson(Map<String, dynamic> json) {
  return _VideoChunkMetadata.fromJson(json);
}

/// @nodoc
mixin _$VideoChunkMetadata {
  String get tripId => throw _privateConstructorUsedError;
  String get driverId => throw _privateConstructorUsedError;
  VideoSource get source => throw _privateConstructorUsedError;
  VideoQuality get quality => throw _privateConstructorUsedError;
  int get durationMs =>
      throw _privateConstructorUsedError; // Duracion del chunk en milisegundos
  Coordinates? get location => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String tripId, String driverId, VideoSource source,
            VideoQuality quality, int durationMs, Coordinates? location)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String tripId, String driverId, VideoSource source,
            VideoQuality quality, int durationMs, Coordinates? location)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String tripId, String driverId, VideoSource source,
            VideoQuality quality, int durationMs, Coordinates? location)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoChunkMetadata value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoChunkMetadata value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoChunkMetadata value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this VideoChunkMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoChunkMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoChunkMetadataCopyWith<VideoChunkMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoChunkMetadataCopyWith<$Res> {
  factory $VideoChunkMetadataCopyWith(
          VideoChunkMetadata value, $Res Function(VideoChunkMetadata) then) =
      _$VideoChunkMetadataCopyWithImpl<$Res, VideoChunkMetadata>;
  @useResult
  $Res call(
      {String tripId,
      String driverId,
      VideoSource source,
      VideoQuality quality,
      int durationMs,
      Coordinates? location});

  $CoordinatesCopyWith<$Res>? get location;
}

/// @nodoc
class _$VideoChunkMetadataCopyWithImpl<$Res, $Val extends VideoChunkMetadata>
    implements $VideoChunkMetadataCopyWith<$Res> {
  _$VideoChunkMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoChunkMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? driverId = null,
    Object? source = null,
    Object? quality = null,
    Object? durationMs = null,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as VideoSource,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as VideoQuality,
      durationMs: null == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
    ) as $Val);
  }

  /// Create a copy of VideoChunkMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinatesCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $CoordinatesCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VideoChunkMetadataImplCopyWith<$Res>
    implements $VideoChunkMetadataCopyWith<$Res> {
  factory _$$VideoChunkMetadataImplCopyWith(_$VideoChunkMetadataImpl value,
          $Res Function(_$VideoChunkMetadataImpl) then) =
      __$$VideoChunkMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tripId,
      String driverId,
      VideoSource source,
      VideoQuality quality,
      int durationMs,
      Coordinates? location});

  @override
  $CoordinatesCopyWith<$Res>? get location;
}

/// @nodoc
class __$$VideoChunkMetadataImplCopyWithImpl<$Res>
    extends _$VideoChunkMetadataCopyWithImpl<$Res, _$VideoChunkMetadataImpl>
    implements _$$VideoChunkMetadataImplCopyWith<$Res> {
  __$$VideoChunkMetadataImplCopyWithImpl(_$VideoChunkMetadataImpl _value,
      $Res Function(_$VideoChunkMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoChunkMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? driverId = null,
    Object? source = null,
    Object? quality = null,
    Object? durationMs = null,
    Object? location = freezed,
  }) {
    return _then(_$VideoChunkMetadataImpl(
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as VideoSource,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as VideoQuality,
      durationMs: null == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoChunkMetadataImpl extends _VideoChunkMetadata {
  const _$VideoChunkMetadataImpl(
      {required this.tripId,
      required this.driverId,
      required this.source,
      required this.quality,
      required this.durationMs,
      this.location})
      : super._();

  factory _$VideoChunkMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoChunkMetadataImplFromJson(json);

  @override
  final String tripId;
  @override
  final String driverId;
  @override
  final VideoSource source;
  @override
  final VideoQuality quality;
  @override
  final int durationMs;
// Duracion del chunk en milisegundos
  @override
  final Coordinates? location;

  @override
  String toString() {
    return 'VideoChunkMetadata(tripId: $tripId, driverId: $driverId, source: $source, quality: $quality, durationMs: $durationMs, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoChunkMetadataImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, tripId, driverId, source, quality, durationMs, location);

  /// Create a copy of VideoChunkMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoChunkMetadataImplCopyWith<_$VideoChunkMetadataImpl> get copyWith =>
      __$$VideoChunkMetadataImplCopyWithImpl<_$VideoChunkMetadataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String tripId, String driverId, VideoSource source,
            VideoQuality quality, int durationMs, Coordinates? location)
        $default,
  ) {
    return $default(tripId, driverId, source, quality, durationMs, location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String tripId, String driverId, VideoSource source,
            VideoQuality quality, int durationMs, Coordinates? location)?
        $default,
  ) {
    return $default?.call(
        tripId, driverId, source, quality, durationMs, location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String tripId, String driverId, VideoSource source,
            VideoQuality quality, int durationMs, Coordinates? location)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(tripId, driverId, source, quality, durationMs, location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoChunkMetadata value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoChunkMetadata value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoChunkMetadata value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoChunkMetadataImplToJson(
      this,
    );
  }
}

abstract class _VideoChunkMetadata extends VideoChunkMetadata {
  const factory _VideoChunkMetadata(
      {required final String tripId,
      required final String driverId,
      required final VideoSource source,
      required final VideoQuality quality,
      required final int durationMs,
      final Coordinates? location}) = _$VideoChunkMetadataImpl;
  const _VideoChunkMetadata._() : super._();

  factory _VideoChunkMetadata.fromJson(Map<String, dynamic> json) =
      _$VideoChunkMetadataImpl.fromJson;

  @override
  String get tripId;
  @override
  String get driverId;
  @override
  VideoSource get source;
  @override
  VideoQuality get quality;
  @override
  int get durationMs; // Duracion del chunk en milisegundos
  @override
  Coordinates? get location;

  /// Create a copy of VideoChunkMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoChunkMetadataImplCopyWith<_$VideoChunkMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoChunk _$VideoChunkFromJson(Map<String, dynamic> json) {
  return _VideoChunk.fromJson(json);
}

/// @nodoc
mixin _$VideoChunk {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<int> get data => throw _privateConstructorUsedError; // Bytes del video
  int get sequenceNumber => throw _privateConstructorUsedError;
  VideoChunkMetadata get metadata => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, DateTime timestamp, List<int> data,
            int sequenceNumber, VideoChunkMetadata metadata)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, DateTime timestamp, List<int> data,
            int sequenceNumber, VideoChunkMetadata metadata)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, DateTime timestamp, List<int> data,
            int sequenceNumber, VideoChunkMetadata metadata)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoChunk value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoChunk value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoChunk value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this VideoChunk to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoChunk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoChunkCopyWith<VideoChunk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoChunkCopyWith<$Res> {
  factory $VideoChunkCopyWith(
          VideoChunk value, $Res Function(VideoChunk) then) =
      _$VideoChunkCopyWithImpl<$Res, VideoChunk>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      List<int> data,
      int sequenceNumber,
      VideoChunkMetadata metadata});

  $VideoChunkMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$VideoChunkCopyWithImpl<$Res, $Val extends VideoChunk>
    implements $VideoChunkCopyWith<$Res> {
  _$VideoChunkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoChunk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? data = null,
    Object? sequenceNumber = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sequenceNumber: null == sequenceNumber
          ? _value.sequenceNumber
          : sequenceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as VideoChunkMetadata,
    ) as $Val);
  }

  /// Create a copy of VideoChunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VideoChunkMetadataCopyWith<$Res> get metadata {
    return $VideoChunkMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VideoChunkImplCopyWith<$Res>
    implements $VideoChunkCopyWith<$Res> {
  factory _$$VideoChunkImplCopyWith(
          _$VideoChunkImpl value, $Res Function(_$VideoChunkImpl) then) =
      __$$VideoChunkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      List<int> data,
      int sequenceNumber,
      VideoChunkMetadata metadata});

  @override
  $VideoChunkMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$VideoChunkImplCopyWithImpl<$Res>
    extends _$VideoChunkCopyWithImpl<$Res, _$VideoChunkImpl>
    implements _$$VideoChunkImplCopyWith<$Res> {
  __$$VideoChunkImplCopyWithImpl(
      _$VideoChunkImpl _value, $Res Function(_$VideoChunkImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoChunk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? data = null,
    Object? sequenceNumber = null,
    Object? metadata = null,
  }) {
    return _then(_$VideoChunkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sequenceNumber: null == sequenceNumber
          ? _value.sequenceNumber
          : sequenceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as VideoChunkMetadata,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoChunkImpl extends _VideoChunk {
  const _$VideoChunkImpl(
      {required this.id,
      required this.timestamp,
      required final List<int> data,
      required this.sequenceNumber,
      required this.metadata})
      : _data = data,
        super._();

  factory _$VideoChunkImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoChunkImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  final List<int> _data;
  @override
  List<int> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

// Bytes del video
  @override
  final int sequenceNumber;
  @override
  final VideoChunkMetadata metadata;

  @override
  String toString() {
    return 'VideoChunk(id: $id, timestamp: $timestamp, data: $data, sequenceNumber: $sequenceNumber, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoChunkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.sequenceNumber, sequenceNumber) ||
                other.sequenceNumber == sequenceNumber) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, timestamp,
      const DeepCollectionEquality().hash(_data), sequenceNumber, metadata);

  /// Create a copy of VideoChunk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoChunkImplCopyWith<_$VideoChunkImpl> get copyWith =>
      __$$VideoChunkImplCopyWithImpl<_$VideoChunkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, DateTime timestamp, List<int> data,
            int sequenceNumber, VideoChunkMetadata metadata)
        $default,
  ) {
    return $default(id, timestamp, data, sequenceNumber, metadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, DateTime timestamp, List<int> data,
            int sequenceNumber, VideoChunkMetadata metadata)?
        $default,
  ) {
    return $default?.call(id, timestamp, data, sequenceNumber, metadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, DateTime timestamp, List<int> data,
            int sequenceNumber, VideoChunkMetadata metadata)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, timestamp, data, sequenceNumber, metadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoChunk value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoChunk value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoChunk value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoChunkImplToJson(
      this,
    );
  }
}

abstract class _VideoChunk extends VideoChunk {
  const factory _VideoChunk(
      {required final String id,
      required final DateTime timestamp,
      required final List<int> data,
      required final int sequenceNumber,
      required final VideoChunkMetadata metadata}) = _$VideoChunkImpl;
  const _VideoChunk._() : super._();

  factory _VideoChunk.fromJson(Map<String, dynamic> json) =
      _$VideoChunkImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  List<int> get data; // Bytes del video
  @override
  int get sequenceNumber;
  @override
  VideoChunkMetadata get metadata;

  /// Create a copy of VideoChunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoChunkImplCopyWith<_$VideoChunkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoSession _$VideoSessionFromJson(Map<String, dynamic> json) {
  return _VideoSession.fromJson(json);
}

/// @nodoc
mixin _$VideoSession {
  String get id => throw _privateConstructorUsedError;
  String get tripId => throw _privateConstructorUsedError;
  String get driverId => throw _privateConstructorUsedError;
  VideoSource get source => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  VideoSessionStatus get status => throw _privateConstructorUsedError;
  List<String> get chunkIds =>
      throw _privateConstructorUsedError; // IDs de los chunks grabados
  int get totalChunks => throw _privateConstructorUsedError;
  int get totalSizeBytes => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String tripId,
            String driverId,
            VideoSource source,
            DateTime startedAt,
            DateTime? endedAt,
            VideoSessionStatus status,
            List<String> chunkIds,
            int totalChunks,
            int totalSizeBytes)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String tripId,
            String driverId,
            VideoSource source,
            DateTime startedAt,
            DateTime? endedAt,
            VideoSessionStatus status,
            List<String> chunkIds,
            int totalChunks,
            int totalSizeBytes)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String tripId,
            String driverId,
            VideoSource source,
            DateTime startedAt,
            DateTime? endedAt,
            VideoSessionStatus status,
            List<String> chunkIds,
            int totalChunks,
            int totalSizeBytes)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoSession value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoSession value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoSession value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this VideoSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoSessionCopyWith<VideoSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoSessionCopyWith<$Res> {
  factory $VideoSessionCopyWith(
          VideoSession value, $Res Function(VideoSession) then) =
      _$VideoSessionCopyWithImpl<$Res, VideoSession>;
  @useResult
  $Res call(
      {String id,
      String tripId,
      String driverId,
      VideoSource source,
      DateTime startedAt,
      DateTime? endedAt,
      VideoSessionStatus status,
      List<String> chunkIds,
      int totalChunks,
      int totalSizeBytes});
}

/// @nodoc
class _$VideoSessionCopyWithImpl<$Res, $Val extends VideoSession>
    implements $VideoSessionCopyWith<$Res> {
  _$VideoSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? driverId = null,
    Object? source = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? status = null,
    Object? chunkIds = null,
    Object? totalChunks = null,
    Object? totalSizeBytes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as VideoSource,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VideoSessionStatus,
      chunkIds: null == chunkIds
          ? _value.chunkIds
          : chunkIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalChunks: null == totalChunks
          ? _value.totalChunks
          : totalChunks // ignore: cast_nullable_to_non_nullable
              as int,
      totalSizeBytes: null == totalSizeBytes
          ? _value.totalSizeBytes
          : totalSizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoSessionImplCopyWith<$Res>
    implements $VideoSessionCopyWith<$Res> {
  factory _$$VideoSessionImplCopyWith(
          _$VideoSessionImpl value, $Res Function(_$VideoSessionImpl) then) =
      __$$VideoSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String tripId,
      String driverId,
      VideoSource source,
      DateTime startedAt,
      DateTime? endedAt,
      VideoSessionStatus status,
      List<String> chunkIds,
      int totalChunks,
      int totalSizeBytes});
}

/// @nodoc
class __$$VideoSessionImplCopyWithImpl<$Res>
    extends _$VideoSessionCopyWithImpl<$Res, _$VideoSessionImpl>
    implements _$$VideoSessionImplCopyWith<$Res> {
  __$$VideoSessionImplCopyWithImpl(
      _$VideoSessionImpl _value, $Res Function(_$VideoSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? driverId = null,
    Object? source = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? status = null,
    Object? chunkIds = null,
    Object? totalChunks = null,
    Object? totalSizeBytes = null,
  }) {
    return _then(_$VideoSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: null == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as VideoSource,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VideoSessionStatus,
      chunkIds: null == chunkIds
          ? _value._chunkIds
          : chunkIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalChunks: null == totalChunks
          ? _value.totalChunks
          : totalChunks // ignore: cast_nullable_to_non_nullable
              as int,
      totalSizeBytes: null == totalSizeBytes
          ? _value.totalSizeBytes
          : totalSizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoSessionImpl extends _VideoSession {
  const _$VideoSessionImpl(
      {required this.id,
      required this.tripId,
      required this.driverId,
      required this.source,
      required this.startedAt,
      this.endedAt,
      required this.status,
      final List<String> chunkIds = const [],
      this.totalChunks = 0,
      this.totalSizeBytes = 0})
      : _chunkIds = chunkIds,
        super._();

  factory _$VideoSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String tripId;
  @override
  final String driverId;
  @override
  final VideoSource source;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  final VideoSessionStatus status;
  final List<String> _chunkIds;
  @override
  @JsonKey()
  List<String> get chunkIds {
    if (_chunkIds is EqualUnmodifiableListView) return _chunkIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chunkIds);
  }

// IDs de los chunks grabados
  @override
  @JsonKey()
  final int totalChunks;
  @override
  @JsonKey()
  final int totalSizeBytes;

  @override
  String toString() {
    return 'VideoSession(id: $id, tripId: $tripId, driverId: $driverId, source: $source, startedAt: $startedAt, endedAt: $endedAt, status: $status, chunkIds: $chunkIds, totalChunks: $totalChunks, totalSizeBytes: $totalSizeBytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._chunkIds, _chunkIds) &&
            (identical(other.totalChunks, totalChunks) ||
                other.totalChunks == totalChunks) &&
            (identical(other.totalSizeBytes, totalSizeBytes) ||
                other.totalSizeBytes == totalSizeBytes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tripId,
      driverId,
      source,
      startedAt,
      endedAt,
      status,
      const DeepCollectionEquality().hash(_chunkIds),
      totalChunks,
      totalSizeBytes);

  /// Create a copy of VideoSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoSessionImplCopyWith<_$VideoSessionImpl> get copyWith =>
      __$$VideoSessionImplCopyWithImpl<_$VideoSessionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String tripId,
            String driverId,
            VideoSource source,
            DateTime startedAt,
            DateTime? endedAt,
            VideoSessionStatus status,
            List<String> chunkIds,
            int totalChunks,
            int totalSizeBytes)
        $default,
  ) {
    return $default(id, tripId, driverId, source, startedAt, endedAt, status,
        chunkIds, totalChunks, totalSizeBytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String tripId,
            String driverId,
            VideoSource source,
            DateTime startedAt,
            DateTime? endedAt,
            VideoSessionStatus status,
            List<String> chunkIds,
            int totalChunks,
            int totalSizeBytes)?
        $default,
  ) {
    return $default?.call(id, tripId, driverId, source, startedAt, endedAt,
        status, chunkIds, totalChunks, totalSizeBytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String tripId,
            String driverId,
            VideoSource source,
            DateTime startedAt,
            DateTime? endedAt,
            VideoSessionStatus status,
            List<String> chunkIds,
            int totalChunks,
            int totalSizeBytes)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, tripId, driverId, source, startedAt, endedAt, status,
          chunkIds, totalChunks, totalSizeBytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoSession value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoSession value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoSession value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoSessionImplToJson(
      this,
    );
  }
}

abstract class _VideoSession extends VideoSession {
  const factory _VideoSession(
      {required final String id,
      required final String tripId,
      required final String driverId,
      required final VideoSource source,
      required final DateTime startedAt,
      final DateTime? endedAt,
      required final VideoSessionStatus status,
      final List<String> chunkIds,
      final int totalChunks,
      final int totalSizeBytes}) = _$VideoSessionImpl;
  const _VideoSession._() : super._();

  factory _VideoSession.fromJson(Map<String, dynamic> json) =
      _$VideoSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get tripId;
  @override
  String get driverId;
  @override
  VideoSource get source;
  @override
  DateTime get startedAt;
  @override
  DateTime? get endedAt;
  @override
  VideoSessionStatus get status;
  @override
  List<String> get chunkIds; // IDs de los chunks grabados
  @override
  int get totalChunks;
  @override
  int get totalSizeBytes;

  /// Create a copy of VideoSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoSessionImplCopyWith<_$VideoSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
