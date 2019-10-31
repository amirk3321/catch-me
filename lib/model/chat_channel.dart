import 'package:catch_me/model/chat_channel_entity.dart';

class ChatChannel {
  final String channelId;
  final bool isLocationOtherUser;
  final bool isLocationCurrentUser;
  final List<String> userIds;
  final String uid;
  final String otherUId;

  ChatChannel(
      {this.channelId='',
      this.isLocationOtherUser=false,
      this.isLocationCurrentUser=false,
      this.userIds=const [],
      this.uid,this.otherUId});

  ChatChannel copyWith({
    String channelId,
    bool isLocationOtherUser,
    bool isLocationCurrentUser,
    List<String> userIds,
    String uid,
    String otherUID,
  }) {
    return ChatChannel(
      channelId: channelId ?? this.channelId,
      isLocationOtherUser: isLocationOtherUser ?? this.isLocationOtherUser,
      isLocationCurrentUser:
      isLocationCurrentUser ?? this.isLocationCurrentUser,
      userIds: userIds ?? this.userIds,
      uid: uid ?? this.uid,
      otherUId: otherUId ?? this.otherUId,
    );
  }

  @override
  int get hashCode =>
      channelId.hashCode ^
      isLocationOtherUser.hashCode ^
      isLocationCurrentUser.hashCode ^
      userIds.hashCode ^
      uid.hashCode ^
      otherUId.hashCode;

  @override
  bool operator ==(other) =>
      identical(this,other) ||
      other is ChatChannel &&
  runtimeType == other.runtimeType &&
  channelId == other.channelId &&
  isLocationOtherUser == other.isLocationOtherUser &&
  isLocationCurrentUser == other.isLocationCurrentUser &&
  userIds == other.userIds &&
  uid == other.uid &&
  otherUId == other.otherUId;

  ChatChannelEntity toEntity(){
    return ChatChannelEntity(
      this.channelId,
      this.isLocationOtherUser,
      this.isLocationCurrentUser,
      this.uid,
      this.otherUId,
      userIds:    this.userIds,
    );
  }
  static ChatChannel fromEntity(ChatChannelEntity entity){
    return ChatChannel(
      channelId: entity.channelId,
      isLocationOtherUser: entity.isLocationOtherUser,
      isLocationCurrentUser: entity.isLocationCurrentUser,
      userIds: entity.userIds,
      uid: entity.uid,
      otherUId: entity.otherUId,
    );
  }
}
