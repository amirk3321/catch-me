import 'package:catch_me/model/user.dart' as prefix0;
import 'package:catch_me/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  UserEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadUser extends UserEvent{
    @override
  String toString() => 'LoadUser';
}
class UpdateUser extends UserEvent{
  final User user;
  UpdateUser({this.user}) : super([user]);
  @override
  String toString() => 'UpdateUser';
}

class DeleteUser extends UserEvent{
  @override
  String toString() => 'DeleteUser';
}
class UsersUpdated extends UserEvent{
  final List<User> user;

  UsersUpdated({this.user}):super([user]);
  @override
  String toString() => 'UsersUpdated';
}
