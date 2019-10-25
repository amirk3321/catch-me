import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  String uid;
  ChatScreen({Key key,this.uid}) :super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(uid)),
    );
  }
}