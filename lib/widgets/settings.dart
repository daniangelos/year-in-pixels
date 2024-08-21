import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static Text settings = Text(
    'Index 1: Settings',
    style: optionStyle,
  );
  
  @override
  Widget build(BuildContext context) {
    return settings;
  }
}
