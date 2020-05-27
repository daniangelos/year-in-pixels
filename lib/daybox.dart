import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './constants.dart';
import 'controllers/feelingsController.dart';
import 'controllers/gridController.dart';
import 'models/feelingModel.dart';

class DayBoxState extends State<DayBox> {
  Color _color;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    GridController grid = Provider.of<GridController>(context);
    if (grid.days.isEmpty) {
      return Center(child: Text("Loading..."));
    }
    _color = grid.getDayFeeling(widget.index).color;
    _date = grid.getDayDate(widget.index);

    return Center(
        child: GestureDetector(
      onTap: () {
        createUpdateDayDialog().then((feeling) {
          setState(() {
            if (feeling != null) {
              grid.setDayFeeling(widget.index, feeling);
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

  Future<FeelingModel> createUpdateDayDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => Provider(
              create: (context) => FeelingsController(),
              child: ModalUpdateDay(currentColor: this._color, date: _date),
            ));
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
  List<FeelingModel> _feelings;
  String _date;
  FeelingModel _selected;
  Color _color;

  ModalUpdateDayState(Color currentColor, DateTime date) {
    _color = currentColor;
    DateFormat formatter = DateFormat('MMM d, y');
    _date = formatter.format(date);
  }

  Widget build(BuildContext context) {
    FeelingsController feelingsController =
        Provider.of<FeelingsController>(context);
    _feelings = feelingsController.feelings;
    _selected = feelingsController.getFeelingByColor(_color);

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
          itemCount: _feelings.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _color = _feelings[index].color;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _feelings[index].color,
                  border: _color == _feelings[index].color
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
