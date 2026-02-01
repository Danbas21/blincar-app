// lib/core/services/document_service.dart

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

/// Servicio para manejar documentos del usuario
///
/// Funcionalidades:
/// - Capturar fotos de documentos
/// - Seleccionar archivos del dispositivo
/// - Subir documentos a Firebase Storage
/// - Obtener URLs de documentos
class DocumentService {
  final FirebaseStorage _storage;
  final ImagePicker _imagePicker;

  DocumentService({
    FirebaseStorage? storage,
    ImagePicker? imagePicker,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _imagePicker = imagePicker ?? ImagePicker();

  /// Toma una foto con la cámara
  ///
  /// Retorna el File de la imagen capturada o null si se cancela
  Future<File?> takePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (photo == null) {
        _debugLog('Photo capture cancelled');
        return null;
      }

      _debugLog('Photo captured: ${photo.path}');
      return File(photo.path);
    } catch (e) {
      _debugLog('Error taking photo: $e');
      return null;
    }
  }

  /// Selecciona una imagen de la galería
  ///
  /// Retorna el File de la imagen o null si se cancela
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image == null) {
        _debugLog('Image selection cancelled');
        return null;
      }

      _debugLog('Image selected: ${image.path}');
      return File(image.path);
    } catch (e) {
      _debugLog('Error picking image: $e');
      return null;
    }
  }

  /// Sube un documento a Firebase Storage
  ///
  /// [file] - Archivo a subir
  /// [userId] - ID del usuario
  /// [documentType] - Tipo de documento (personal, license, vehicle, insurance)
  /// [documentName] - Nombre del documento (ej: INE, CURP, etc)
  ///
  /// Retorna el resultado de la subida con la URL o error
  Future<DocumentUploadResult> uploadDocument({
    required File file,
    required String userId,
    required String documentType,
    required String documentName,
  }) async {
    try {
      // Generar nombre único para el archivo
      final extension = path.extension(file.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName =
          '${documentName.replaceAll(' ', '_')}_$timestamp$extension';

      // Ruta en Storage: documents/{userId}/{documentType}/{fileName}
      final storagePath = 'documents/$userId/$documentType/$fileName';
      final ref = _storage.ref().child(storagePath);

      _debugLog('Uploading document to: $storagePath');

      // Subir archivo
      final uploadTask = ref.putFile(
        file,
        SettableMetadata(
          contentType: _getContentType(extension),
          customMetadata: {
            'documentType': documentType,
            'documentName': documentName,
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      // Escuchar progreso
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        _debugLog('Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      // Esperar a que termine
      final snapshot = await uploadTask;

      // Obtener URL de descarga
      final downloadUrl = await snapshot.ref.getDownloadURL();

      _debugLog('Document uploaded successfully: $downloadUrl');

      return DocumentUploadResult.success(
        downloadUrl: downloadUrl,
        storagePath: storagePath,
        fileName: fileName,
      );
    } on FirebaseException catch (e) {
      _debugLog('Firebase error uploading document: ${e.message}');
      return DocumentUploadResult.failure(
        'Error al subir documento: ${e.message}',
      );
    } catch (e) {
      _debugLog('Error uploading document: $e');
      return DocumentUploadResult.failure(
        'Error inesperado al subir documento',
      );
    }
  }

  /// Elimina un documento de Firebase Storage
  Future<bool> deleteDocument(String storagePath) async {
    try {
      await _storage.ref().child(storagePath).delete();
      _debugLog('Document deleted: $storagePath');
      return true;
    } catch (e) {
      _debugLog('Error deleting document: $e');
      return false;
    }
  }

  /// Obtiene la URL de descarga de un documento
  Future<String?> getDocumentUrl(String storagePath) async {
    try {
      final url = await _storage.ref().child(storagePath).getDownloadURL();
      return url;
    } catch (e) {
      _debugLog('Error getting document URL: $e');
      return null;
    }
  }

  /// Determina el content type basado en la extensión
  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.pdf':
        return 'application/pdf';
      case '.heic':
        return 'image/heic';
      default:
        return 'application/octet-stream';
    }
  }

  /// Log condicional - solo muestra en debug
  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[DocumentService] $message');
    }
  }
}

/// Resultado de la subida de un documento
class DocumentUploadResult {
  final bool isSuccess;
  final String? downloadUrl;
  final String? storagePath;
  final String? fileName;
  final String? errorMessage;

  DocumentUploadResult._({
    required this.isSuccess,
    this.downloadUrl,
    this.storagePath,
    this.fileName,
    this.errorMessage,
  });

  factory DocumentUploadResult.success({
    required String downloadUrl,
    required String storagePath,
    required String fileName,
  }) {
    return DocumentUploadResult._(
      isSuccess: true,
      downloadUrl: downloadUrl,
      storagePath: storagePath,
      fileName: fileName,
    );
  }

  factory DocumentUploadResult.failure(String message) {
    return DocumentUploadResult._(
      isSuccess: false,
      errorMessage: message,
    );
  }
}
