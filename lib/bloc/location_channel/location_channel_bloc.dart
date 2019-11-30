import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:catch_me/model/location_channel.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import './bloc.dart';

class LocationChannelBloc extends Bloc<LocationChannelEvent, LocationChannelState> {

  FirebaseUserRepository _userRepository;

  LocationChannelBloc({FirebaseUserRepository userRepository})
  :assert(userRepository!=null) , _userRepository=userRepository;

  StreamSubscription _locationStreamSubscription;
  @override
  LocationChannelState get initialState => LocationLoading();

  @override
  void dispose() {
    _locationStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Stream<LocationChannelState> mapEventToState(
    LocationChannelEvent event,
  ) async* {
    if (event is LoadLocation){
      yield* _mapOfLoadLocationToState(event);
    }else if (event is LocationUpdated){
      yield* _mapOfLocationUpdatedToState(event);
    }
  }

  Stream<LocationChannelState> _mapOfLoadLocationToState(LoadLocation event) async*{
    _locationStreamSubscription?.cancel();
    _locationStreamSubscription=_userRepository.locations().listen((locations){
      dispatch(LocationUpdated(
        locations: locations
      ));
    });
  }

 Stream<LocationChannelState> _mapOfLocationUpdatedToState(LocationUpdated event) async*{
    yield LocationLoaded(
      locationMessage: event.locations,
    );
 }

}
