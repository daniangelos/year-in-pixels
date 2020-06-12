import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelingsController.dart';
import 'package:year_in_pixels/models/DayInfoModel.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';
import 'package:year_in_pixels/models/feelingModel.dart';

class ModalUpdateDayState extends State<ModalUpdateDay> {
  List<FeelingModel> _feelings;
  String _date;
  FeelingModel _selected;
  FeelingModel _feeling;
  DayInfoModel _dayInfo;
  final _textDescriptionController = TextEditingController();

  ModalUpdateDayState(DayInfoModel dayInfo, DateTime date) {
    _dayInfo = dayInfo;
    _feeling = _dayInfo.feeling;
    _textDescriptionController.text = _dayInfo.description;
    DateFormat formatter = DateFormat('MMM d, y');
    _date = formatter.format(date);
  }

  Widget colorContainer() {
    return Container(
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
    );
  }

  Widget noteInputField() {
    return Row(
      children: <Widget>[
        SizedBox(
            width: 100,
            child: TextField(
                controller: _textDescriptionController,
                decoration: InputDecoration(hintText: 'Note'))),
      ],
    );
  }

  Widget saveButton() {
    return MaterialButton(
      onPressed: () {
        _dayInfo.feeling = _selected;
        _dayInfo.description = _textDescriptionController.text;
        Navigator.of(context).pop(_dayInfo);
      },
      textColor: Theme.of(context).primaryColor,
      child: const Text('Save'),
    );
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
      content: colorContainer(),
      actions: [
        noteInputField(),
        saveButton(),
      ],
    );
  }

  @override
  void dispose() {
    _textDescriptionController.dispose();
    super.dispose();
  }
}

class ModalUpdateDay extends StatefulWidget {
  final DayInfoModel dayInfo;
  final DayBoxDate date;

  ModalUpdateDay({Key key, this.dayInfo, this.date}) : super(key: key);

  @override
  ModalUpdateDayState createState() => ModalUpdateDayState(
      this.dayInfo, DateTime(this.date.year, this.date.month, this.date.day));
}
