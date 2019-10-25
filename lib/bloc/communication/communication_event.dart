import 'package:catch_me/model/friends.dart';
import 'package:catch_me/model/text_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommunicationEvent extends Equatable {
  CommunicationEvent([List props = const <dynamic>[]]) : super(props);
}

class CreateChatChannel extends CommunicationEvent{
  final String otherUID;
  final Friends friends;
  CreateChatChannel({this.otherUID,this.friends}) :super([otherUID]);
   @override
     String toString() => "CreateChatChannel";
}
class AddToStartChat extends CommunicationEvent{
  final Friends friends;
  AddToStartChat({this.friends}) : super([friends]);
   @override
     String toString() => "AddToStartChat";
}

class SendTextMessage extends CommunicationEvent {
  final TextMessage message;
  SendTextMessage({this.message}) :super([message]);
   @override
     String toString() => "SendTextMessage";
}

class LoadMessages extends CommunicationEvent{
  String channelId;
  LoadMessages({this.channelId}) :super([channelId]);
   @override
     String toString() => "LoadMessages";
}

class MessagesUpdated extends CommunicationEvent {
  final List<TextMessage> messages;
  MessagesUpdated({this.messages}) :super([messages]);
   @override
     String toString() => "MessagesUpdated";
}