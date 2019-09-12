import 'package:catch_me/screen/phone_verify_screen.dart';
import 'package:flutter/material.dart';

import '../google_screen.dart';


class HomeScreen extends StatefulWidget{
    HomeScreen({Key key}) :super(key : key);
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin{

  TabController _tabController;
  bool isIconChange = true;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        leading: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(isIconChange ? Icons.menu : Icons.close),
              onPressed: () {
                setState(() {
                  isIconChange = isIconChange ? false : true;
                });
              },
            ),
            Positioned(
              right: 18,
              top: 12,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          isScrollable: false,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.map), text: 'Map'),
            Tab(icon: Icon(Icons.people_outline), text: 'Friends'),
            Tab(icon: Icon(Icons.timeline), text: 'Profile'),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          GoogleScreen(),
          PhoneVerifyScreen(),
          Center(child: Text("Page 3")),
        ],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () {},
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}