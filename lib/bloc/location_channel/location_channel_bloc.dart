import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import './bloc.dart';

class LocationChannelBloc extends Bloc<LocationChannelEvent, LocationChannelState> {

  FirebaseUserRepository _userRepository;

  LocationChannelBloc({FirebaseUserRepository userRepository})
  :assert(userRepository!=null) , _userRepository=userRepository;


  @override
  LocationChannelState get initialState => LocationLoading();

  @override
  Stream<LocationChannelState> mapEventToState(
    LocationChannelEvent event,
  ) async* {
    if (event is CreateLocationChannel){
      yield* _mapOfLocationMessageToState(event);
    }
  }

 Stream<LocationChannelState> _mapOfLocationMessageToState(CreateLocationChannel event) async*{
   _userRepository.getCreateLocationChannelSendLocationMessage(
     channelID:event.channelId,
     locationMessage: event.locationChannel,
   );
 }
}
