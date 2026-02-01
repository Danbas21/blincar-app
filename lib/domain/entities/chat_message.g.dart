// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ChatMessageImpl',
      json,
      ($checkedConvert) {
        final val = _$ChatMessageImpl(
          id: $checkedConvert('id', (v) => v as String),
          tripId: $checkedConvert('tripId', (v) => v as String),
          senderId: $checkedConvert('senderId', (v) => v as String),
          senderName: $checkedConvert('senderName', (v) => v as String),
          text: $checkedConvert('text', (v) => v as String),
          timestamp:
              $checkedConvert('timestamp', (v) => DateTime.parse(v as String)),
          read: $checkedConvert('read', (v) => v as bool? ?? false),
          type: $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$MessageTypeEnumMap, v) ??
                  MessageType.text),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'text': instance.text,
      'timestamp': instance.timestamp.toIso8601String(),
      'read': instance.read,
      'type': _$MessageTypeEnumMap[instance.type]!,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.location: 'location',
  MessageType.system: 'system',
};
