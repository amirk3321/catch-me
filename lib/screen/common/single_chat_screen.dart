import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:catch_me/app_constent.dart';
import 'package:catch_me/bloc/chat_channel_id/bloc.dart';
import 'package:catch_me/bloc/communication/bloc.dart';
import 'package:catch_me/bloc/friends/friends_bloc.dart';
import 'package:catch_me/bloc/friends/friends_event.dart';
import 'package:catch_me/bloc/user/bloc.dart';
import 'package:catch_me/model/chat_channel.dart';
import 'package:catch_me/screen/common/google_screen.dart';
import 'package:catch_me/model/text_message.dart';
import 'package:catch_me/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class SingleChatScreen extends StatefulWidget {
  final String name;
  final String uid;
  final String otherUID;
  final String senderName;
  final String receiverName;
  final String channelId;

  SingleChatScreen(
      {Key key,
      this.name,
      this.uid,
      this.otherUID,
      this.senderName,
      this.receiverName,
      this.channelId})
      : super(key: key);

  @override
  _SingleChatScreenState createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  Location _location = Location();
  StreamSubscription _subscription;
  bool _isLocationEnable = false;
  String _resultText = "";
  TextEditingController _messageController;
  ScrollController _scrollController = ScrollController();

  //temporary solution of update location
  GeoPoint _currentUserLocation;
  GeoPoint _otherUserLocation;
  String _currentUID = "";
  String _otherUserUID = "";

  @override
  void initState() {
    _messageController = TextEditingController(text: _resultText);
    BlocProvider.of<CommunicationBloc>(context)
        .dispatch(LoadMessages(channelId: widget.channelId));
    BlocProvider.of<ChatChannelBloc>(context).dispatch(ChannelIdLoadEvent());
    print("checkUID ${widget.uid},otherUID $_otherUserUID");
    _subscription?.cancel();
    _subscription = _location.onLocationChanged().listen((locationData) {
          if (widget.uid == _currentUID && _isLocationEnable == true) {
            _currentUserLocation =
                GeoPoint(locationData.latitude, locationData.longitude);

            BlocProvider.of<CommunicationBloc>(context).dispatch(UpdateLocationTemp(
              channelID: widget.channelId,
              currentUserPoints: _currentUserLocation
            ));
            print(
                "currentUserLocationCheck $_isLocationEnable, $_currentUID ${_currentUserLocation.latitude}");
          } else if (widget.uid == _otherUserUID && _isLocationEnable == true) {
            _otherUserLocation =
                GeoPoint(locationData.latitude, locationData.longitude);
            BlocProvider.of<CommunicationBloc>(context).dispatch(UpdateLocationTemp(
                channelID: widget.channelId,
                otherUserPoints: _otherUserLocation
            ));
            print(
                "OtherUserLocationCheck $_isLocationEnable , $_otherUserUID ${_otherUserLocation.latitude},${_otherUserLocation.longitude}");
          } else {
            print("Temporary solution Data is empty $_isLocationEnable");
          }
    });
    _messageController.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationBloc, CommunicationState>(
      builder: (BuildContext context, CommunicationState state) {
        if (state is CommunicationLoading) {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  tooltip: "View Google Map",
                  autofocus: true,
                  icon: Icon(Icons.map),
                ),
                Switch(
                  onChanged: (value) {
                    if (mounted)
                      setState(() {
                        _isLocationEnable = value;
                      });
                    _location.requestPermission();
                  },
                  value: _isLocationEnable,
                )
              ],
              title: Text(widget.name),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is CommunicationLoaded) {
          return BlocBuilder<ChatChannelBloc, ChatChannelState>(
            builder: (BuildContext context, ChatChannelState chatChannelState) {
              if (chatChannelState is LoadedChannelIDs) {
                final chatChannelId = chatChannelState.chatChannels.firstWhere(
                    (channelIds) => channelIds.channelId == widget.channelId,
                    orElse: () => ChatChannel());
                Timer(
                    Duration(milliseconds: 100),
                    () => _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent));

                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, UserState userState) {
                    if (userState is UsersLoaded) {
                      final user = userState.user.firstWhere(
                          (user) => user.uid == widget.uid,
                          orElse: () => User());

                      final messages = state.messages;

                      return Scaffold(
                        appBar: AppBar(
                          actions: <Widget>[
                            IconButton(
                              onPressed: () {
                                print("checkID $_otherUserUID");
                              },
                              tooltip: "voice communictaion",
                              autofocus: true,
                              icon: Icon(Icons.call),
                            ),
                            IconButton(
                              onPressed: chatChannelId.isLocationOtherUser ==
                                          false &&
                                      chatChannelId.isLocationCurrentUser ==
                                          false
                                  ? null
                                  : () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => GoogleScreen(
                                                    otherName: widget.name,
                                                    otherUID:
                                                        chatChannelId.otherUId,
                                                    uid: widget.uid,
                                                    channelID:
                                                        chatChannelId.channelId,
                                                  )));
                                    },
                              tooltip: "View Google Map",
                              autofocus: true,
                              icon: Icon(Icons.map),
                            ),
                            Switch(
                              onChanged: (value) {
                                if (mounted)
                                  setState(() {
                                    _isLocationEnable = value;
                                  });
                                BlocProvider.of<CommunicationBloc>(context)
                                    .dispatch(UpdateChannelLocation(
                                        channelID: widget.channelId,
                                        isLocationEnableCurrentUser: value,
                                        isLocationEnableOtherUser: value,
                                        currentUID: widget.uid,
                                        channelUID: chatChannelId.uid,
                                        channelOtherUID:
                                            chatChannelId.otherUId));

                               setState(() {

                               });
                                setState(() {
                                  if(widget.uid == chatChannelId.otherUId) {
                                    _otherUserUID=chatChannelId.otherUId;


                                    Fluttertoast.showToast(
                                        msg: "otherUID ${chatChannelId.otherUId}");
                                  }else{
                                      _currentUID = chatChannelId.uid;

                                    Fluttertoast.showToast(
                                        msg: "UID ${chatChannelId.uid}");
                                  }
                                });

                              },
                              value: widget.uid == chatChannelId.uid
                                  ? chatChannelId.isLocationCurrentUser
                                  : chatChannelId.isLocationOtherUser,
                            )
                          ],
                          title: Text(widget.name),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      return state.messages[index].senderId ==
                                              widget.uid
                                          ? messageLayout(
                                              text:
                                                  state.messages[index].content,
                                              time: DateFormat('hh:mm a')
                                                  .format(state
                                                      .messages[index].time
                                                      .toDate()),
                                              color: Colors.green[300],
                                              align: TextAlign.left,
                                              nip: BubbleNip.rightTop,
                                              boxAlign: CrossAxisAlignment.end)
                                          : messageLayout(
                                              text:
                                                  state.messages[index].content,
                                              time: DateFormat('hh:mm a')
                                                  .format(state
                                                      .messages[index].time
                                                      .toDate()),
                                              color: Colors.white,
                                              align: TextAlign.left,
                                              nip: BubbleNip.leftTop,
                                              boxAlign:
                                                  CrossAxisAlignment.start);
                                    }),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.5, 0.2),
                                        color: Colors.black54,
                                        blurRadius: .2,
                                      )
                                    ],
                                    color: Colors.grey[100]),
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.image),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _messageController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "type feel free.. :) <3"),
                                      ),
                                    ),
                                    _messageController.text.isEmpty
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.keyboard_voice,
                                              color: Colors.red[700],
                                            ),
                                            onPressed: () {},
                                          )
                                        : Text(""),
                                    IconButton(
                                      onPressed: _messageController.text.isEmpty
                                          ? null
                                          : () {
                                              BlocProvider.of<
                                                          CommunicationBloc>(
                                                      context)
                                                  .dispatch(SendTextMessage(
                                                channelID: widget.channelId,
                                                message: TextMessage(
                                                  time: Timestamp.now(),
                                                  type: MessageType.TEXT,
                                                  recipientId: widget.otherUID,
                                                  senderId: widget.uid,
                                                  senderName: widget.senderName,
                                                  content:
                                                      _messageController.text,
                                                  receiverName:
                                                      widget.receiverName,
                                                ),
                                              ));
                                              BlocProvider.of<FriendsBloc>(
                                                      context)
                                                  .dispatch(UpdateMessageTitle(
                                                content:
                                                    _messageController.text,
                                                otherUID: widget.otherUID,
                                                uid: widget.uid,
                                              ));
                                              _messageController.text = "";
                                            },
                                      icon: Icon(
                                        Icons.send,
                                        color: _messageController.text.isEmpty
                                            ? Colors.green[200]
                                            : Colors.green[700],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                tooltip: "View Google Map",
                autofocus: true,
                icon: Icon(Icons.map),
              ),
              Switch(
                onChanged: (value) {
                  if (mounted)
                    setState(() {
                      _isLocationEnable = value;
                    });
                },
                value: _isLocationEnable,
              )
            ],
            title: Text(widget.name),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Column messageLayout({text, time, color, align, boxAlign, nip}) => Column(
        crossAxisAlignment: boxAlign,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    textAlign: align,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
      );

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
