import 'package:flutter/material.dart';

import 'fixedMenu.dart';
import 'grid.dart';
import 'settings.dart';
import 'help.dart';

enum TabItem { red, green, blue }

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Grid(),
    Settings(),
    Help(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Year in Pixels'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Settings'),
                ),
                PopupMenuItem(
                  child: Text('About'),
                ),
              ];
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: FixedMenu(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    return _widgetOptions.elementAt(_selectedIndex);
  }
}
