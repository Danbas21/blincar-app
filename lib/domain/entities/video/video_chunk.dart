// lib/domain/entities/video/video_chunk.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../value_objects/coordinates.dart';

part 'video_chunk.freezed.dart';
part 'video_chunk.g.dart';

/// Fuente del video
enum VideoSource {
  phoneCamera, // Phase 1: Camara del telefono
  hikvision4G, // Phase 2: Hikvision con 4G
  phoneBackup, // Backup: telefono cuando Hikvision falla
  unknown,
}

extension VideoSourceX on VideoSource {
  String get displayName {
    switch (this) {
      case VideoSource.phoneCamera:
        return 'Camara del Telefono';
      case VideoSource.hikvision4G:
        return 'Hikvision 4G';
      case VideoSource.phoneBackup:
        return 'Telefono (Backup)';
      case VideoSource.unknown:
        return 'Desconocido';
    }
  }

  bool get isPrimary {
    return this == VideoSource.phoneCamera || this == VideoSource.hikvision4G;
  }
}

/// Calidad del video
enum VideoQuality {
  low, // 480p - para conexiones lentas
  medium, // 720p - balance calidad/ancho de banda
  high, // 1080p - maxima calidad
  auto, // Ajusta automaticamente segun conexion
}

extension VideoQualityX on VideoQuality {
  String get displayName {
    switch (this) {
      case VideoQuality.low:
        return '480p (Economico)';
      case VideoQuality.medium:
        return '720p (Recomendado)';
      case VideoQuality.high:
        return '1080p (Alta Calidad)';
      case VideoQuality.auto:
        return 'Automatico';
    }
  }

  int get width {
    switch (this) {
      case VideoQuality.low:
        return 640;
      case VideoQuality.medium:
        return 1280;
      case VideoQuality.high:
        return 1920;
      case VideoQuality.auto:
        return 1280;
    }
  }

  int get height {
    switch (this) {
      case VideoQuality.low:
        return 480;
      case VideoQuality.medium:
        return 720;
      case VideoQuality.high:
        return 1080;
      case VideoQuality.auto:
        return 720;
    }
  }

  int get bitrate {
    switch (this) {
      case VideoQuality.low:
        return 500000; // 500 kbps
      case VideoQuality.medium:
        return 1500000; // 1.5 Mbps
      case VideoQuality.high:
        return 3000000; // 3 Mbps
      case VideoQuality.auto:
        return 1500000;
    }
  }
}

/// Estado del streaming de video (enum de dominio)
///
/// Nota: Diferente de VideoStreamState (BLoC state).
/// Este enum representa el estado tecnico del streaming.
enum VideoStreamingStatus {
  idle, // No hay streaming
  initializing, // Inicializando camara
  streaming, // Streaming activo
  paused, // Pausado
  stopped, // Detenido
  error, // Error
  reconnecting, // Reconectando
}

/// Estado de una sesion de video
enum VideoSessionStatus {
  initializing,
  recording,
  paused,
  completed,
  failed,
}

/// Metadata del chunk de video
@freezed
class VideoChunkMetadata with _$VideoChunkMetadata {
  const VideoChunkMetadata._();

  const factory VideoChunkMetadata({
    required String tripId,
    required String driverId,
    required VideoSource source,
    required VideoQuality quality,
    required int durationMs, // Duracion del chunk en milisegundos
    Coordinates? location, // Ubicacion GPS cuando se grabo
  }) = _VideoChunkMetadata;

  factory VideoChunkMetadata.fromJson(Map<String, dynamic> json) =>
      _$VideoChunkMetadataFromJson(json);

  /// Duracion en segundos
  double get durationSeconds => durationMs / 1000;
}

/// Representa un fragmento de video
///
/// IMPORTANTE: Esta entidad NO sabe de donde viene el video:
/// - Puede ser telefono (Phase 1)
/// - Puede ser Hikvision 4G (Phase 2)
/// - Puede ser otra camara (futuro)
///
/// El dominio solo dice: "Dame bytes de video"
@freezed
class VideoChunk with _$VideoChunk {
  const VideoChunk._();

  const factory VideoChunk({
    required String id,
    required DateTime timestamp,
    required List<int> data, // Bytes del video
    required int sequenceNumber,
    required VideoChunkMetadata metadata,
  }) = _VideoChunk;

  factory VideoChunk.fromJson(Map<String, dynamic> json) =>
      _$VideoChunkFromJson(json);

  /// Tamano en bytes
  int get sizeInBytes => data.length;

  /// Tamano en KB
  double get sizeInKB => sizeInBytes / 1024;

  /// Tamano en MB
  double get sizeInMB => sizeInKB / 1024;

  /// Tamano formateado
  String get formattedSize {
    if (sizeInMB >= 1) return '${sizeInMB.toStringAsFixed(2)} MB';
    if (sizeInKB >= 1) return '${sizeInKB.toStringAsFixed(2)} KB';
    return '$sizeInBytes bytes';
  }
}

/// Sesion de grabacion de video
@freezed
class VideoSession with _$VideoSession {
  const VideoSession._();

  const factory VideoSession({
    required String id,
    required String tripId,
    required String driverId,
    required VideoSource source,
    required DateTime startedAt,
    DateTime? endedAt,
    required VideoSessionStatus status,
    @Default([]) List<String> chunkIds, // IDs de los chunks grabados
    @Default(0) int totalChunks,
    @Default(0) int totalSizeBytes,
  }) = _VideoSession;

  factory VideoSession.fromJson(Map<String, dynamic> json) =>
      _$VideoSessionFromJson(json);

  /// Duracion de la sesion
  Duration get duration {
    final end = endedAt ?? DateTime.now();
    return end.difference(startedAt);
  }

  /// Tamano total en MB
  double get totalSizeMB => totalSizeBytes / (1024 * 1024);

  /// Si la sesion esta activa
  bool get isActive => status == VideoSessionStatus.recording;

  /// Si la sesion esta completada
  bool get isCompleted => status == VideoSessionStatus.completed;

  /// Si la sesion fallo
  bool get isFailed => status == VideoSessionStatus.failed;

  /// Duracion formateada
  String get formattedDuration {
    final d = duration;
    if (d.inHours > 0) {
      return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    }
    if (d.inMinutes > 0) {
      return '${d.inMinutes}m ${d.inSeconds.remainder(60)}s';
    }
    return '${d.inSeconds}s';
  }
}
