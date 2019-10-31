import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsEntity {
  final String senderName;
  final String name;
  final String channelId;
  final String otherUID;
  final String uid;
  final String profileUrl;
  final String content;
  final bool unRead;

  FriendsEntity(
    this.senderName,
    this.name,
    this.channelId,
    this.otherUID,
    this.uid,
    this.profileUrl,
    this.content,
    this.unRead,
  );

  static FriendsEntity fromSnapshot(DocumentSnapshot snapshot) {
    return FriendsEntity(
      snapshot.data['senderName'],
      snapshot.data['name'],
      snapshot.data['channelId'],
      snapshot.data['otherUID'],
      snapshot.data['uid'],
      snapshot.data['profileUrl'],
      snapshot.data['content'],
      snapshot.data['unRead'],
    );
  }

  Map<String, Object> toDocument() => {
        'senderName': senderName,
        'name': name,
        'channelId': channelId,
        'otherUID': otherUID,
        'uid': uid,
        'profileUrl': profileUrl,
        'content': content,
        'unRead': unRead,
      };
}
