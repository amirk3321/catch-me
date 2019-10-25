import 'package:catch_me/bloc/chat_channel_id/bloc.dart';
import 'package:catch_me/bloc/communication/communication_bloc.dart';
import 'package:catch_me/bloc/user/bloc.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import 'package:catch_me/screen/home_screen.dart';
import 'package:catch_me/screen/phone_verify_screen.dart';
import 'package:flutter/material.dart';
import 'bloc/authentication/bloc.dart';
import 'bloc/delegate/simple_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (_) => AuthBloc(
            FirebaseUserRepository(),
          )..dispatch(AppStartedEvent()),
        ),
        BlocProvider<UserBloc>(
          builder: (_) => UserBloc(
            userRepository: FirebaseUserRepository(),
          )..dispatch(LoadUser()),
        ),
        BlocProvider<CommunicationBloc>(
          builder: (_) => CommunicationBloc(userRepository: FirebaseUserRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Catch Me',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, accentColor: Colors.deepOrange),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthenticatedAuth) {
                  return HomeScreen(
                    uid: state.uid,
                  );
                }
                if (state is UnAuthenticatedAuth) {
                  return PhoneVerifyScreen();
                }
                return Container();
              },
            );
          },
        },
      ),
    );
  }
}
