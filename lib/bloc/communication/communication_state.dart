import 'package:catch_me/model/text_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommunicationState extends Equatable {
  CommunicationState([List props = const <dynamic>[]]) : super(props);
}

class CommunicationLoading extends CommunicationState {
   @override
     String toString() => "CommunicationLoading";
}
class CommunicationLoaded extends CommunicationState{
  final List<TextMessage> messages;

  CommunicationLoaded({this.messages}) :super([messages]);
   @override
     String toString() => "CommunicationLoaded";
}