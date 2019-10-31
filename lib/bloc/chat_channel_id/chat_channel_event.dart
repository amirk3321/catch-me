import 'package:catch_me/model/chat_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatChannelEvent extends Equatable {
  ChatChannelEvent([List props = const <dynamic>[]]) : super(props);
}

class ChannelIdLoadEvent extends ChatChannelEvent{
   @override
     String toString() => "ChannelIdLoadEvent";
}

class UpdatedChannelId extends ChatChannelEvent{
  final List<ChatChannel> chatChannels;
  UpdatedChannelId({this.chatChannels}) :super([chatChannels]);
   @override
     String toString() => "UpdatedChannelId";
}