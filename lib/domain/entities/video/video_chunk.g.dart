// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_chunk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoChunkMetadataImpl _$$VideoChunkMetadataImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$VideoChunkMetadataImpl',
      json,
      ($checkedConvert) {
        final val = _$VideoChunkMetadataImpl(
          tripId: $checkedConvert('tripId', (v) => v as String),
          driverId: $checkedConvert('driverId', (v) => v as String),
          source: $checkedConvert(
              'source', (v) => $enumDecode(_$VideoSourceEnumMap, v)),
          quality: $checkedConvert(
              'quality', (v) => $enumDecode(_$VideoQualityEnumMap, v)),
          durationMs: $checkedConvert('durationMs', (v) => (v as num).toInt()),
          location: $checkedConvert(
              'location',
              (v) => v == null
                  ? null
                  : Coordinates.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$VideoChunkMetadataImplToJson(
        _$VideoChunkMetadataImpl instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'driverId': instance.driverId,
      'source': _$VideoSourceEnumMap[instance.source]!,
      'quality': _$VideoQualityEnumMap[instance.quality]!,
      'durationMs': instance.durationMs,
      'location': instance.location?.toJson(),
    };

const _$VideoSourceEnumMap = {
  VideoSource.phoneCamera: 'phoneCamera',
  VideoSource.hikvision4G: 'hikvision4G',
  VideoSource.phoneBackup: 'phoneBackup',
  VideoSource.unknown: 'unknown',
};

const _$VideoQualityEnumMap = {
  VideoQuality.low: 'low',
  VideoQuality.medium: 'medium',
  VideoQuality.high: 'high',
  VideoQuality.auto: 'auto',
};

_$VideoChunkImpl _$$VideoChunkImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$VideoChunkImpl',
      json,
      ($checkedConvert) {
        final val = _$VideoChunkImpl(
          id: $checkedConvert('id', (v) => v as String),
          timestamp:
              $checkedConvert('timestamp', (v) => DateTime.parse(v as String)),
          data: $checkedConvert(
              'data',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          sequenceNumber:
              $checkedConvert('sequenceNumber', (v) => (v as num).toInt()),
          metadata: $checkedConvert('metadata',
              (v) => VideoChunkMetadata.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$VideoChunkImplToJson(_$VideoChunkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
      'sequenceNumber': instance.sequenceNumber,
      'metadata': instance.metadata.toJson(),
    };

_$VideoSessionImpl _$$VideoSessionImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$VideoSessionImpl',
      json,
      ($checkedConvert) {
        final val = _$VideoSessionImpl(
          id: $checkedConvert('id', (v) => v as String),
          tripId: $checkedConvert('tripId', (v) => v as String),
          driverId: $checkedConvert('driverId', (v) => v as String),
          source: $checkedConvert(
              'source', (v) => $enumDecode(_$VideoSourceEnumMap, v)),
          startedAt:
              $checkedConvert('startedAt', (v) => DateTime.parse(v as String)),
          endedAt: $checkedConvert(
              'endedAt', (v) => v == null ? null : DateTime.parse(v as String)),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$VideoSessionStatusEnumMap, v)),
          chunkIds: $checkedConvert(
              'chunkIds',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          totalChunks:
              $checkedConvert('totalChunks', (v) => (v as num?)?.toInt() ?? 0),
          totalSizeBytes: $checkedConvert(
              'totalSizeBytes', (v) => (v as num?)?.toInt() ?? 0),
        );
        return val;
      },
    );

Map<String, dynamic> _$$VideoSessionImplToJson(_$VideoSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'driverId': instance.driverId,
      'source': _$VideoSourceEnumMap[instance.source]!,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'status': _$VideoSessionStatusEnumMap[instance.status]!,
      'chunkIds': instance.chunkIds,
      'totalChunks': instance.totalChunks,
      'totalSizeBytes': instance.totalSizeBytes,
    };

const _$VideoSessionStatusEnumMap = {
  VideoSessionStatus.initializing: 'initializing',
  VideoSessionStatus.recording: 'recording',
  VideoSessionStatus.paused: 'paused',
  VideoSessionStatus.completed: 'completed',
  VideoSessionStatus.failed: 'failed',
};
