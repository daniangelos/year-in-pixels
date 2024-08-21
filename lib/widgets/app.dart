import 'package:flutter/material.dart';
import 'package:year_in_pixels/widgets/navigationItems.dart';

import 'fixedMenu.dart';

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
        items: Navigation.items,
      ),
    );
  }

  Widget _buildBody() {
    var widgetOptions = Navigation.items.map((e) => e.widget).toList();
    return widgetOptions.elementAt(_selectedIndex);
  }
}
