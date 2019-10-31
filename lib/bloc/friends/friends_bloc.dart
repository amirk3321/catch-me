import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import './bloc.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {

  final FirebaseUserRepository _userRepository;

  StreamSubscription _friendsStreamSubscription;

  FriendsBloc({FirebaseUserRepository repository})
  :assert(repository!=null) , _userRepository=repository;

  @override
  FriendsState get initialState => FriendsLoading();

  @override
  void dispose() {
    _friendsStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Stream<FriendsState> mapEventToState(
    FriendsEvent event,
  ) async* {
   if (event is LoadFriends){
     yield* _mapOfLoadFriendsToState(event);
   }else if(event is FriendsUpdated){
     yield* _mapOfFriendsUpdatedToState(event);
   }else if(event is UpdateMessageTitle){
     yield* _mapOfUpdateMessageTitleToState(event);
   }
  }

 Stream<FriendsState> _mapOfLoadFriendsToState(LoadFriends event) async*{
    _friendsStreamSubscription?.cancel();
    _friendsStreamSubscription=_userRepository.friendsRecord(uid:event.uid ).listen((friends){
      dispatch(FriendsUpdated(friends: friends));
    });
 }

  Stream<FriendsState> _mapOfFriendsUpdatedToState(FriendsUpdated event) async*{
    yield FriendsLoaded(friends: event.friends);
  }

  Stream<FriendsState> _mapOfUpdateMessageTitleToState(UpdateMessageTitle event) async*{
    await _userRepository.updateMessageContentTitle(content: event.content,uid: event.uid,otherUID: event.otherUID);
  }

}
