
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatChannelEntity{
  final String channelId;
  final bool isLocationOtherUser;
  final bool isLocationCurrentUser;
  final List<String> userIds;

  ChatChannelEntity(this.channelId,this.isLocationOtherUser,this.isLocationCurrentUser,this.userIds);

  Map<String,Object> toJson() =>{
    'channelId' : channelId,
    'isLocationOtherUser' : isLocationOtherUser,
    'isLocationCurrentUser' : isLocationCurrentUser,
    'userIds' : userIds,
  };
  static ChatChannelEntity fromJson(Map<String,Object> json)
  => ChatChannelEntity(
    json['channelId'] as String,
    json['isLocationOtherUser'] as bool,
    json['isLocationCurrentUser'] as bool,
    json['userIds'] as List<String>,
  );

  static ChatChannelEntity fromSnapshot(DocumentSnapshot snapshot)
  => ChatChannelEntity(
    snapshot.data['channelId'],
    snapshot.data['isLocationOtherUser'],
    snapshot.data['isLocationCurrentUser'],
    snapshot.data['userIds'],
  );

  Map<String,Object> toDocument() =>{
    'channelId' : channelId,
    'isLocationOtherUser' : isLocationOtherUser,
    'isLocationCurrentUser' : isLocationCurrentUser,
    'userIds' : userIds,
  };

  @override
  String toString() {
    return 'channelId: $channelId, isLocationOtherUser: $isLocationOtherUser, isLocationCurrentUser: $isLocationCurrentUser, userIds: $userIds';
  }

}