import 'package:flutter/material.dart';
import 'package:year_in_pixels/widgets/navigation_items.dart';

class FixedMenu extends StatelessWidget {
  const FixedMenu(
      {Key? key, required this.currentIndex, required this.onItemTapped, required this.items})
      : super(key: key);
  final int currentIndex;
  final ValueChanged<int> onItemTapped;
  final List<NavigationItem> items;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: items.map((item) => BottomNavigationBarItem(icon: item.icon, label: item.label)).toList(),
      onTap: onItemTapped,
      currentIndex: currentIndex,
    );
  }
}
