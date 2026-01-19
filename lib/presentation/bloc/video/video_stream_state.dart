// lib/presentation/bloc/video/video_stream_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_stream_state.freezed.dart';

/// Estados del VideoStreamBloc
///
/// Usa sealed class pattern con Freezed para type-safety
/// y pattern matching exhaustivo.
@Freezed(toJson: false, fromJson: false)
sealed class VideoStreamState with _$VideoStreamState {
  /// Estado inicial - sin streaming
  const factory VideoStreamState.initial() = VideoStreamInitial;

  /// Estado de inicializacion - preparando camara
  const factory VideoStreamState.initializing() = VideoStreamInitializing;

  /// Estado listo para iniciar streaming
  const factory VideoStreamState.ready({
    required String sessionId,
  }) = VideoStreamReady;

  /// Estado activo - streaming en progreso
  const factory VideoStreamState.active({
    required String sessionId,
    required int chunksUploaded,
    required int totalSizeMB,
  }) = VideoStreamActive;

  /// Estado detenido - streaming finalizado
  const factory VideoStreamState.stopped({
    required int totalChunks,
    required int totalSizeMB,
  }) = VideoStreamStopped;

  /// Estado de error
  const factory VideoStreamState.error({
    required String message,
  }) = VideoStreamError;
}
