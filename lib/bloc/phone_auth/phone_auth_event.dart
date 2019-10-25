import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneAuthEvent extends Equatable {
  PhoneAuthEvent([List props = const <dynamic>[]]) : super(props);
}

class VerifyPhoneNumber extends PhoneAuthEvent{
  final String phoneNumber;

    VerifyPhoneNumber({this.phoneNumber}) : super([phoneNumber]);

  @override
  String toString() =>'VerifyPhoneNumber';
}

class VerifySMSCode extends PhoneAuthEvent{
  final String smsCode;
  final String name;
  VerifySMSCode({this.smsCode,this.name})  : super([smsCode,name]);
}
