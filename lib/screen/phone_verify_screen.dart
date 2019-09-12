import 'package:flutter/material.dart';

class PhoneVerifyScreen extends StatefulWidget {
  PhoneVerifyScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneVerifyScreenState();
}

class PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify your phone number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Catch_Me will send an SMS message to verify your phone number.',
              maxLines: 2,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Enter your Name..',
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.local_phone),
                hintText: 'Enter your phone number..',
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration:BoxDecoration(
                color: Colors.green
              ),
              child: FlatButton(
                child: Text("Verify",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
