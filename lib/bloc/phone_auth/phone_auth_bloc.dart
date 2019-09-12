import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import './bloc.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  FirebaseUserRepository _userRepository;

  PhoneAuthBloc({FirebaseUserRepository userRepository})
  :assert(userRepository!=null),
  _userRepository=userRepository;

  @override
  PhoneAuthState get initialState => InitialPhoneAuth();

  @override
  Stream<PhoneAuthState> mapEventToState(
    PhoneAuthEvent event,
  ) async* {
    if (event is VerifyPhoneNumber){
      yield* _mapVerifyPhoneNumberToState(event);
    }else if (event is VerifySMSCode){
      yield* _mapVerifySMSCode(event);
    }
  }

  Stream<PhoneAuthState> _mapVerifyPhoneNumberToState(VerifyPhoneNumber event) async*{
    yield LoadingPhoneAuth();
    try{
      await _userRepository.onPhoneAuthentication(phoneNumber: event.phoneNumber);
      yield ReceiveSMSPhoneAuth();
    }catch(_){
      yield FailurePhoneAuth();
    }
  }

  Stream<PhoneAuthState> _mapVerifySMSCode(VerifySMSCode event) async*{
    yield LoadingPhoneAuth();
    try{
      await _userRepository.onSignInWithPhoneNumber(smsCode: event.smsCode);
      yield SuccessPhoneAuth();
    }catch(_){
      yield FailurePhoneAuth();
    }
  }
}
