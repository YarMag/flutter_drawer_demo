import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/di/builders.dart';
import 'package:flutter_app/screens/app_container/app_container_item.dart';
import 'package:flutter_app/screens/app_container/app_container_screen.dart';
import 'package:flutter_app/screens/common/bloc_provider.dart';
import 'package:flutter_app/screens/first/bloc/first_bloc.dart';
import 'package:flutter_app/screens/first/bloc/first_bloc_interface.dart';
import 'package:flutter_app/screens/first/context/first_bloc_context.dart';
import 'package:flutter_app/screens/first/ui/first_screen.dart';
import 'package:flutter_app/screens/menu/bloc/menu_bloc.dart';
import 'package:flutter_app/screens/menu/bloc/menu_bloc_interface.dart';
import 'package:flutter_app/screens/menu/context/menu_bloc_context.dart';
import 'package:flutter_app/screens/menu/ui/menu_widget.dart';
import 'package:flutter_app/screens/second/bloc/second_bloc.dart';
import 'package:flutter_app/screens/second/bloc/second_bloc_interface.dart';
import 'package:flutter_app/screens/second/context/second_bloc_context.dart';
import 'package:flutter_app/screens/second/ui/second_screen.dart';
import 'package:flutter_app/screens/third/bloc/third_bloc.dart';
import 'package:flutter_app/screens/third/bloc/third_bloc_interface.dart';
import 'package:flutter_app/screens/third/context/third_bloc_context.dart';
import 'package:flutter_app/screens/third/ui/third_screen.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class Injection {
  static final Injector injector = Injector.getInjector();

  static Widget getCompositionRoot() {
    return injector.get<AppScreenBuilder>()();
  }

  static void initialize() {
    _registerBlocs();
    _registerScreenBuilders();
  }

  static void _registerBlocs() {
    injector.map<IMenuBloc>((i) => MenuBloc());

    injector.map<IFirstBloc>((i) => FirstBloc());
    injector.map<ISecondBloc>((i) => SecondBloc());
    injector.map<IThirdBloc>((i) => ThirdBloc());
  }

  static void _registerScreenBuilders() {
    injector.map<MenuBuilder>((i) => () {
          return BlocProvider(
            child: Menu(),
            blocContext: MenuBlocContext(),
            bloc: i.get<IMenuBloc>(),
          );
        });

    injector.map<FirstScreenBuilder>((i) => () {
          return BlocProvider(
            child: FirstScreen(),
            blocContext: FirstBlocContext(),
            bloc: i.get<IFirstBloc>(),
          );
        });

    injector.map<SecondScreenBuilder>((i) => () {
          return BlocProvider(
            child: SecondScreen(),
            blocContext: SecondBlocContext(),
            bloc: i.get<ISecondBloc>(),
          );
        });

    injector.map<ThirdScreenBuilder>((i) => () {
          return BlocProvider(
            child: ThirdScreen(),
            blocContext: ThirdBlocContext(),
            bloc: i.get<IThirdBloc>(),
          );
        });

    injector.map<AppScreenBuilder>((i) => () {
          return AppContainerScreen(
            menu: i.get<MenuBuilder>()(),
            content: _buildAppContainerItems(),
          );
        });
  }

  static List<AppContainerItem> _buildAppContainerItems() {
    return [
      AppContainerItem(
          screen: injector.get<FirstScreenBuilder>()(),
          barItem: BottomNavigationBarItem(
              icon: Icon(Icons.map), title: Text("First"))),
      AppContainerItem(
          screen: injector.get<SecondScreenBuilder>()(),
          barItem: BottomNavigationBarItem(
              icon: Icon(Icons.extension), title: Text("Second"))),
      AppContainerItem(
          screen: injector.get<ThirdScreenBuilder>()(),
          barItem: BottomNavigationBarItem(
              icon: Icon(Icons.accessibility), title: Text("Third"))),
    ];
  }
}
