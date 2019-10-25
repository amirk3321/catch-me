import 'package:catch_me/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState extends Equatable {
  UserState([List props = const <dynamic>[]]) : super(props);
}

class UsersLoading extends UserState {
  @override
  String toString() => 'UsersLoading';
}

class UsersLoaded extends UserState {
  final List<User> user;

  UsersLoaded([this.user = const []]) : super([user]);

  @override
  String toString() => 'UsersLoaded { user: $user }';
}

class UsersNotLoaded extends UserState {
  @override
  String toString() => 'UsersNotLoaded';
}
