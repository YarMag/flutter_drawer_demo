import 'package:flutter/material.dart';
import 'package:flutter_app/screens/common/base_bloc_context.dart';
import 'package:flutter_app/screens/menu/bloc/menu_bloc.dart';
import 'package:flutter_app/screens/menu/bloc/menu_bloc_interface.dart';

class MenuBlocContext extends BlocContextBase<MenuBloc> {
  @override
  void subscribe(MenuBloc bloc, BuildContext context) {
    bloc.outUiEvents.listen((event) {
      switch (event.type) {
        case MenuBlocEvents.goToSomeScreen:
          break;
        default:
          break;
      }
    });
  }
}