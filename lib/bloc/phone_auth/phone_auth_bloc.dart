import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  @override
  PhoneAuthState get initialState => InitialPhoneAuthState();

  @override
  Stream<PhoneAuthState> mapEventToState(
    PhoneAuthEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
