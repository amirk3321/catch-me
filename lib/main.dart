import 'package:catch_me/google_screen.dart';
import 'package:catch_me/repository/Firebase_user_repository.dart';
import 'package:catch_me/screen/home_screen.dart';
import 'package:catch_me/screen/phone_verify_screen.dart';
import 'package:catch_me/screen/splash/splash_screen.dart';
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
      ],
      child: MaterialApp(
        title: 'Catch Me',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange
        ),
       routes: {
          '/' : (context){
            return BlocBuilder<AuthBloc,AuthState>(
              builder: (context,state){
                if (state is AuthenticatedAuth){
                  return HomeScreen();
                }
                if (state is UnAuthenticatedAuth){
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  bool isIconChange = true;

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
