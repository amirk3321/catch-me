
import 'package:cloud_firestore/cloud_firestore.dart';

import 'location_channel_entity.dart';

class LocationChannel{
  final String currentName;
  final String otherName;
  final String channelID;
  final bool isLocationOtherUser;
  final bool isLocationCurrentUser;
  final String uid;
  final String otherUID;
  final GeoPoint currentUserPoints;
  final GeoPoint otherUserUserPoints;

  LocationChannel({
   this.currentName='',
   this.otherName ='',
   this.channelID ='',
   this.isLocationOtherUser =false,
   this.isLocationCurrentUser =false,
   this.uid ='',
   this.otherUID ='',
   this.currentUserPoints,
   this.otherUserUserPoints,
});

  @override
  int get hashCode =>
      currentName.hashCode ^
      otherName.hashCode ^
      channelID.hashCode ^
      isLocationOtherUser.hashCode ^
      isLocationCurrentUser.hashCode ^
      uid.hashCode ^
      otherUID.hashCode ^
      currentUserPoints.hashCode ^
      otherUserUserPoints.hashCode;

  @override
  bool operator ==(other) =>
      identical(this,other) ||
          other is LocationChannel &&
              runtimeType == other.runtimeType &&
              currentName == other.currentName &&
              otherName == other.otherName &&
              channelID == other.channelID &&
              isLocationOtherUser == other.isLocationOtherUser &&
              isLocationCurrentUser == other.isLocationCurrentUser &&
              uid == other.uid &&
              otherUID == other.otherUID &&
              currentUserPoints == other.currentUserPoints &&
              otherUserUserPoints == other.otherUserUserPoints ;


  LocationChannelEntity toEntity(){
    return LocationChannelEntity(
      this.currentName,
      this.otherName,
      this.channelID,
      this.isLocationOtherUser,
      this.isLocationCurrentUser,
      this.uid,
      this.otherUID,
      this.currentUserPoints,
      this.otherUserUserPoints,
    );
  }

  static LocationChannel fromEntity(LocationChannelEntity entity){
    return LocationChannel(
      currentName: entity.currentName,
      otherName: entity.otherName,
      channelID: entity.channelID,
      isLocationOtherUser: entity.isLocationOtherUser,
      isLocationCurrentUser: entity.isLocationCurrentUser,
      uid: entity.uid,
      otherUID: entity.otherUID,
      currentUserPoints: entity.currentUserPoints,
      otherUserUserPoints: entity.otherUserUserPoints,
    );
  }


}