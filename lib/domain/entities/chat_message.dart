import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    required String id,
    required String tripId,
    required String senderId,
    required String senderName,
    required String text,
    required DateTime timestamp,
    @Default(false) bool read,
    @Default(MessageType.text) MessageType type,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Crea un ChatMessage desde datos de Firebase Realtime Database
  factory ChatMessage.fromFirebase(String id, Map<dynamic, dynamic> data) {
    return ChatMessage(
      id: id,
      tripId: data['tripId'] as String? ?? '',
      senderId: data['senderId'] as String? ?? '',
      senderName: data['senderName'] as String? ?? '',
      text: data['text'] as String? ?? '',
      timestamp: data['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['timestamp'] as int)
          : DateTime.now(),
      read: data['read'] as bool? ?? false,
      type: MessageType.values.firstWhere(
        (e) => e.name == (data['type'] as String? ?? 'text'),
        orElse: () => MessageType.text,
      ),
    );
  }

  /// Convierte a formato para Firebase Realtime Database
  Map<String, dynamic> toFirebase() {
    return {
      'tripId': tripId,
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'read': read,
      'type': type.name,
    };
  }

  bool isMine(String currentUserId) => senderId == currentUserId;
}

enum MessageType {
  text,
  image,
  location,
  system,
}
