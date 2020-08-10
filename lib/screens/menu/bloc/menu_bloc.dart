
import 'package:flutter_app/screens/menu/bloc/menu_bloc_interface.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc extends IMenuBloc {

  final BehaviorSubject<String> _userNameSubject = BehaviorSubject<String>.seeded("User");

  @override
  void onFirstOptionTap() {
    print("First option tap!");
  }

  @override
  void onSecondOptionTap() {
    print("Second option tap!");
  }

  @override
  void dispose() {
    _userNameSubject.close();
  }

  Sink<String> get _inUserName => _userNameSubject.sink;
  @override
  Stream<String> get outUserName => _userNameSubject.stream;

}