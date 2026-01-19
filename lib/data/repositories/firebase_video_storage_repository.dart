// lib/data/repositories/firebase_video_storage_repository.dart
import 'dart:async';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../domain/repositories/video_stream_repository.dart';
import '../../domain/entities/video/video_chunk.dart';
import '../../core/errors/failures.dart';

/// Implementación de almacenamiento en Firebase Storage
///
/// Estructura en Firebase Storage:
/// /videos
///   /{tripId}
///     /{sessionId}
///       /chunk_0.mp4
///       /chunk_1.mp4
///       /chunk_2.mp4
///       ...
///
/// Metadata en Realtime Database:
/// /blincar/videoSessions/{sessionId}
///   /chunks
///     /chunk_0: { uploadedAt, sizeBytes, sequenceNumber, downloadUrl }
class FirebaseVideoStorageRepository implements VideoStorageRepository {
  final FirebaseStorage _storage;
  final FirebaseDatabase _database;

  // Stream controllers para watch
  final Map<String, StreamController<Either<Failure, VideoChunk>>>
      _watchControllers = {};

  FirebaseVideoStorageRepository({
    FirebaseStorage? storage,
    FirebaseDatabase? database,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _database = database ?? FirebaseDatabase.instance;

  @override
  Future<Either<Failure, String>> uploadVideoChunk({
    required VideoChunk chunk,
  }) async {
    try {
      // 1. Path en Storage
      final storagePath = _getChunkStoragePath(chunk);
      final storageRef = _storage.ref(storagePath);

      // 2. Metadata
      final metadata = SettableMetadata(
        contentType: 'video/mp4',
        customMetadata: {
          'tripId': chunk.metadata.tripId,
          'driverId': chunk.metadata.driverId,
          'sequenceNumber': chunk.sequenceNumber.toString(),
          'timestamp': chunk.timestamp.toIso8601String(),
          'source': chunk.metadata.source.name,
        },
      );

      // 3. Upload con progress tracking
      final uploadTask = storageRef.putData(Uint8List.fromList(chunk.data), metadata);

      // Escuchar progreso (opcional)
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        // Progress tracking silencioso
      });

      // Esperar a que termine
      final taskSnapshot = await uploadTask;

      // 4. Obtener download URL
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // 5. Guardar metadata en Realtime Database
      await _saveChunkMetadata(chunk, downloadUrl);

      // 6. Notificar a watchers
      _notifyWatchers(chunk);

      return Right(downloadUrl);
    } on FirebaseException catch (e) {
      return Left(StorageFailure('Error subiendo chunk: ${e.message}'));
    } catch (e) {
      return Left(StorageFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, VideoChunk>> downloadVideoChunk({
    required String chunkId,
  }) async {
    try {
      // 1. Obtener metadata de Realtime Database
      final metadataRef = _database.ref('blincar/videoChunks/$chunkId');
      final metadataSnapshot = await metadataRef.get();

      if (!metadataSnapshot.exists) {
        return Left(StorageFailure('Chunk no encontrado'));
      }

      final metadataMap =
          Map<String, dynamic>.from(metadataSnapshot.value as Map);

      // 2. Download desde Storage
      final storagePath = metadataMap['storagePath'] as String;
      final storageRef = _storage.ref(storagePath);
      final data = await storageRef.getData();

      if (data == null) {
        return Left(StorageFailure('Error descargando datos'));
      }

      // 3. Reconstruir VideoChunk
      final chunk = VideoChunk(
        id: chunkId,
        timestamp: DateTime.parse(metadataMap['timestamp'] as String),
        data: data,
        sequenceNumber: metadataMap['sequenceNumber'] as int,
        metadata: VideoChunkMetadata(
          tripId: metadataMap['tripId'] as String,
          driverId: metadataMap['driverId'] as String,
          source: _parseVideoSource(metadataMap['source'] as String),
          quality: VideoQuality.medium, // TODO: Guardar y recuperar quality
          durationMs: metadataMap['durationMs'] as int,
          location: null, // TODO: Guardar y recuperar location
        ),
      );

      return Right(chunk);
    } on FirebaseException catch (e) {
      return Left(StorageFailure('Error descargando: ${e.message}'));
    } catch (e) {
      return Left(StorageFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> getVideoChunkUrl({
    required String chunkId,
  }) async {
    try {
      // Obtener URL directamente desde metadata
      final metadataRef =
          _database.ref('blincar/videoChunks/$chunkId/downloadUrl');
      final snapshot = await metadataRef.get();

      if (snapshot.exists) {
        return Right(snapshot.value as String);
      }

      return Left(StorageFailure('URL no encontrada'));
    } catch (e) {
      return Left(StorageFailure('Error obteniendo URL: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVideoSession({
    required String sessionId,
  }) async {
    try {
      // 1. Obtener lista de chunks
      final chunksResult = await listVideoChunks(sessionId: sessionId);

      return chunksResult.fold(
        (failure) => Left(failure),
        (chunkIds) async {
          // 2. Eliminar cada chunk
          for (final chunkId in chunkIds) {
            // Eliminar de Storage
            final metadataRef = _database.ref('blincar/videoChunks/$chunkId');
            final metadataSnapshot = await metadataRef.get();

            if (metadataSnapshot.exists) {
              final metadata =
                  Map<String, dynamic>.from(metadataSnapshot.value as Map);
              final storagePath = metadata['storagePath'] as String;
              await _storage.ref(storagePath).delete();
            }

            // Eliminar metadata
            await metadataRef.remove();
          }

          // 3. Eliminar metadata de sesión
          await _database.ref('blincar/videoSessions/$sessionId').remove();

          return const Right(null);
        },
      );
    } on FirebaseException catch (e) {
      return Left(StorageFailure('Error eliminando: ${e.message}'));
    } catch (e) {
      return Left(StorageFailure('Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, VideoSession>> getVideoSessionMetadata({
    required String sessionId,
  }) async {
    try {
      final sessionRef = _database.ref('blincar/videoSessions/$sessionId');
      final snapshot = await sessionRef.get();

      if (!snapshot.exists) {
        return Left(StorageFailure('Sesión no encontrada'));
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);

      final session = VideoSession(
        id: sessionId,
        tripId: data['tripId'] as String,
        driverId: data['driverId'] as String,
        source: _parseVideoSource(data['source'] as String),
        startedAt: DateTime.parse(data['startedAt'] as String),
        endedAt: data['endedAt'] != null
            ? DateTime.parse(data['endedAt'] as String)
            : null,
        status: _parseSessionStatus(data['status'] as String),
        chunkIds: List<String>.from(data['chunkIds'] ?? []),
        totalChunks: data['totalChunks'] as int,
        totalSizeBytes: data['totalSizeBytes'] as int,
      );

      return Right(session);
    } catch (e) {
      return Left(StorageFailure('Error obteniendo metadata: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> listVideoChunks({
    required String sessionId,
  }) async {
    try {
      final chunksRef =
          _database.ref('blincar/videoSessions/$sessionId/chunkIds');
      final snapshot = await chunksRef.get();

      if (!snapshot.exists) {
        return const Right([]);
      }

      final chunkIds = List<String>.from(snapshot.value as List);
      return Right(chunkIds);
    } catch (e) {
      return Left(StorageFailure('Error listando chunks: $e'));
    }
  }

  @override
  Stream<Either<Failure, VideoChunk>> watchVideoChunks({
    required String sessionId,
  }) {
    // Crear stream controller si no existe
    if (!_watchControllers.containsKey(sessionId)) {
      _watchControllers[sessionId] =
          StreamController<Either<Failure, VideoChunk>>.broadcast();
      _startWatching(sessionId);
    }

    return _watchControllers[sessionId]!.stream;
  }

  void _startWatching(String sessionId) {
    // Escuchar cambios en la lista de chunks
    final chunksRef =
        _database.ref('blincar/videoSessions/$sessionId/chunkIds');

    chunksRef.onChildAdded.listen((event) async {
      final chunkId = event.snapshot.value as String;

      // Descargar chunk
      final result = await downloadVideoChunk(chunkId: chunkId);

      // Emitir al stream
      _watchControllers[sessionId]?.add(result);
    });
  }

  void _notifyWatchers(VideoChunk chunk) {
    // Buscar watchers de esta sesión
    for (final entry in _watchControllers.entries) {
      if (entry.key.contains(chunk.metadata.tripId)) {
        entry.value.add(Right(chunk));
      }
    }
  }

  Future<void> _saveChunkMetadata(VideoChunk chunk, String downloadUrl) async {
    // Guardar en /blincar/videoChunks/{chunkId}
    await _database.ref('blincar/videoChunks/${chunk.id}').set({
      'tripId': chunk.metadata.tripId,
      'driverId': chunk.metadata.driverId,
      'sequenceNumber': chunk.sequenceNumber,
      'timestamp': chunk.timestamp.toIso8601String(),
      'source': chunk.metadata.source.name,
      'sizeBytes': chunk.sizeInBytes,
      'durationMs': chunk.metadata.durationMs,
      'downloadUrl': downloadUrl,
      'storagePath': _getChunkStoragePath(chunk),
      'uploadedAt': ServerValue.timestamp,
    });

    // Agregar a la lista de chunks de la sesión
    // (Esto triggerea el watcher en Monitor)
    final sessionId =
        'session_${chunk.metadata.tripId}'; // TODO: Usar sessionId real
    await _database
        .ref('blincar/videoSessions/$sessionId/chunkIds')
        .push()
        .set(chunk.id);
  }

  String _getChunkStoragePath(VideoChunk chunk) {
    final tripId = chunk.metadata.tripId;
    final sessionId = 'session_$tripId'; // TODO: Usar sessionId real
    return 'videos/$tripId/$sessionId/${chunk.id}.mp4';
  }

  VideoSource _parseVideoSource(String source) {
    return VideoSource.values.firstWhere(
      (s) => s.name == source,
      orElse: () => VideoSource.unknown,
    );
  }

  VideoSessionStatus _parseSessionStatus(String status) {
    return VideoSessionStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => VideoSessionStatus.failed,
    );
  }

  Future<void> dispose() async {
    for (var controller in _watchControllers.values) {
      await controller.close();
    }
    _watchControllers.clear();
  }
}

class StorageFailure extends Failure {
  StorageFailure(String message) : super(message);
}
