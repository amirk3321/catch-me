import 'package:catch_me/model/friends.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FriendsEvent extends Equatable {
  FriendsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadFriends extends FriendsEvent{
  final String uid;
  LoadFriends({this.uid}) :super([uid]);
  @override
  String toString() => "LoadFriends";
}

class FriendsUpdated extends FriendsEvent{
  final List<Friends> friends;
  FriendsUpdated({this.friends}) : super([friends]);
   @override
     String toString() => "FriendsUpdated";
}

class UpdateMessageTitle extends FriendsEvent {
  final String content;
  final String uid;
  final String otherUID;
  UpdateMessageTitle({this.content,this.uid,this.otherUID}) : super([content,uid,otherUID]);
   @override
     String toString() => "UpdateMessageTitle";
}