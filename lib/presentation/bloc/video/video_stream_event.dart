// lib/presentation/bloc/video/video_stream_event.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_stream_event.freezed.dart';

/// Eventos del VideoStreamBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class VideoStreamEvent with _$VideoStreamEvent {
  /// Evento para inicializar la fuente de video
  const factory VideoStreamEvent.initialize({
    required String tripId,
    required String driverId,
  }) = InitializeVideoEvent;

  /// Evento para iniciar el streaming de video
  const factory VideoStreamEvent.startStreaming({
    required String sessionId,
  }) = StartStreamingEvent;

  /// Evento para detener el streaming de video
  const factory VideoStreamEvent.stopStreaming({
    required String sessionId,
  }) = StopStreamingEvent;

  /// Evento interno para actualizar estadisticas de chunks
  /// (No debe ser disparado externamente)
  const factory VideoStreamEvent.chunkUploaded({
    required String sessionId,
    required int chunkSize,
  }) = ChunkUploadedEvent;
}
