// lib/data/repositories/phone_camera_video_stream_repository.dart
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:camera/camera.dart';
import 'dart:io';

import '../../domain/repositories/video_stream_repository.dart';
import '../../domain/entities/video/video_chunk.dart';
import '../../core/errors/failures.dart';

/// PHASE 1: Implementación con cámara del teléfono
///
/// Esta implementación:
/// - Usa el paquete `camera` de Flutter
/// - Graba video en chunks de 10 segundos
/// - Sube cada chunk a Firebase Storage
/// - Permite al Monitor ver video en tiempo real
///
/// VENTAJAS:
/// ✅ No requiere hardware externo
/// ✅ Funciona con internet móvil del conductor
/// ✅ Setup rápido (2 semanas)
/// ✅ Costo bajo ($25/mes Firebase)
///
/// PREPARADO PARA PHASE 2:
/// Solo necesitas cambiar esta implementación por HikvisionVideoStreamRepository
/// El resto del código NO CAMBIA.
class PhoneCameraVideoStreamRepository implements VideoStreamRepository {
  // Dependencies (inyectadas por get_it)
  // Preparado para Phase 2 (upload directo a Storage)
  // ignore: unused_field
  final VideoStorageRepository _storageRepository;
  final VideoSyncRepository _syncRepository;

  // Camera controller
  CameraController? _cameraController;

  // Estado
  final Map<String, VideoSession> _activeSessions = {};
  final Map<String, StreamController<Either<Failure, VideoChunk>>>
      _streamControllers = {};
  final Map<String, StreamController<VideoStreamingStatus>> _stateControllers = {};

  // Configuración
  static const int chunkDurationSeconds = 10; // Cada chunk dura 10 segundos
  static const int maxRetries = 3;

  PhoneCameraVideoStreamRepository({
    required VideoStorageRepository storageRepository,
    required VideoSyncRepository syncRepository,
  })  : _storageRepository = storageRepository,
        _syncRepository = syncRepository;

  @override
  Future<Either<Failure, VideoSession>> initializeVideoSource({
    required String tripId,
    required String driverId,
    required VideoQuality quality,
  }) async {
    try {
      // 1. Obtener cámaras disponibles
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        return Left(CameraFailure('No hay cámaras disponibles'));
      }

      // 2. Seleccionar cámara trasera (para grabar la ruta)
      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      // 3. Inicializar controller
      _cameraController = CameraController(
        camera,
        _getResolutionPreset(quality),
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();

      // 4. Crear sesión
      final session = VideoSession(
        id: 'session_${DateTime.now().millisecondsSinceEpoch}',
        tripId: tripId,
        driverId: driverId,
        source: VideoSource.phoneCamera,
        startedAt: DateTime.now(),
        status: VideoSessionStatus.initializing,
        chunkIds: [],
        totalChunks: 0,
        totalSizeBytes: 0,
      );

      _activeSessions[session.id] = session;

      return Right(session);
    } catch (e) {
      return Left(CameraFailure('Error inicializando cámara: $e'));
    }
  }

  @override
  Stream<Either<Failure, VideoChunk>> startStreaming({
    required String sessionId,
  }) {
    // Crear stream controller si no existe
    if (!_streamControllers.containsKey(sessionId)) {
      _streamControllers[sessionId] =
          StreamController<Either<Failure, VideoChunk>>.broadcast();
    }

    // Iniciar captura de video
    _startVideoCapture(sessionId);

    return _streamControllers[sessionId]!.stream;
  }

  Future<void> _startVideoCapture(String sessionId) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _streamControllers[sessionId]!.add(
        Left(CameraFailure('Cámara no inicializada')),
      );
      return;
    }

    try {
      // Actualizar estado
      _updateStreamState(sessionId, VideoStreamingStatus.streaming);

      int chunkNumber = 0;

      // Loop infinito de grabación
      while (_streamControllers[sessionId] != null &&
          !_streamControllers[sessionId]!.isClosed) {
        try {
          // Iniciar grabación
          await _cameraController!.startVideoRecording();

          // Esperar duración del chunk
          await Future.delayed(Duration(seconds: chunkDurationSeconds));

          // Detener grabación
          final videoFile = await _cameraController!.stopVideoRecording();

          // Leer bytes del video
          final videoBytes = await File(videoFile.path).readAsBytes();

          // Crear VideoChunk
          final chunk = VideoChunk(
            id: 'chunk_${sessionId}_${chunkNumber}',
            timestamp: DateTime.now(),
            data: videoBytes,
            sequenceNumber: chunkNumber,
            metadata: VideoChunkMetadata(
              tripId: _activeSessions[sessionId]!.tripId,
              driverId: _activeSessions[sessionId]!.driverId,
              source: VideoSource.phoneCamera,
              quality: VideoQuality.medium, // TODO: Usar quality de la sesión
              durationMs: chunkDurationSeconds * 1000,
              location: null, // TODO: Obtener ubicación GPS actual
            ),
          );

          // Emitir chunk al stream
          _streamControllers[sessionId]!.add(Right(chunk));

          // Encolar para upload
          await _syncRepository.enqueueChunk(chunk: chunk);

          // Actualizar sesión
          _updateSession(sessionId, chunk);

          // Eliminar archivo temporal
          await File(videoFile.path).delete();

          chunkNumber++;
        } catch (_) {
          // No detener el streaming, continuar con el siguiente chunk
          await Future.delayed(
              Duration(seconds: 1)); // Pequeno delay antes de reintentar
        }
      }
    } catch (e) {
      _streamControllers[sessionId]!.add(
        Left(CameraFailure('Error en streaming: $e')),
      );
      _updateStreamState(sessionId, VideoStreamingStatus.error);
    }
  }

  void _updateSession(String sessionId, VideoChunk chunk) {
    final session = _activeSessions[sessionId];
    if (session != null) {
      _activeSessions[sessionId] = session.copyWith(
        chunkIds: [...session.chunkIds, chunk.id],
        totalChunks: session.totalChunks + 1,
        totalSizeBytes: session.totalSizeBytes + chunk.sizeInBytes,
        status: VideoSessionStatus.recording,
      );
    }
  }

  void _updateStreamState(String sessionId, VideoStreamingStatus state) {
    if (!_stateControllers.containsKey(sessionId)) {
      _stateControllers[sessionId] =
          StreamController<VideoStreamingStatus>.broadcast();
    }
    _stateControllers[sessionId]!.add(state);
  }

  @override
  Future<Either<Failure, void>> pauseStreaming({
    required String sessionId,
  }) async {
    try {
      if (_cameraController != null &&
          _cameraController!.value.isRecordingVideo) {
        await _cameraController!.pauseVideoRecording();
        _updateStreamState(sessionId, VideoStreamingStatus.paused);
      }
      return const Right(null);
    } catch (e) {
      return Left(CameraFailure('Error pausando: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> resumeStreaming({
    required String sessionId,
  }) async {
    try {
      if (_cameraController != null &&
          _cameraController!.value.isRecordingPaused) {
        await _cameraController!.resumeVideoRecording();
        _updateStreamState(sessionId, VideoStreamingStatus.streaming);
      }
      return const Right(null);
    } catch (e) {
      return Left(CameraFailure('Error reanudando: $e'));
    }
  }

  @override
  Future<Either<Failure, VideoSession>> stopStreaming({
    required String sessionId,
  }) async {
    try {
      // Cerrar stream
      await _streamControllers[sessionId]?.close();
      _streamControllers.remove(sessionId);

      // Cerrar state stream
      await _stateControllers[sessionId]?.close();
      _stateControllers.remove(sessionId);

      // Detener cámara si está grabando
      if (_cameraController != null &&
          _cameraController!.value.isRecordingVideo) {
        await _cameraController!.stopVideoRecording();
      }

      // Finalizar sesión
      final session = _activeSessions[sessionId];
      if (session != null) {
        final finalSession = session.copyWith(
          endedAt: DateTime.now(),
          status: VideoSessionStatus.completed,
        );
        _activeSessions.remove(sessionId);
        return Right(finalSession);
      }

      return Left(CameraFailure('Sesión no encontrada'));
    } catch (e) {
      return Left(CameraFailure('Error deteniendo: $e'));
    }
  }

  @override
  Future<Either<Failure, VideoSession>> getVideoSession({
    required String sessionId,
  }) async {
    final session = _activeSessions[sessionId];
    if (session != null) {
      return Right(session);
    }
    return Left(CameraFailure('Sesión no encontrada'));
  }

  @override
  Future<Either<Failure, List<VideoSession>>> getVideoSessionsByTrip({
    required String tripId,
  }) async {
    final sessions = _activeSessions.values
        .where((session) => session.tripId == tripId)
        .toList();
    return Right(sessions);
  }

  @override
  Future<Either<Failure, void>> changeVideoQuality({
    required String sessionId,
    required VideoQuality quality,
  }) async {
    // TODO: Implementar cambio de calidad en tiempo real
    // Requiere reiniciar el CameraController con nuevo ResolutionPreset
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> switchVideoSource({
    required String sessionId,
    required VideoSource source,
  }) async {
    // En Phase 1, solo tenemos phone camera
    // En Phase 2, aquí cambiaríamos entre Hikvision y phone
    return Left(CameraFailure('Cambio de fuente no disponible en Phase 1'));
  }

  @override
  Future<Either<Failure, bool>> isVideoSourceAvailable({
    required VideoSource source,
  }) async {
    if (source == VideoSource.phoneCamera) {
      final cameras = await availableCameras();
      return Right(cameras.isNotEmpty);
    }
    return const Right(false);
  }

  @override
  Stream<VideoStreamingStatus> getStreamingState({
    required String sessionId,
  }) {
    if (!_stateControllers.containsKey(sessionId)) {
      _stateControllers[sessionId] =
          StreamController<VideoStreamingStatus>.broadcast();
    }
    return _stateControllers[sessionId]!.stream;
  }

  // Helper: Convertir VideoQuality a ResolutionPreset
  ResolutionPreset _getResolutionPreset(VideoQuality quality) {
    switch (quality) {
      case VideoQuality.low:
        return ResolutionPreset.medium; // 480p
      case VideoQuality.medium:
        return ResolutionPreset.high; // 720p
      case VideoQuality.high:
        return ResolutionPreset.veryHigh; // 1080p
      case VideoQuality.auto:
        return ResolutionPreset.high; // Default 720p
    }
  }

  // Cleanup
  Future<void> dispose() async {
    // Cerrar todos los streams
    for (var controller in _streamControllers.values) {
      await controller.close();
    }
    for (var controller in _stateControllers.values) {
      await controller.close();
    }

    // Dispose camera controller
    await _cameraController?.dispose();

    _streamControllers.clear();
    _stateControllers.clear();
    _activeSessions.clear();
  }
}

/// Custom failure para cámara
class CameraFailure extends Failure {
  CameraFailure(String message) : super(message);
}
