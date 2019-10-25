import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:catch_me/app_constent.dart';
import 'package:catch_me/bloc/communication/bloc.dart';
import 'package:catch_me/bloc/user/bloc.dart';
import 'package:catch_me/model/text_message.dart';
import 'package:catch_me/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SingleChatScreen extends StatefulWidget {
  final String name;
  final String uid;
  final otherUID;
  final String senderName;
  final String receiverName;
  final String channelId;

  SingleChatScreen(
      {Key key, this.name, this.uid, this.otherUID, this.senderName, this.receiverName, this.channelId})
      :super(key: key);

  @override
  _SingleChatScreenState createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  bool _isLocationEnable = false;
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
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
                    setState(() {
                      _isLocationEnable = value;
                    });
                  }, value: _isLocationEnable,
                )
              ],
              title: Text(widget.name),
            ),
            body: Center(child: CircularProgressIndicator(),),
          );
        }
        if (state is CommunicationLoaded) {
          Timer(
              Duration(milliseconds: 100),
                  () =>
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent));
          return BlocBuilder<UserBloc,UserState>(
            builder: (context,UserState userState){
              if (userState is UsersLoaded){
                final user=userState.user.firstWhere((user) => user.uid == widget.uid , orElse: () => User());
                final messages = state.messages;
                return Scaffold(
                  appBar: AppBar(
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {},
                        tooltip: "voice communictaion",
                        autofocus: true,
                        icon: Icon(Icons.call),
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        tooltip: "View Google Map",
                        autofocus: true,
                        icon: Icon(Icons.map),
                      ),
                      Switch(
                        onChanged: (value) {
                          setState(() {
                            _isLocationEnable = value;
                          });
//                          BlocProvider.of<UserBloc>(context).dispatch(UpdateUser(
//                              user: User(
//                                isLocation: value,
//                                uid: widget.uid,
//                              )
//                          ));
                        },value: _isLocationEnable,
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
                                return state.messages[index].senderId == widget.uid
                                    ? messageLayout(
                                    text: state.messages[index].content,
                                    time: DateFormat('hh:mm a').format(
                                        state.messages[index].time.toDate()),
                                    color: Colors.green[300],
                                    align: TextAlign.left,
                                    nip: BubbleNip.rightTop,
                                    boxAlign: CrossAxisAlignment.end) :
                                messageLayout(
                                    text: state.messages[index].content,
                                    time: DateFormat('hh:mm a').format(
                                        state.messages[index].time.toDate()),
                                    color: Colors.white,
                                    align: TextAlign.left,
                                    nip: BubbleNip.leftTop,
                                    boxAlign: CrossAxisAlignment.start);
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
                              color: Colors.grey[100]
                          ),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {

                                },
                                icon: Icon(Icons.image),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: _messageController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "type feel free.. :) <3"
                                  ),
                                ),
                              ),
                              _messageController.text.isNotEmpty ? Text('') : IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.mic, color: Colors.red,),
                              ),
                              IconButton(
                                onPressed: _messageController.text.isEmpty ? null : () {
                                  BlocProvider.of<CommunicationBloc>(context).dispatch(
                                      SendTextMessage(
                                        message: TextMessage(
                                          time: Timestamp.now(),
                                          type: MessageType.TEXT,
                                          recipientId: widget.otherUID,
                                          senderId: widget.uid,
                                          senderName: widget.senderName,
                                          content: _messageController.text,
                                          receiverName: widget.receiverName,
                                        ),
                                      ));
                                  _messageController.text = "";
                                },
                                icon: Icon(Icons.send,
                                  color: _messageController.text.isEmpty
                                      ? Colors.green[200]
                                      : Colors.green[700],),
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
                  setState(() {
                    _isLocationEnable = value;
                  });
                }, value: _isLocationEnable,
              )
            ],
            title: Text(widget.name),
          ),
          body: Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Scaffold _buildScaffold(BuildContext context, CommunicationLoaded state) {
    final messages = state.messages;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            tooltip: "voice communictaion",
            autofocus: true,
            icon: Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
            },
            tooltip: "View Google Map",
            autofocus: true,
            icon: Icon(Icons.map),
          ),
          Switch(
            onChanged: (value) {
              setState(() {
                _isLocationEnable = value;
              });
              BlocProvider.of<UserBloc>(context).dispatch(UpdateUser(
                  user: User(
                      isLocation: value,
                      uid: widget.uid,
                  )
              ));
            },value: _isLocationEnable,
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
                    return state.messages[index].senderId == widget.uid
                        ? messageLayout(
                        text: state.messages[index].content,
                        time: DateFormat('hh:mm a').format(
                            state.messages[index].time.toDate()),
                        color: Colors.green[300],
                        align: TextAlign.left,
                        nip: BubbleNip.rightTop,
                        boxAlign: CrossAxisAlignment.end) :
                    messageLayout(
                        text: state.messages[index].content,
                        time: DateFormat('hh:mm a').format(
                            state.messages[index].time.toDate()),
                        color: Colors.white,
                        align: TextAlign.left,
                        nip: BubbleNip.leftTop,
                        boxAlign: CrossAxisAlignment.start);
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
                  color: Colors.grey[100]
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.image),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _messageController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "type feel free.. :) <3"
                      ),
                    ),
                  ),
                  _messageController.text.isNotEmpty ? Text('') : IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mic, color: Colors.red,),
                  ),
                  IconButton(
                    onPressed: _messageController.text.isEmpty ? null : () {
                      BlocProvider.of<CommunicationBloc>(context).dispatch(
                          SendTextMessage(
                            message: TextMessage(
                              time: Timestamp.now(),
                              type: MessageType.TEXT,
                              recipientId: widget.otherUID,
                              senderId: widget.uid,
                              senderName: widget.senderName,
                              content: _messageController.text,
                              receiverName: widget.receiverName,
                            ),
                          ));
                      _messageController.text = "";
                    },
                    icon: Icon(Icons.send,
                      color: _messageController.text.isEmpty
                          ? Colors.green[200]
                          : Colors.green[700],),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column messageLayout({text, time, color, align, boxAlign, nip}) =>
      Column(
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
}