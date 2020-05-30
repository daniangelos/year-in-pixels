import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelingsController.dart';
import 'package:year_in_pixels/models/feelingModel.dart';

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
    _feelings = feelingsController.feelingsCollection.feelings;
    _selected = feelingsController.getFeelingByColor(_color);

    return new AlertDialog(
      title: ListTile(
        title: Text(_date),
        subtitle: Text('How was your day, Dani?'),
      ),
      content: new Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 70.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _feelings.length,
          itemBuilder: (context, index) {
            return Column(children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _color = _feelings[index].color;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _feelings[index].color,
                    border: _color.value == _feelings[index].color.value
                        ? Border.all(width: 2, color: Colors.black)
                        : null,
                  ),
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.only(left: 5.0),
                ),
              ),
              Text(
                _feelings[index].description,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ]);
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
