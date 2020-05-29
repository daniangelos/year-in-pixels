import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './grid.dart';
import 'controllers/gridController.dart';

void main() => runApp(
      ChangeNotifierProvider(
          create: (context) => GridController(), child: MyApp()),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Year in Pixels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Year in Pixels'),
        ),
        body: Grid(year: 2020),
      ),
    );
  }
}
