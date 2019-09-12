import 'package:bloc/bloc.dart';

class SimpleDelegate extends BlocDelegate{

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event.toString());
  }


  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.toString());
  }
}