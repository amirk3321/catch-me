import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const <dynamic>[]]) : super(props);
}

class UninitializedAuth extends AuthState{
  @override
  String toString() => 'UninitializedAuth';
}

class AuthenticatedAuth extends AuthState{
  final String uid;
  AuthenticatedAuth({this.uid}) :super([uid]);
  @override
  String toString() => 'AuthenticatedAuth';
}

class UnAuthenticatedAuth extends AuthState{
  @override
  String toString() => 'UnAuthenticatedAuth';
}
