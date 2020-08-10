import 'package:flutter/material.dart';
import './app_container_item.dart';

class AppContainerScreen extends StatefulWidget {
  final Widget _menu;
  final List<AppContainerItem> _content;

  AppContainerScreen(
      {@required Widget menu, @required List<AppContainerItem> content})
      : _menu = menu,
        _content = content;

  @override
  State<StatefulWidget> createState() => _AppContainerScreenState();
}

class _AppContainerScreenState extends State<AppContainerScreen> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems;

  @override
  void initState() {
    super.initState();

    _bottomBarItems = widget._content.map((item) => item.barItem).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Drawer App"),
      ),
      body: SafeArea(
        child: widget._content[_selectedIndex].screen,
      ),
      drawer: Drawer(
        child: widget._menu,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems,
        currentIndex: _selectedIndex,
        onTap: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
