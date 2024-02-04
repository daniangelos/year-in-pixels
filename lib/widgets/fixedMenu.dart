import 'package:flutter/material.dart';

class FixedMenu extends StatelessWidget {
  const FixedMenu(
      {Key? key, required this.currentIndex, required this.onItemTapped})
      : super(key: key);
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: "Settings",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.help,
          ),
          label: "Help",
        ),
      ],
      onTap: onItemTapped,
      currentIndex: currentIndex,
    );
  }
}
