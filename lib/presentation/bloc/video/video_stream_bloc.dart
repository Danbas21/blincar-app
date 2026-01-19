// lib/presentation/bloc/video/video_stream_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/video_stream_repository.dart';
import '../../../domain/entities/video/video_chunk.dart';
import 'video_stream_event.dart';
import 'video_stream_state.dart';

/// BLoC para manejar el streaming de video durante viajes
///
/// Responsable de:
/// - Inicializar la fuente de video (camara del telefono o Hikvision)
/// - Controlar el inicio/pausa/detencion del streaming
/// - Trackear estadisticas de chunks subidos
class VideoStreamBloc extends Bloc<VideoStreamEvent, VideoStreamState> {
  final VideoStreamRepository _repository;
  StreamSubscription? _streamSubscription;

  int _chunksUploaded = 0;
  int _totalSizeBytes = 0;

  VideoStreamBloc({required VideoStreamRepository repository})
      : _repository = repository,
        super(const VideoStreamState.initial()) {
    on<InitializeVideoEvent>(_onInitialize);
    on<StartStreamingEvent>(_onStartStreaming);
    on<StopStreamingEvent>(_onStopStreaming);
    on<ChunkUploadedEvent>(_onChunkUploaded);
  }

  Future<void> _onInitialize(
    InitializeVideoEvent event,
    Emitter<VideoStreamState> emit,
  ) async {
    emit(const VideoStreamState.initializing());

    final result = await _repository.initializeVideoSource(
      tripId: event.tripId,
      driverId: event.driverId,
      quality: VideoQuality.medium,
    );

    result.fold(
      (failure) => emit(VideoStreamState.error(message: failure.message)),
      (session) => emit(VideoStreamState.ready(sessionId: session.id)),
    );
  }

  Future<void> _onStartStreaming(
    StartStreamingEvent event,
    Emitter<VideoStreamState> emit,
  ) async {
    // Reset counters
    _chunksUploaded = 0;
    _totalSizeBytes = 0;

    emit(VideoStreamState.active(
      sessionId: event.sessionId,
      chunksUploaded: 0,
      totalSizeMB: 0,
    ));

    // Escuchar stream de chunks
    _streamSubscription = _repository
        .startStreaming(sessionId: event.sessionId)
        .listen((result) {
      result.fold(
        (failure) {
          // Error en chunk, pero continuar streaming
        },
        (chunk) {
          // Chunk subido exitosamente - usar evento interno para actualizar
          add(VideoStreamEvent.chunkUploaded(
            sessionId: event.sessionId,
            chunkSize: chunk.sizeInBytes,
          ));
        },
      );
    });
  }

  /// Handler para actualizaciones de chunks (evento interno)
  Future<void> _onChunkUploaded(
    ChunkUploadedEvent event,
    Emitter<VideoStreamState> emit,
  ) async {
    _chunksUploaded++;
    _totalSizeBytes += event.chunkSize;

    emit(VideoStreamState.active(
      sessionId: event.sessionId,
      chunksUploaded: _chunksUploaded,
      totalSizeMB: (_totalSizeBytes / (1024 * 1024)).round(),
    ));
  }

  Future<void> _onStopStreaming(
    StopStreamingEvent event,
    Emitter<VideoStreamState> emit,
  ) async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;

    final result = await _repository.stopStreaming(sessionId: event.sessionId);

    result.fold(
      (failure) => emit(VideoStreamState.error(message: failure.message)),
      (session) => emit(VideoStreamState.stopped(
        totalChunks: session.totalChunks,
        totalSizeMB: session.totalSizeMB.round(),
      )),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
