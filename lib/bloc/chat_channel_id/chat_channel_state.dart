import 'package:catch_me/model/chat_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatChannelState extends Equatable {
  ChatChannelState([List props = const <dynamic>[]]) : super(props);
}

class ChatChannelLoading extends ChatChannelState {
   @override
     String toString() => "ChatChannelLoading";
}


class LoadedChannelIDs extends ChatChannelState{
    final List<ChatChannel> chatChannels;
    LoadedChannelIDs({this.chatChannels}) :super([chatChannels]);
   @override
     String toString() => "LoadedChannelIDs  ";
}