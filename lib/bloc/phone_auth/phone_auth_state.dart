import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneAuthState extends Equatable {
  PhoneAuthState([List props = const <dynamic>[]]) : super(props);
}

class InitialPhoneAuthState extends PhoneAuthState {}
