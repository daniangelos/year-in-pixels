import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './constants.dart';
import 'controllers/gridController.dart';

class DayBoxState extends State<DayBox> {
  Color _color;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    GridController grid = Provider.of<GridController>(context);
    _color = grid.getDayColor(widget.index);
    _date = grid.getDayDate(widget.index);

    return Center(
        child: GestureDetector(
      onTap: () {
        createUpdateDayDialog().then((color) {
          setState(() {
            if (color != null) {
              grid.setDayColor(widget.index, color);
            }
          });
        });
      },
      child: SizedBox(
        width: BOXSIZE,
        height: BOXSIZE,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _color,
            border: Border.all(color: Colors.black),
          ),
        ),
      ),
    ));
  }

  Future<Color> createUpdateDayDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          ModalUpdateDay(currentColor: this._color, date: _date),
    );
  }
}

class DayBox extends StatefulWidget {
  final int index;

  DayBox(int index, {Key key})
      : this.index = index,
        super(key: key);

  @override
  DayBoxState createState() => DayBoxState();
}

class ModalUpdateDayState extends State<ModalUpdateDay> {
  final List<Color> _colors = DEFAULT_COLORS;
  String _date;
  Color _selected = Colors.white;

  ModalUpdateDayState(Color currentColor, DateTime date) {
    _selected = currentColor;
    DateFormat formatter = DateFormat('MMM d, y');
    _date = formatter.format(date);
  }

  Widget build(BuildContext context) {
    return new AlertDialog(
      title: ListTile(
        title: Text(_date),
        subtitle: Text('How was your day, Dani?'),
      ),
      content: new Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 50.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selected = _colors[index];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _colors[index],
                  border: _selected == _colors[index]
                      ? Border.all(width: 2, color: Colors.black)
                      : null,
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
  final DateTime date;

  ModalUpdateDay({Key key, this.currentColor, this.date}) : super(key: key);

  @override
  ModalUpdateDayState createState() =>
      ModalUpdateDayState(this.currentColor, this.date);
}
