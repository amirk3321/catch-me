import 'package:catch_me/bloc/communication/communication_bloc.dart';
import 'package:catch_me/bloc/communication/communication_event.dart';
import 'package:catch_me/bloc/friends/bloc.dart';
import 'package:catch_me/screen/common/single_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String uid;
  ChatScreen({Key key,this.uid}) :super(key : key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    BlocProvider.of<FriendsBloc>(context).dispatch(LoadFriends(uid: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (BuildContext context, FriendsState state) {
          if (state is FriendsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: double.infinity,
                    color: Colors.grey.withOpacity(.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    child: Text(
                      "favorite chat, tap to start communication",
                      style: TextStyle(color: Colors.grey),
                    )),
                Expanded(
                  child: Container(
                    child: state.friends.isEmpty
                        ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.chat,size: 60,color: Colors.grey[400],),
                        Text("Empty Chat",style: TextStyle(color: Colors.grey),)
                      ],
                    )
                        : ListView.builder(
                      itemCount: state.friends.length,
                      itemBuilder: (context, index) {
                        final friend=state.friends[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.asset(
                              'assets/default.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(friend.name),
                          subtitle: friend.content=="" || friend.content==null ?Text(''): Text(friend.content,overflow: TextOverflow.ellipsis,),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SingleChatScreen(
                                          channelId: friend.channelId,
                                          name: friend.name,
                                          uid: widget.uid,
                                          otherUID: friend.otherUID,
                                          receiverName:friend.senderName,
                                        )));
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
}