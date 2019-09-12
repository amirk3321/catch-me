import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseUserRepository _userRepository;

  AuthBloc(this._userRepository);

  @override
  AuthState get initialState => UninitializedAuth();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedEventToState();
    }else if (event is LoggedIn){
      yield* _mapLoggedInToState();
    }else if(event is LoggedOut){
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedEventToState() async* {

    try {
      var isSignIn = await _userRepository.isSignIn();
      if (isSignIn) {
        String uid=await _userRepository.getCurrentUID();
       yield AuthenticatedAuth(uid: uid);
      } else {
        yield UnAuthenticatedAuth();
      }
    } catch (_) {
      yield UnAuthenticatedAuth();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async*{
    String uid=await _userRepository.getCurrentUID();
    yield AuthenticatedAuth(uid: uid);
  }
  Stream<AuthState> _mapLoggedOutToState() async*{
    yield UnAuthenticatedAuth();
  }
}
