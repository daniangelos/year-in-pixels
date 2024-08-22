import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/feelings_controller.dart';
import 'controllers/grid_controller.dart';
import 'widgets/app.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FeelingsController()),
        ChangeNotifierProvider(create: (context) => GridController()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Year in Pixels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}
