import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static Text help = const Text(
    'Index 2: Help me',
    style: optionStyle,
  );

  const Help({super.key});
  
  @override
  Widget build(BuildContext context) {
    return help;
  }
}
