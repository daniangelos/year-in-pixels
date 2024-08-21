import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static Text help = Text(
    'Index 2: Help me',
    style: optionStyle,
  );
  
  @override
  Widget build(BuildContext context) {
    return help;
  }
}
