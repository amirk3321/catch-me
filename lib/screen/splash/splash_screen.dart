import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
    SplashScreen({Key key}) :super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
      ),
      body: Center(child: Text('Splash Screen'),),
    );
  }
}