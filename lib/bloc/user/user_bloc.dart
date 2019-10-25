import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseUserRepository _userRepository;

  UserBloc({FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  StreamSubscription _streamSubscription;

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  UserState get initialState => UsersLoading();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      yield* _mapLoadUserToState();
    } else if (event is UsersUpdated) {
      yield* _mapUsersUpdatedToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    }
  }

  Stream<UserState> _mapLoadUserToState() async* {
    _streamSubscription?.cancel();
    _streamSubscription = _userRepository.users().listen((user) {
      dispatch(UsersUpdated(user: user));
    });
  }

  Stream<UserState> _mapUsersUpdatedToState(UsersUpdated event) async* {
    yield UsersLoaded(event.user);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
//    await _userRepository.onUpdateUserInfo(
//        name: event.user.name,
//        status: event.user.status,
//        profileUrl: event.user.profileUrl,
//        uid: event.user.uid,
//        isOnline: event.user.isOnline,
//        isLocation: event.user.isLocation);

    _userRepository.onUpdateUserInfo1(
      name: event.user.name,
      uid: event.user.uid,
      isLocation: event.user.isLocation,
    );
  }
}
