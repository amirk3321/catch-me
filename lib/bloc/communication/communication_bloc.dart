import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:catch_me/model/friends.dart';
import 'package:catch_me/model/location_channel.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import 'package:catch_me/utils/shared_pref.dart';
import './bloc.dart';

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  final FirebaseUserRepository _userRepository;

  StreamSubscription _messagesStreamSubscription;

  CommunicationBloc({FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  CommunicationState get initialState => CommunicationLoading();

  @override
  void dispose() {
    _messagesStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Stream<CommunicationState> mapEventToState(
    CommunicationEvent event,
  ) async* {
    if (event is CreateChatChannel) {
      yield* _mapOfCreateChatChannelToState(event);
    } else if (event is SendTextMessage) {
      yield* _mapOfSendTextMessageToState(event);
    } else if (event is LoadMessages) {
      yield* _mapOfLoadMessagesToState(event);
    } else if (event is MessagesUpdated) {
      yield* _mapOfMessagesUpdatedToState(event);
    } else if (event is UpdateChannelLocation) {
      yield* _mapOfUpdateChannelLocationToState(event);
    }else if (event is UpdateLocationTemp){
      //temp test location updated
      yield* _mapOfUpdateLocationTempToState(event);
    }
  }

  Stream<CommunicationState> _mapOfCreateChatChannelToState(
      CreateChatChannel event) async* {
    await _userRepository.getCreateChatChannel(
        otherUID: event.otherUID,
        onComplete: (channelId) async {
          print("channelId $channelId");
          _userRepository.addToStartChat(
              friends: Friends(
                  name: event.friends.name,
                  channelId: channelId,
                  otherUID: event.friends.otherUID,
                  uid: event.friends.uid,
                  content: event.friends.content,
                  profileUrl: event.friends.profileUrl,
                  unRead: event.friends.unRead,
                  senderName: event.friends.senderName));
          await _userRepository.getCreateLocationChannelSendLocationMessage(
              channelID: channelId,
              locationMessage: LocationChannel(
                channelID: channelId,
                uid: event.uid,
                otherUID: event.otherUID,
                currentName: event.currentName,
                otherName: event.otherName,
                currentUserPoints: null,
                otherUserUserPoints: null,
                isLocationCurrentUser: false,
                isLocationOtherUser: false,
              ));
          await SharedPref.setChatChannelID(channelId: channelId);
        });
  }

  Stream<CommunicationState> _mapOfSendTextMessageToState(
      SendTextMessage event) async* {
    await _userRepository.sendTextMessage(
        message: event.message, channelId: event.channelID);
  }

  Stream<CommunicationState> _mapOfLoadMessagesToState(
      LoadMessages event) async* {
    yield CommunicationLoading();
    _messagesStreamSubscription?.cancel();
    _messagesStreamSubscription =
        _userRepository.messages(channelId: event.channelId).listen((messages) {
      dispatch(MessagesUpdated(
        messages: messages,
      ));
    });
  }

  Stream<CommunicationState> _mapOfMessagesUpdatedToState(
      MessagesUpdated event) async* {
    yield CommunicationLoaded(messages: event.messages);
  }

  Stream<CommunicationState> _mapOfUpdateChannelLocationToState(
      UpdateChannelLocation event) async* {
    await _userRepository.updateChatChannelLocation(
        channelId: event.channelID,
        isLocationEnableCurrentUser: event.isLocationEnableCurrentUser,
        isLocationEnableOtherUser: event.isLocationEnableOtherUser,
        currentUid: event.currentUID,
        channelUID: event.channelUID,
        channelOtherUID: event.channelOtherUID,
        currentUserPoints: event.currentUserPoints,
        otherUserPoints: event.otherUserPoints);
  }

  Stream<CommunicationState> _mapOfUpdateLocationTempToState(UpdateLocationTemp event) async*{
    await _userRepository.updateLocationTemp(
      channelId: event.channelID,
      currentUserPoints: event.currentUserPoints,
      otherUserPoints: event.otherUserPoints
    );
  }
}
