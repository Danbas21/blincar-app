import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/chat_message.dart';

/// Servicio de chat en tiempo real usando Firebase Realtime Database
///
/// Estructura en Firebase:
/// /blincar/chats/{tripId}/messages/{messageId}
///   - tripId
///   - senderId
///   - senderName
///   - text
///   - timestamp
///   - read
///   - type
class ChatService {
  final FirebaseDatabase _database;
  final String _basePath = 'blincar/chats';

  ChatService({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  /// Referencia a los mensajes de un viaje específico
  DatabaseReference _messagesRef(String tripId) {
    return _database.ref('$_basePath/$tripId/messages');
  }

  /// Referencia a metadatos del chat
  DatabaseReference _chatMetaRef(String tripId) {
    return _database.ref('$_basePath/$tripId/meta');
  }

  /// Envía un mensaje al chat del viaje
  Future<void> sendMessage({
    required String tripId,
    required String senderId,
    required String senderName,
    required String text,
    MessageType type = MessageType.text,
  }) async {
    try {
      final message = ChatMessage(
        id: '', // Se asigna en Firebase
        tripId: tripId,
        senderId: senderId,
        senderName: senderName,
        text: text,
        timestamp: DateTime.now(),
        read: false,
        type: type,
      );

      final newMessageRef = _messagesRef(tripId).push();
      await newMessageRef.set(message.toFirebase());

      // Actualizar metadata del chat
      await _chatMetaRef(tripId).update({
        'lastMessage': text,
        'lastMessageTime': ServerValue.timestamp,
        'lastSenderId': senderId,
      });

      _log('Mensaje enviado: $text');
    } catch (e) {
      _log('Error enviando mensaje: $e');
      rethrow;
    }
  }

  /// Stream de mensajes en tiempo real para un viaje
  Stream<List<ChatMessage>> getMessagesStream(String tripId) {
    return _messagesRef(tripId)
        .orderByChild('timestamp')
        .onValue
        .map((event) {
      final messages = <ChatMessage>[];

      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value is Map) {
            messages.add(ChatMessage.fromFirebase(
              key as String,
              value,
            ));
          }
        });

        // Ordenar por timestamp
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }

      return messages;
    });
  }

  /// Obtiene los mensajes históricos de un viaje
  Future<List<ChatMessage>> getMessages(String tripId) async {
    try {
      final snapshot = await _messagesRef(tripId)
          .orderByChild('timestamp')
          .once();

      final messages = <ChatMessage>[];

      if (snapshot.snapshot.value != null) {
        final data = snapshot.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value is Map) {
            messages.add(ChatMessage.fromFirebase(
              key as String,
              value,
            ));
          }
        });

        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }

      return messages;
    } catch (e) {
      _log('Error obteniendo mensajes: $e');
      return [];
    }
  }

  /// Marca los mensajes como leídos para un usuario específico
  Future<void> markMessagesAsRead(String tripId, String currentUserId) async {
    try {
      final snapshot = await _messagesRef(tripId).once();

      if (snapshot.snapshot.value != null) {
        final data = snapshot.snapshot.value as Map<dynamic, dynamic>;
        final updates = <String, dynamic>{};

        data.forEach((key, value) {
          if (value is Map) {
            final senderId = value['senderId'] as String?;
            final read = value['read'] as bool? ?? false;

            // Marcar como leído si no es del usuario actual y no está leído
            if (senderId != currentUserId && !read) {
              updates['$key/read'] = true;
            }
          }
        });

        if (updates.isNotEmpty) {
          await _messagesRef(tripId).update(updates);
        }
      }
    } catch (e) {
      _log('Error marcando mensajes como leídos: $e');
    }
  }

  /// Cuenta mensajes no leídos para un usuario
  Future<int> getUnreadCount(String tripId, String currentUserId) async {
    try {
      final snapshot = await _messagesRef(tripId).once();

      if (snapshot.snapshot.value == null) return 0;

      final data = snapshot.snapshot.value as Map<dynamic, dynamic>;
      int count = 0;

      data.forEach((key, value) {
        if (value is Map) {
          final senderId = value['senderId'] as String?;
          final read = value['read'] as bool? ?? false;

          if (senderId != currentUserId && !read) {
            count++;
          }
        }
      });

      return count;
    } catch (e) {
      _log('Error contando mensajes no leídos: $e');
      return 0;
    }
  }

  /// Stream para detectar cuando el otro usuario está escribiendo
  Stream<bool> getTypingStream(String tripId, String otherUserId) {
    return _chatMetaRef(tripId)
        .child('typing')
        .child(otherUserId)
        .onValue
        .map((event) => event.snapshot.value == true);
  }

  /// Actualiza el estado de "escribiendo" del usuario actual
  Future<void> setTyping(String tripId, String userId, bool isTyping) async {
    try {
      await _chatMetaRef(tripId).child('typing').child(userId).set(isTyping);

      // Auto-clear typing después de 5 segundos
      if (isTyping) {
        Future.delayed(const Duration(seconds: 5), () {
          _chatMetaRef(tripId).child('typing').child(userId).set(false);
        });
      }
    } catch (e) {
      _log('Error actualizando estado typing: $e');
    }
  }

  /// Envía un mensaje de sistema (ej: "El conductor ha llegado")
  Future<void> sendSystemMessage({
    required String tripId,
    required String text,
  }) async {
    await sendMessage(
      tripId: tripId,
      senderId: 'system',
      senderName: 'Sistema',
      text: text,
      type: MessageType.system,
    );
  }

  /// Elimina todos los mensajes de un chat (cuando termina el viaje)
  Future<void> deleteChat(String tripId) async {
    try {
      await _database.ref('$_basePath/$tripId').remove();
      _log('Chat eliminado: $tripId');
    } catch (e) {
      _log('Error eliminando chat: $e');
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[ChatService] $message');
    }
  }
}
