import 'package:catch_me/model/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String phoneNumber;
  final GeoPoint currentPosition;
  final String name;
  final bool isLocation;
  final String uid;
  final String status;
  final String profileUrl;
  final bool isOnline;
  final String chatChannelId;

  User(
      {this.phoneNumber = "",
      this.currentPosition,
      this.name = '',
      this.isLocation = false,
      this.uid = '',
      this.status,
      this.profileUrl = '',this.isOnline=false,this.chatChannelId =""});

  User copyWith(
      {
  String phoneNumber,
  GeoPoint currentPosition
  ,String name,
      bool isLocation,
      String uid,
      String status,
      String profileUrl,
        bool isOnline,
        String chatChannelId,
      }) {
    return User(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        currentPosition: currentPosition ?? this.currentPosition,
        name: name ?? this.name,
        isLocation: isLocation ?? this.isLocation,
        uid: uid ?? this.uid,
        status: status ?? this.status,
        profileUrl: profileUrl ?? this.profileUrl,
        isOnline: isOnline ?? this.isOnline,
        chatChannelId: chatChannelId ?? this.chatChannelId,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^
      isLocation.hashCode ^
      uid.hashCode ^
      status.hashCode ^
      profileUrl.hashCode^
      isOnline.hashCode ^
      chatChannelId.hashCode ;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          phoneNumber == other.phoneNumber &&
          currentPosition == other.currentPosition &&
          name == other.name &&
          isLocation == other.isLocation &&
          uid == other.uid &&
          status == other.status &&
          isOnline == other.isOnline &&
          profileUrl == other.profileUrl &&
          chatChannelId == other.chatChannelId;

  @override
  String toString() => '''
    name $name , isLocation $isLocation , uid $uid status $status profileUrl $profileUrl
  ''';

  UserEntity toEntity() {
    return UserEntity(phoneNumber,currentPosition,name, isLocation, uid, status, profileUrl,isOnline,chatChannelId);
  }

  static User fromEntity(UserEntity userEntity) {
    return User(
        phoneNumber: userEntity.phoneNumber,
        currentPosition: userEntity.currentPosition,
        name: userEntity.name,
        isLocation: userEntity.isLocation,
        uid: userEntity.uid,
        status: userEntity.status,
        profileUrl: userEntity.profileUrl,
        isOnline: userEntity.isOnline,
        chatChannelId: userEntity.chatChannelId,
    );
  }
}
