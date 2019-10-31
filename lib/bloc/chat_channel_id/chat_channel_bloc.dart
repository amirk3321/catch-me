import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import './bloc.dart';

class ChatChannelBloc extends Bloc<ChatChannelEvent, ChatChannelState> {
  final FirebaseUserRepository _userRepository;

  ChatChannelBloc({FirebaseUserRepository userRepository})
  :assert(userRepository!=null) , _userRepository=userRepository;

  StreamSubscription _streamSubscription;

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
  @override
  ChatChannelState get initialState => ChatChannelLoading();

  @override
  Stream<ChatChannelState> mapEventToState(
    ChatChannelEvent event,
  ) async* {
    if (event is ChannelIdLoadEvent){
      yield* _mapOfChannelIdLoadEventToState();
    }else if(event is UpdatedChannelId){
      yield* _mapOfUpdatedChannelIdToState(event);
    }
  }

  Stream<ChatChannelState> _mapOfChannelIdLoadEventToState() async*{
    _streamSubscription?.cancel();
    _streamSubscription=_userRepository.generatedChannelIds().listen((channelId){
      dispatch(UpdatedChannelId(chatChannels: channelId));
    });
  }

  Stream<ChatChannelState> _mapOfUpdatedChannelIdToState(UpdatedChannelId event) async*{
    yield LoadedChannelIDs(chatChannels: event.chatChannels);
  }


}
