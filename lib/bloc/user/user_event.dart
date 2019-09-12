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
  @override
  String toString() => 'UpdateUser';
}

class DeleteUser extends UserEvent{
  @override
  String toString() => 'DeleteUser';
}
class UsersUpdated extends UserEvent{
  @override
  String toString() => 'UsersUpdated';
}
