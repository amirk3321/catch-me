import 'dart:ffi';

import 'package:catch_me/bloc/chat_channel_id/bloc.dart';
import 'package:catch_me/bloc/communication/bloc.dart';
import 'package:catch_me/bloc/user/bloc.dart';
import 'package:catch_me/model/friends.dart';
import 'package:catch_me/model/location_channel.dart';
import 'package:catch_me/model/user.dart';
import 'package:catch_me/screen/common/single_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleScreen extends StatefulWidget {
  String uid;

  PeopleScreen({Key key, this.uid}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  RequestController _requstController = RequestController.SEND_FRIEND_REQUEST;
  String _buttonName = "Add me";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state is UsersLoaded) {
            final currentUserRecord = state.user.firstWhere(
                (user) => user.uid == widget.uid,
                orElse: () => User());
            final users =
                state.user.where((user) => user.uid != widget.uid).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: double.infinity,
                    color: Colors.grey.withOpacity(.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    child: Text(
                      "All friends, tap to + button add favorite",
                      style: TextStyle(color: Colors.grey),
                    )),
                Expanded(
                  child: Container(
                    child: users.isEmpty
                        ? centerErrorMessage
                        : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final otherUID = users[index].uid;

                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.asset(
                              'assets/default.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(users[index].name),
                          subtitle: Text(users[index].status),
                          trailing: IconButton(
                            icon: Icon(Icons.add), onPressed: () {
                              print("senderName ${currentUserRecord.name}");
                            BlocProvider.of<CommunicationBloc>(
                                context)
                                .dispatch(CreateChatChannel(
                                otherUID: otherUID,
                            friends: Friends(
                              name:users[index].name,
                              uid: widget.uid,
                              otherUID: users[index].uid,
                              unRead: false,
                              senderName: currentUserRecord.name,
                              profileUrl: ""
                            ),
                            currentName: currentUserRecord.name,
                              otherName: users[index].name,
                              uid: widget.uid,
                            ));



                          },
                          ),
                          onTap: () {


//                            BlocProvider.of<CommunicationBloc>(
//                                context)
//                                .dispatch(CreateChatChannel(
//                                otherUID: otherUID));
//                            Navigator.of(context).push(
//                                MaterialPageRoute(
//                                    builder: (_) =>
//                                        SingleChatScreen(
//                                          name: users[index].name,
//                                          uid: widget.uid,
//                                          otherUID: otherUID,
//                                          senderName:
//                                          currentUserRecord
//                                              .name,
//                                          receiverName:
//                                          users[index].name,
//                                        )));
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void _friendRequestController() {
    if (_requstController == RequestController.SEND_FRIEND_REQUEST) {
      setState(() {
        _requstController = RequestController.CANCEL_FRIEND_REQUEST;
        _buttonName = "Cancel";
      });
    } else if (_requstController == RequestController.CANCEL_FRIEND_REQUEST) {
      setState(() {
        _requstController = RequestController.SEND_FRIEND_REQUEST;
        _buttonName = "Add me";
      });
    }
    if (_requstController == RequestController.FRIEND) {
      setState(() {
        _requstController = RequestController.CANCEL_FRIEND_REQUEST;
        _buttonName = "UnFriend";
      });
    }
  }

  Center get centerErrorMessage => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.people,
              size: 80,
              color: Colors.black54.withOpacity(.3),
            ),
            Text(
              "Zero Friend Found",
              style: TextStyle(color: Colors.black54.withOpacity(.3)),
            )
          ],
        ),
      );
}

class SinglePeopleLayout extends StatelessWidget {
  final String profile;
  final String name;
  final String status;

  SinglePeopleLayout({Key key, this.name, this.status, this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Image.asset(
                  'assets/default.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(name),
              subtitle: Text(status),
            ),
          ],
        ),
      ),
    );
  }
}

//Center(child: Icon(Icons.people,size: 50,))
enum RequestController { SEND_FRIEND_REQUEST, FRIEND, CANCEL_FRIEND_REQUEST }

/*


*/
