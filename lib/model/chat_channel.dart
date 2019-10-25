import 'package:catch_me/model/chat_channel_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatChannel {
  final String channelId;
  final bool isLocationOtherUser;
  final bool isLocationCurrentUser;
  final List<String> userIds;

  ChatChannel(
      {this.channelId,
      this.isLocationOtherUser,
      this.isLocationCurrentUser,
      this.userIds});

  ChatChannel copyWith({
    String channelId,
    bool isLocationOtherUser,
    bool isLocationCurrentUser,
    List<String> userIds,
  }) {
    return ChatChannel(
      channelId: channelId ?? this.channelId,
      isLocationOtherUser: isLocationOtherUser ?? this.isLocationOtherUser,
      isLocationCurrentUser:
      isLocationCurrentUser ?? this.isLocationCurrentUser,
      userIds: userIds ?? this.userIds,
    );
  }

  @override
  int get hashCode =>
      channelId.hashCode ^
      isLocationOtherUser.hashCode ^
      isLocationCurrentUser.hashCode ^
      userIds.hashCode;

  @override
  bool operator ==(other) =>
      identical(this,other) ||
      other is ChatChannel &&
  runtimeType == other.runtimeType &&
  channelId == other.channelId &&
  isLocationOtherUser == other.isLocationOtherUser &&
  isLocationCurrentUser == other.isLocationCurrentUser &&
  userIds == other.userIds;

  ChatChannelEntity toEntity(){
    return ChatChannelEntity(
      this.channelId,
      this.isLocationOtherUser,
      this.isLocationCurrentUser,
      this.userIds,
    );
  }
  static ChatChannel fromEntity(ChatChannelEntity entity){
    return ChatChannel(
      channelId: entity.channelId,
      isLocationOtherUser: entity.isLocationOtherUser,
      isLocationCurrentUser: entity.isLocationCurrentUser,
      userIds: entity.userIds,
    );
  }
}
