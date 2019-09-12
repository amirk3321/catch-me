import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneAuthEvent extends Equatable {
  PhoneAuthEvent([List props = const <dynamic>[]]) : super(props);
}
