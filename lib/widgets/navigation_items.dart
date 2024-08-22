import 'package:flutter/material.dart';
import 'package:year_in_pixels/widgets/grid.dart';
import 'package:year_in_pixels/widgets/help.dart';
import 'package:year_in_pixels/widgets/settings.dart';

class NavigationItem {
  Icon icon;
  String label;
  Widget widget;

  NavigationItem(this.icon, this.label, this.widget);
}

class Navigation {
  static var items = [
    NavigationItem(const Icon(Icons.home), "Home", const Grid()),
    NavigationItem(const Icon(Icons.settings), "Settings", const Settings()),
    NavigationItem(const Icon(Icons.help), "Help me", const Help()),
  ];
}
