import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
    CallScreen({Key key}) :super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.add_call,size: 50,)),
    );
  }
}