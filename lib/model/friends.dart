import 'package:catch_me/model/friends_entity.dart';

class Friends {
  String name;
  String channelId;
  String otherUID;
  String uid;
  String profileUrl;
  String content;
  bool unRead;

  Friends({
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
          name == other.name &&
          channelId == other.channelId &&
          otherUID == other.otherUID &&
          uid == other.uid &&
          profileUrl == other.profileUrl &&
          content == other.content &&
          unRead == other.unRead;

  FriendsEntity toEntity() {
    return FriendsEntity(
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
