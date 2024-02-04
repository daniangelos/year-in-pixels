import 'package:flutter/material.dart';

import 'fixedMenu.dart';
import 'grid.dart';

enum TabItem { red, green, blue }

class App extends StatefulWidget {
  const App({super.key});

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

  static Widget grid = const Grid();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    grid,
    const Text(
      'Index 1: Settings',
      style: optionStyle,
    ),
    const Grid(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Year in Pixels'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text('Settings'),
                ),
                const PopupMenuItem(
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
