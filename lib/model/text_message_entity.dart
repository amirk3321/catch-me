import 'package:cloud_firestore/cloud_firestore.dart';

class TextMessageEntity{
  final String recipientId;
  final String senderId;
  final String senderName;
  final String type;
  final Timestamp time;
  final String content;
  final String receiverName;


  TextMessageEntity(this.recipientId,this.senderId,this.senderName,this.type,this.time,this.content,this.receiverName);

  Map<String,Object> toJson(){
    return {
      'recipientId' :recipientId,
      'senderId' :senderId,
      'senderName' :senderName,
      'type' :type,
      'time' :time,
      'content' :content,
      'receiverName' :receiverName,
    };
  }
 static TextMessageEntity formJson(Map<String,Object> json){
    return TextMessageEntity(
      json['recipientId'] as String,
      json['senderId'] as String,
      json['senderName'] as String,
      json['type'] as String,
      json['time'] as Timestamp,
      json['content'] as String,
      json['receiverName'] as String,
    );
  }

  static TextMessageEntity fromSnapshot(DocumentSnapshot snapshot){
    return TextMessageEntity(
      snapshot.data['recipientId'],
      snapshot.data['senderId'],
      snapshot.data['senderName'],
      snapshot.data['type'],
      snapshot.data['time'],
      snapshot.data['content'],
      snapshot.data['receiverName'],
    );
  }
  Map<String,Object> toDocument(){
    return {
      'recipientId' :recipientId,
      'senderId' :senderId,
      'senderName' :senderName,
      'type' :type,
      'time' :time,
      'content' :content,
      'receiverName' :receiverName,
    };
  }
}