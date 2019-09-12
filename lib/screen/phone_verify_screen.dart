import 'package:catch_me/bloc/authentication/auth_bloc.dart';
import 'package:catch_me/bloc/authentication/auth_event.dart';
import 'package:catch_me/bloc/authentication/auth_state.dart';
import 'package:catch_me/bloc/phone_auth/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneVerifyScreen extends StatefulWidget {
  PhoneVerifyScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneVerifyScreenState();
}

class PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  PhoneAuthBloc _phoneAuthBloc;

  TextEditingController _phoneNumberController;
  TextEditingController _nameController;
  TextEditingController _smsCodeController;

  @override
  void initState() {
    _phoneAuthBloc = PhoneAuthBloc(userRepository: FirebaseUserRepository());
    _phoneNumberController = TextEditingController();
    _nameController = TextEditingController();
    _smsCodeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PhoneAuthBloc>(
          builder: (_) => _phoneAuthBloc,
          child: BlocListener<PhoneAuthBloc,PhoneAuthState>(
            listener: (context, state) {
              if (state is LoadingPhoneAuth){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Wait for moument...',style: TextStyle(fontSize: 16,),),
                      CircularProgressIndicator(),
                    ],
                  ),
                ));
              }
              if (state is ReceiveSMSPhoneAuth) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: const Duration(minutes: 2),
                  content: Row(
                    children: <Widget>[
                       Flexible(
                         child:  TextField(
                           controller: _smsCodeController,
                           keyboardType: TextInputType.text,
                           maxLength: 6,
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.verified_user),
                             hintText: 'Your verification code',
                           ),
                         ),
                       ),
                      Container(
                        decoration:BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward,color: Colors.white,),
                          onPressed: (){
                            if (_smsCodeController.text.isNotEmpty)
                              _phoneAuthBloc.dispatch(VerifySMSCode(smsCode: _smsCodeController.text));
                          },
                        ),
                      )
                    ],
                  ),
                ));
              }
              if (state is SuccessPhoneAuth){
                BlocProvider.of<AuthBloc>(context).dispatch(
                  LoggedIn()
                );

              }
            },
            child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
              builder: (context, state) {
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
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter your Name..',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.local_phone),
                            hintText: 'Enter your phone number..',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.green),
                          child: FlatButton(
                            child: Text(
                              "Verify",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_phoneNumberController.text.isNotEmpty) {
                                _phoneAuthBloc.dispatch(
                                    VerifyPhoneNumber(
                                        phoneNumber: _phoneNumberController.text
                                    )
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
      ),
    );
  }
}
