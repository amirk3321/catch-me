import 'package:catch_me/model/friends.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FriendsState extends Equatable {
  FriendsState([List props = const <dynamic>[]]) : super(props);
}

class FriendsLoading extends FriendsState {
  @override
  String toString() => "FriendsLoading";
}
class FriendsLoaded extends FriendsState{
  final List<Friends> friends;

  FriendsLoaded({this.friends}) :super([friends]);
  @override
  String toString() => "FriendsLoaded";
}