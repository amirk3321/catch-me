import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String phoneNumber;
  final GeoPoint currentPosition;
  final String name;
  final bool isLocation;
  final String uid;
  final String status;
  final String profileUrl;
  final bool isOnline;
  final String chatChannelId;
  UserEntity(
    this.phoneNumber,
    this.currentPosition,
    this.name,
    this.isLocation,
    this.uid,
    this.status,
    this.profileUrl,
    this.isOnline,
      this.chatChannelId,
  );

  Map<String, Object> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'currentPosition': currentPosition,
      'name': name,
      'isLocation': isLocation,
      'uid': uid,
      'status': status,
      'profileUrl': profileUrl,
      'isOnline': isOnline,
      'chatChannelId': chatChannelId,
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json['phoneNumber'] as String,
      json['currentPosition'] as GeoPoint,
      json['name'] as String,
      json['isLocation'] as bool,
      json['uid'] as String,
      json['status'] as String,
      json['profileUrl'] as String,
      json['isOnline'] as bool,
      json['chatChannelId'] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snapshot) {
    return UserEntity(
      snapshot.data['phoneNumber'],
      snapshot.data['currentPosition'],
      snapshot.data['name'],
      snapshot.data['isLocation'],
      snapshot.data['uid'],
      snapshot.data['status'],
      snapshot.data['profileUrl'],
      snapshot.data['isOnline'],
      snapshot.data['chatChannelId'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'phoneNumber': phoneNumber,
      'currentPosition': currentPosition,
      'name': name,
      'isLocation': isLocation,
      'uid': uid,
      'status': status,
      'profileUrl': profileUrl,
      'isOnline': isOnline,
      'chatChannelId': chatChannelId,
    };
  }

  @override
  String toString() => '''
    name :$name, isLocation $isLocation ,'uid' :$uid status :$status , profileUrl $profileUrl , isOnline $isOnline 
  ''';
}
