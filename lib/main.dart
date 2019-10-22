import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
        body: DayBox(),
      ),
    );
  }
}

class DayBoxState extends State<DayBox> {
  var _tapped = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => ModalUpdateDay().build(context),
          );
        },
        child: SizedBox(
          width: 150,
          height: 150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _tapped ? Colors.pink : Colors.black
            ),
          ),
        ),
      )
    );
  }
}

class DayBox extends StatefulWidget {
  @override
  DayBoxState createState() => DayBoxState();
}

class ModalUpdateDay {
  final _colors = [Colors.pink, Colors.red, Colors.blue, Colors.green];
  final _selected = Colors.white;
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('How was your day?'),
      content: new Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 50.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _colors.length, itemBuilder: (context, index) {
            return Container(
              width: 50.0,
              child: Card(color: _colors[index],),
            );
          },
        ),
      ),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Set color'),
        ),
      ],
    );
  }
}