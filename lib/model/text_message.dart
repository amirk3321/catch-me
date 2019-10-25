import 'package:catch_me/model/text_message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app_constent.dart';

class TextMessage {
  final String recipientId;
  final String senderId;
  final String senderName;
  final String type;
  final Timestamp time;
  final String content;
  final String receiverName;

  TextMessage(
      {this.recipientId = '',
      this.senderId = '',
      this.senderName = '',
      this.type = MessageType.TEXT,
      this.time,
      this.content='',
      this.receiverName=''});

  TextMessage copyWith({
    String recipientId,
    String senderId,
    String senderName,
    String type,
    Timestamp time,
    String content,
    String receiverName,
  }) {
    return TextMessage(
      recipientId: recipientId ?? this.recipientId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      type: type ?? this.type,
      time: time ?? this.time,
      content: content ?? this.content,
      receiverName: receiverName ?? this.receiverName,
    );
  }

  @override
  int get hashCode =>
      recipientId.hashCode ^
      senderId.hashCode ^
      senderName.hashCode ^
      type.hashCode ^
      time.hashCode ^
      content.hashCode ^
      receiverName.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, TextMessage) ||
      other is TextMessage &&
          runtimeType == other.runtimeType &&
          recipientId == other.recipientId &&
          senderId == other.senderId &&
          senderName == other.senderName &&
          type == other.type &&
          time == other.time &&
          content == other.content &&
          receiverName == other.receiverName;

  @override
  String toString() => '''
  recipientId :$recipientId , 
  senderId $senderId, 
  senderName $senderName, 
  type $type ,
  time $time
  content $content
  receiverName $receiverName
  ''';

  TextMessageEntity toEntity() =>
      TextMessageEntity(recipientId, senderId, senderName, type, time,content,receiverName);

  static TextMessage fromEntity(TextMessageEntity messageEntity) => TextMessage(
        recipientId: messageEntity.recipientId,
        senderId: messageEntity.senderId,
        senderName: messageEntity.senderName,
        type: messageEntity.type,
        time: messageEntity.time,
        content:messageEntity.content,
        receiverName: messageEntity.receiverName,
      );
}
