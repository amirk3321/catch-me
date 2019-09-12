import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneAuthState extends Equatable {
  PhoneAuthState([List props = const <dynamic>[]]) : super(props);
}

class InitialPhoneAuth extends PhoneAuthState {
  @override
  String toString() =>"InitialPhoneAuthState";
}
class LoadingPhoneAuth extends PhoneAuthState{
  @override
  String toString() =>"LoadingPhoneAuth";
}
class SuccessPhoneAuth extends PhoneAuthState{
  @override
  String toString() =>"SuccessPhoneAuth";
}
class ReceiveSMSPhoneAuth extends PhoneAuthState{
  @override
  String toString() =>"ReceiveSMSPhoneAuth";
}
class FailurePhoneAuth extends PhoneAuthState{
  @override
  String toString() =>"FailurePhoneAuth";
}
