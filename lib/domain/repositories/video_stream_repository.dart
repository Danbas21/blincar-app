// lib/domain/repositories/video_stream_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/video/video_chunk.dart';
import '../../core/errors/failures.dart';

/// Repository para video streaming
///
/// PRINCIPIO CLAVE: Dependency Inversion
///
/// El dominio define QUÉ necesita, NO CÓMO se implementa.
///
/// Esta interface NO sabe:
/// - Si el video viene del teléfono o Hikvision
/// - Cómo se captura el video
/// - Dónde se almacena (Firebase, S3, etc.)
/// - Qué librería se usa (camera, rtsp, etc.)
///
/// Solo dice: "Dame un stream de VideoChunk"
///
/// La implementación concreta (en la capa DATA) decide el CÓMO.
abstract class VideoStreamRepository {
  /// Inicializar fuente de video
  ///
  /// Phase 1: Inicializa cámara del teléfono
  /// Phase 2: Inicializa conexión con Hikvision 4G
  Future<Either<Failure, VideoSession>> initializeVideoSource({
    required String tripId,
    required String driverId,
    required VideoQuality quality,
  });

  /// Iniciar streaming de video
  ///
  /// Comienza a capturar y enviar chunks de video.
  ///
  /// El stream emite:
  /// - Right(VideoChunk) cuando hay un nuevo chunk
  /// - Left(Failure) cuando hay un error
  ///
  /// IMPORTANTE: Este stream NO se cierra hasta llamar stopStreaming()
  Stream<Either<Failure, VideoChunk>> startStreaming({
    required String sessionId,
  });

  /// Pausar streaming
  ///
  /// Detiene temporalmente la captura, pero mantiene la sesión activa.
  Future<Either<Failure, void>> pauseStreaming({
    required String sessionId,
  });

  /// Reanudar streaming
  Future<Either<Failure, void>> resumeStreaming({
    required String sessionId,
  });

  /// Detener streaming
  ///
  /// Finaliza la captura y cierra la sesión.
  Future<Either<Failure, VideoSession>> stopStreaming({
    required String sessionId,
  });

  /// Obtener sesión de video
  Future<Either<Failure, VideoSession>> getVideoSession({
    required String sessionId,
  });

  /// Obtener todas las sesiones de un viaje
  Future<Either<Failure, List<VideoSession>>> getVideoSessionsByTrip({
    required String tripId,
  });

  /// Cambiar calidad del video en tiempo real
  Future<Either<Failure, void>> changeVideoQuality({
    required String sessionId,
    required VideoQuality quality,
  });

  /// Cambiar fuente de video (para fallback)
  ///
  /// Phase 2: Si Hikvision falla, cambiar a teléfono
  Future<Either<Failure, void>> switchVideoSource({
    required String sessionId,
    required VideoSource source,
  });

  /// Verificar si la fuente de video está disponible
  Future<Either<Failure, bool>> isVideoSourceAvailable({
    required VideoSource source,
  });

  /// Obtener estado actual del streaming
  Stream<VideoStreamingStatus> getStreamingState({
    required String sessionId,
  });
}

/// Repository para almacenamiento de video
///
/// Separado de VideoStreamRepository por Single Responsibility Principle.
///
/// VideoStreamRepository: Captura y envía video
/// VideoStorageRepository: Almacena y recupera video
abstract class VideoStorageRepository {
  /// Subir chunk de video a storage
  ///
  /// Phase 1: Firebase Storage
  /// Phase 2: Podría ser S3, Azure, etc.
  Future<Either<Failure, String>> uploadVideoChunk({
    required VideoChunk chunk,
  });

  /// Descargar chunk de video
  Future<Either<Failure, VideoChunk>> downloadVideoChunk({
    required String chunkId,
  });

  /// Obtener URL de descarga de un chunk
  ///
  /// Para que el Monitor Web pueda ver el video sin descargarlo completo
  Future<Either<Failure, String>> getVideoChunkUrl({
    required String chunkId,
  });

  /// Eliminar chunks de video de una sesión
  Future<Either<Failure, void>> deleteVideoSession({
    required String sessionId,
  });

  /// Obtener metadata de una sesión sin descargar el video
  Future<Either<Failure, VideoSession>> getVideoSessionMetadata({
    required String sessionId,
  });

  /// Listar todos los chunks de una sesión
  Future<Either<Failure, List<String>>> listVideoChunks({
    required String sessionId,
  });

  /// Stream de chunks en tiempo real (para Monitor)
  ///
  /// El Monitor escucha este stream y va recibiendo chunks
  /// a medida que el Driver los sube.
  Stream<Either<Failure, VideoChunk>> watchVideoChunks({
    required String sessionId,
  });
}

/// Repository para sincronización de video
///
/// Maneja la lógica de upload en background, reintentos, etc.
abstract class VideoSyncRepository {
  /// Encolar chunk para upload
  ///
  /// Si no hay internet, se guarda localmente y se sube después.
  Future<Either<Failure, void>> enqueueChunk({
    required VideoChunk chunk,
  });

  /// Obtener chunks pendientes de subir
  Future<Either<Failure, List<VideoChunk>>> getPendingChunks();

  /// Procesar cola de upload
  ///
  /// Sube todos los chunks pendientes cuando haya conexión.
  Future<Either<Failure, int>> processPendingChunks();

  /// Cancelar uploads pendientes
  Future<Either<Failure, void>> cancelPendingUploads({
    required String sessionId,
  });

  /// Estado de sincronización
  Stream<VideoSyncState> getSyncState();
}

/// Estado de sincronización
enum VideoSyncState {
  idle, // No hay nada que sincronizar
  syncing, // Sincronizando
  paused, // Pausado (sin conexión)
  error, // Error de sincronización
}
