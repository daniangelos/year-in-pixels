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
  Color _color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          createUpdateDayDialog().then((color){
            setState((){
              _color = color != null ? color : _color;
            });
          });
        },
        child: SizedBox(
          width: 150,
          height: 150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _color,
              border: Border.all(color: Colors.black),
            ),
          ),
        ),
      )
    );
  }

  Future<Color> createUpdateDayDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => ModalUpdateDay(currentColor: this._color),
    );
  }
}

class DayBox extends StatefulWidget {
  @override
  DayBoxState createState() => DayBoxState();
}

class ModalUpdateDayState extends State<ModalUpdateDay> {
  final _colors = [Colors.pink, Colors.red, Colors.blue, Colors.green];
  Color _selected = Colors.white;

  ModalUpdateDayState(Color currentColor) {
    _selected = currentColor;
  }

  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('How was your days?'),
      content: new Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 50.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _colors.length, itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () { setState(() {_selected = _colors[index]; } ); },
              child: Container(
                decoration: BoxDecoration(
                  color: _colors[index],
                  border: _selected == _colors[index] ? Border.all(width: 2, color: Colors.black) : null,
                ),
                width: 50.0,
                margin: EdgeInsets.only(left: 5.0),
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(_selected);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Set color'),
        ),
      ],
    );
  }
}

class ModalUpdateDay extends StatefulWidget {
  final Color currentColor;

  ModalUpdateDay( {Key key, this.currentColor} ) : super(key: key);

  @override
  ModalUpdateDayState createState() => ModalUpdateDayState(this.currentColor);
}
