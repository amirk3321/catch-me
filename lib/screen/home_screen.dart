import 'package:catch_me/bloc/authentication/bloc.dart';
import 'package:catch_me/bloc/user/bloc.dart';
import 'package:catch_me/model/user.dart';
import 'package:catch_me/screen/pages/call_screen.dart';
import 'package:catch_me/screen/pages/chat_screen.dart';
import 'package:catch_me/screen/pages/people_screen.dart';
import 'package:catch_me/screen/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/google_screen.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  HomeScreen({Key key, this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isIconChange = true;
  var _indexBottomNavBarController=0;
  List<Widget> get _bottomNavigationPages  => [ChatScreen(uid: widget.uid,),PeopleScreen(uid: widget.uid,),CallScreen()];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UsersLoaded) {
          final user = state.user
              .firstWhere((user) => user.uid == widget.uid, orElse: () => User());
          return Scaffold(
            bottomNavigationBar: FancyBottomNavigation(
              barBackgroundColor: Colors.white,
              tabs: [
                TabData(iconData: Icons.message, title: "Chat"),
                TabData(iconData: Icons.people, title: "friends"),
                TabData(iconData: Icons.call, title: "call")
              ],
              onTabChangedListener: (index){
                if (mounted)
                setState(() {
                  _indexBottomNavBarController=index;
                });
              },
            ),
            drawer: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple.withOpacity(.5)),
              child: Drawer(
                elevation: 10,
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              child: Image.asset(
                                'assets/default.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(user.name!=null ? user.name:'john de', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications, color: Colors.white),
                      title: Text(
                        "Notification",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.edit_location, color: Colors.white),
                      title: Text("Share Location",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.show_chart,
                        color: Colors.white,
                      ),
                      title: Text("Daily History",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                      title: Text("Messages",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    Divider(
                      color: Colors.white30,
                    ),
                    ListTile(
                      onTap: (){
                        BlocProvider.of<AuthBloc>(context).dispatch(LoggedOut());
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      title: Text("Logout",
                          style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
            body:  _bottomNavigationPages[_indexBottomNavBarController],
          );
        }
        return Container();
      },
    );
  }
}
