import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsEntity {
  String name;
  String channelId;
  String otherUID;
  String uid;
  String profileUrl;
  String content;
  bool unRead;

  FriendsEntity(
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
      snapshot.data['name'],
      snapshot.data['channelId'],
      snapshot.data['otherUID'],
      snapshot.data['uid'],
      snapshot.data['profileUrl'],
      snapshot.data['content'],
      snapshot.data['unRead'],
    );
  }
  Map<String,Object> toDocument() =>{
    'name' :name,
    'channelId' :channelId,
    'otherUID' :otherUID,
    'uid' :uid,
    'profileUrl' :profileUrl,
    'content' :content,
    'unRead' :unRead,
  };
}
