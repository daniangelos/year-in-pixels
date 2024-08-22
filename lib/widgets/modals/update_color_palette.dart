import 'package:flutter/material.dart';

class ModalUpdateColorPalette extends StatelessWidget {
  const ModalUpdateColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(245),
      body: ListView(shrinkWrap: true, children: const [
          Align(alignment: Alignment.topRight, child: CloseButton()),
          ListTile(
            title: Center(child: Text('Choose the color of your pixels')),
            // subtitle: Center(child: Text('How was your day, Dani?')),
          ),
    ]));
  }
}
