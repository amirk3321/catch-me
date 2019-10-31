

import 'package:cloud_firestore/cloud_firestore.dart';

class LocationChannelEntity{

  final String currentName;
  final String otherName;
  final String channelID;
  final bool isLocationOtherUser;
  final bool isLocationCurrentUser;
  final String uid;
  final String otherUID;
  final GeoPoint currentUserPoints;
  final GeoPoint otherUserUserPoints;


  LocationChannelEntity(
    this.currentName,
    this.otherName ,
    this.channelID ,
    this.isLocationOtherUser,
    this.isLocationCurrentUser,
    this.uid,
    this.otherUID,
    this.currentUserPoints,
    this.otherUserUserPoints,
  );

  Map<String, Object> toJson() => {
    'currentName': currentName,
    'otherName': otherName,
    'channelID': channelID,
    'isLocationOtherUser': isLocationOtherUser,
    'isLocationCurrentUser': isLocationCurrentUser,
    'uid': uid,
    'otherUID': otherUID,
    'currentUserPoints': currentUserPoints,
    'otherUserUserPoints': otherUserUserPoints,
  };
  static LocationChannelEntity fromJson(Map<String, Object> json) =>
      LocationChannelEntity(
        json['currentName'] as String,
        json['otherName'] as String,
        json['channelID'] as String,
        json['isLocationOtherUser'] as bool,
        json['isLocationCurrentUser'] as bool,
        json['uid'] as String,
        json['otherUID'] as String,
        json['currentUserPoints'] as GeoPoint,
        json['otherUserUserPoints'] as GeoPoint,
      );

  static LocationChannelEntity fromSnapshot(DocumentSnapshot snapshot) =>
      LocationChannelEntity(
        snapshot.data['currentName'],
        snapshot.data['otherName'],
        snapshot.data['channelID'],
        snapshot.data['isLocationOtherUser'],
        snapshot.data['isLocationCurrentUser'],
        snapshot.data['uid'],
        snapshot.data['otherUID'],
        snapshot.data['currentUserPoints'],
        snapshot.data['otherUserUserPoints'],
      );
  Map<String, Object> toDocument() => {
    'currentName': currentName,
    'otherName': otherName,
    'channelID': channelID,
    'isLocationOtherUser': isLocationOtherUser,
    'isLocationCurrentUser': isLocationCurrentUser,
    'uid': uid,
    'otherUID': otherUID,
    'currentUserPoints': currentUserPoints,
    'otherUserUserPoints': otherUserUserPoints,
  };
}