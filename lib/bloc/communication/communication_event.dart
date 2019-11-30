import 'package:catch_me/model/friends.dart';
import 'package:catch_me/model/location_channel.dart';
import 'package:catch_me/model/text_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommunicationEvent extends Equatable {
  CommunicationEvent([List props = const <dynamic>[]]) : super(props);
}

class CreateChatChannel extends CommunicationEvent {
  final String otherUID;
  final Friends friends;
  final String currentName;
  final String otherName;
  final String uid;

  CreateChatChannel(
      {this.otherUID, this.friends, this.currentName, this.otherName, this.uid})
      : super([otherUID, friends, currentName, otherName, uid]);

  @override
  String toString() => "CreateChatChannel";
}

class AddToStartChat extends CommunicationEvent {
  final Friends friends;

  AddToStartChat({this.friends}) : super([friends]);

  @override
  String toString() => "AddToStartChat";
}

class AddToOtherStartChat extends CommunicationEvent {
  final Friends friends;

  AddToOtherStartChat({this.friends}) : super([friends]);

  @override
  String toString() => "AddToStartChat";
}

class SendTextMessage extends CommunicationEvent {
  final TextMessage message;
  final String channelID;

  SendTextMessage({this.message, this.channelID}) : super([message]);

  @override
  String toString() => "SendTextMessage";
}

class LoadMessages extends CommunicationEvent {
  String channelId;

  LoadMessages({this.channelId}) : super([channelId]);

  @override
  String toString() => "LoadMessages";
}

class MessagesUpdated extends CommunicationEvent {
  final List<TextMessage> messages;

  MessagesUpdated({this.messages}) : super([messages]);

  @override
  String toString() => "MessagesUpdated";
}

class UpdateLocationTemp extends CommunicationEvent{
  final String channelID;
  final GeoPoint currentUserPoints;
  final GeoPoint otherUserPoints;
  UpdateLocationTemp({this.channelID,this.currentUserPoints,this.otherUserPoints}) :super([channelID,currentUserPoints,otherUserPoints]);
  @override
  String toString() => "UpdateLocationTemp";
}
class UpdateChannelLocation extends CommunicationEvent {
  final bool isLocationEnableCurrentUser;
  final bool isLocationEnableOtherUser;
  final String channelID;
  final String currentUID;
  final String channelUID;
  final String channelOtherUID;
  final GeoPoint currentUserPoints;
  final GeoPoint otherUserPoints;

  UpdateChannelLocation(
      {this.isLocationEnableCurrentUser,
      this.isLocationEnableOtherUser,
      this.channelID,
      this.currentUID,
      this.channelUID,
      this.channelOtherUID,
      this.currentUserPoints,
      this.otherUserPoints})
      : super([
          isLocationEnableCurrentUser,
          isLocationEnableOtherUser,
          channelID,
          currentUID,
          channelUID,
          currentUserPoints,
          otherUserPoints
        ]);

  @override
  String toString() => "UpdateChannelLocation";
}
