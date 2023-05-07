import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelingsController.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';
import 'package:year_in_pixels/models/feelingModel.dart';

class ModalUpdateDayState extends State<ModalUpdateDay> {
  List<FeelingModel> _feelings;
  String _date;
  FeelingModel _selected;
  FeelingModel _feeling;

  ModalUpdateDayState(FeelingModel feeling, DayBoxDate date) {
    _feeling = feeling;
    DateFormat formatter = DateFormat('MMM d, y');
    _date = formatter.format(DateTime(date.year, date.month, date.day));
  }

  Widget build(BuildContext context) {
    FeelingsController feelingsController =
        Provider.of<FeelingsController>(context);
    _feelings = feelingsController.feelingsCollection.feelings;
    _selected = _feeling;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: ListTile(
        title: Text(_date),
        subtitle: Text('How was your day, Dani?'),
      ),
      content: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 70.0,
        width: 70.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _feelings.length,
          itemBuilder: (context, index) {
            return Column(children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _feeling = _feelings[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _feelings[index].color,
                    border: _feeling == _feelings[index]
                        ? Border.all(width: 2, color: Colors.black)
                        : null,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
        MaterialButton(
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
  final FeelingModel currentFeeling;
  final DayBoxDate date;

  ModalUpdateDay({Key key, this.currentFeeling, this.date}) : super(key: key);

  @override
  ModalUpdateDayState createState() =>
      ModalUpdateDayState(this.currentFeeling, this.date);
}
