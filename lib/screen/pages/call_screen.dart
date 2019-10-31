import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
    CallScreen({Key key}) :super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_call,size: 50,color: Colors.grey,),
          Text("Empty Call History",style: TextStyle(color: Colors.grey),)
        ],
      )),
    );
  }
}