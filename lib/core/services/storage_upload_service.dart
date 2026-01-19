// lib/core/services/storage_upload_service.dart

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Servicio para subir archivos a Firebase Storage
class StorageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Sube una imagen de INE a Firebase Storage
  /// Retorna la URL de descarga o null si falla
  Future<String?> uploadIneImage({
    required String userId,
    required XFile imageFile,
    required bool isFront,
  }) async {
    try {
      final String fileName = isFront ? 'ine_front.jpg' : 'ine_back.jpg';
      final String path = 'users/$userId/documents/$fileName';

      _log('Subiendo imagen: $path');

      final Reference ref = _storage.ref().child(path);

      UploadTask uploadTask;

      if (kIsWeb) {
        // Para web, usar bytes
        final bytes = await imageFile.readAsBytes();
        uploadTask = ref.putData(
          bytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      } else {
        // Para móvil, usar archivo
        final File file = File(imageFile.path);
        uploadTask = ref.putFile(
          file,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      }

      // Esperar a que termine la subida
      final TaskSnapshot snapshot = await uploadTask;

      // Obtener URL de descarga
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      _log('Imagen subida exitosamente: $downloadUrl');

      return downloadUrl;
    } catch (e) {
      _log('Error subiendo imagen: $e');
      return null;
    }
  }

  /// Sube ambas imágenes de INE
  /// Retorna un Map con las URLs o null en cada campo si falla
  Future<Map<String, String?>> uploadIneImages({
    required String userId,
    required XFile frontImage,
    required XFile backImage,
  }) async {
    _log('Subiendo imágenes de INE para usuario: $userId');

    final results = await Future.wait([
      uploadIneImage(userId: userId, imageFile: frontImage, isFront: true),
      uploadIneImage(userId: userId, imageFile: backImage, isFront: false),
    ]);

    return {
      'ineFrontUrl': results[0],
      'ineBackUrl': results[1],
    };
  }

  /// Elimina las imágenes de INE de un usuario
  Future<void> deleteIneImages(String userId) async {
    try {
      await _storage.ref('users/$userId/documents/ine_front.jpg').delete();
      await _storage.ref('users/$userId/documents/ine_back.jpg').delete();
      _log('Imágenes de INE eliminadas para usuario: $userId');
    } catch (e) {
      _log('Error eliminando imágenes: $e');
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[StorageUploadService] $message');
    }
  }
}
