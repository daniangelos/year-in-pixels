import 'package:flutter/material.dart';
import 'package:year_in_pixels/widgets/navigation_items.dart';

import 'fixed_menu.dart';

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
        items: Navigation.items,
      ),
    );
  }

  Widget _buildBody() {
    var widgetOptions = Navigation.items.map((e) => e.widget).toList();
    return widgetOptions.elementAt(_selectedIndex);
  }
}
