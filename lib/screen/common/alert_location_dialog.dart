import 'package:flutter/material.dart';

class AlertLocationDialog extends StatelessWidget {
  AlertLocationDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "Your partner can't share location with you please ask for location.. "),
            Text(
              "😢",
              style: TextStyle(fontSize: 40),
            ),
            Text(
              "Press the contine button to get your current location ☺",
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red,
      title: Text("Location"),
      elevation: 3.2,
      actions: <Widget>[
        FlatButton(
          color: Colors.white,
          child: Text("continue"),
          onPressed: () {},
        ),
      ],
    );
  }
}
