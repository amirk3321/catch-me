import 'package:cloud_firestore/cloud_firestore.dart';

class ChatChannelEntity {
  final String channelId;
  final bool isLocationOtherUser;
  final bool isLocationCurrentUser;
  final List<String> userIds;
  final String uid;
  final String otherUId;

  ChatChannelEntity(
    this.channelId,
    this.isLocationOtherUser,
    this.isLocationCurrentUser,
    this.uid,
    this.otherUId,
  {this.userIds}
  );

  Map<String, Object> toJson() => {
        'channelId': channelId,
        'isLocationOtherUser': isLocationOtherUser,
        'isLocationCurrentUser': isLocationCurrentUser,
        'userIds': userIds,
        'uid': uid,
        'otherUId': otherUId,
      };

  static ChatChannelEntity fromJson(Map<String, Object> json) =>
      ChatChannelEntity(
        json['channelId'] as String,
        json['isLocationOtherUser'] as bool,
        json['isLocationCurrentUser'] as bool,
        json['uid'] as String,
        json['otherUId'] as String,
        userIds:  json['userIds'] as List<String>,
      );

  static ChatChannelEntity fromSnapshot(DocumentSnapshot snapshot) =>
      ChatChannelEntity(
        snapshot.data['channelId'],
        snapshot.data['isLocationOtherUser'],
        snapshot.data['isLocationCurrentUser'],
        snapshot.data['uid'],
        snapshot.data['otherUId'],
      );

  Map<String, Object> toDocument() => {
        'channelId': channelId,
        'isLocationOtherUser': isLocationOtherUser,
        'isLocationCurrentUser': isLocationCurrentUser,
        'userIds': userIds,
        'uid': uid,
        'otherUId': otherUId,
      };

  @override
  String toString() {
    return 'ChatChannelEntity{channelId: $channelId, isLocationOtherUser: $isLocationOtherUser, isLocationCurrentUser: $isLocationCurrentUser, userIds: $userIds, uid: $uid, otherUId: $otherUId}';
  }


}
