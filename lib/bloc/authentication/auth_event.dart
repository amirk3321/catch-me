import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const <dynamic>[]]) : super(props);
}

class LoggedIn extends AuthEvent{
  @override
  String toString() => "LoggedIn";
}

class LoggedOutEvent extends AuthEvent{
  @override
  String toString() => 'LoggedOutEvent';
}
class AppStartedEvent extends AuthEvent{
   @override
  String toString() => "AppStartedEvent";
}