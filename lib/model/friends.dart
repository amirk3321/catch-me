import 'package:catch_me/model/friends_entity.dart';

class Friends {
  final String senderName;
  final String name;
  final String channelId;
  final String otherUID;
  final String uid;
  final String profileUrl;
  final String content;
  final bool unRead;

  Friends({
    this.senderName,
    this.name,
    this.channelId,
    this.otherUID,
    this.uid,
    this.profileUrl,
    this.content,
    this.unRead,
  });

  @override
  int get hashCode =>
      senderName.hashCode ^
      name.hashCode ^
      channelId.hashCode ^
      otherUID.hashCode ^
      uid.hashCode ^
      profileUrl.hashCode ^
      content.hashCode ^
      unRead.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is Friends &&
          runtimeType == other.runtimeType &&
          channelId == other.channelId &&
          senderName == other.senderName &&
          name == other.name &&
          channelId == other.channelId &&
          otherUID == other.otherUID &&
          uid == other.uid &&
          profileUrl == other.profileUrl &&
          content == other.content &&
          unRead == other.unRead;

  FriendsEntity toEntity() {
    return FriendsEntity(
      this.senderName,
      this.name,
      this.channelId,
      this.otherUID,
      this.uid,
      this.profileUrl,
      this.content,
      this.unRead,
    );
  }
  static Friends fromEntity(FriendsEntity entity){
    return Friends(
      senderName: entity.senderName,
      name: entity.name,
      channelId: entity.channelId,
      otherUID: entity.otherUID,
      uid: entity.uid,
      profileUrl: entity.profileUrl,
      content: entity.content,
      unRead: entity.unRead,
    );
  }
}
