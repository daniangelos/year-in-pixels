import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelingsController.dart';
import 'package:year_in_pixels/models/dayInfoModel.dart';
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

  Widget colorContainer(double containerHeight) {
    double boxSize = containerHeight * 5 / 7;
    return Container(
        margin: EdgeInsets.symmetric(vertical: containerHeight * 2 / 7),
        height: containerHeight,
        child: Align(
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
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
                    width: boxSize,
                    height: boxSize,
                    margin: EdgeInsets.only(left: boxSize / 10),
                  ),
                ),
                Text(
                  _feelings[index].description,
                  style: TextStyle(
                    fontSize: boxSize / 5,
                  ),
                ),
              ]);
            },
          ),
        ));
  }

  Widget noteInputField(double boxWidth) {
    return Flex(direction: Axis.vertical, children: [
      Container(
        width: boxWidth,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: TextField(
          controller: _textDescriptionController,
          decoration: InputDecoration(hintText: 'Describe your day :)'),
          autofocus: false,
          maxLines: null,
          keyboardType: TextInputType.text,
        ),
      )
    ]);
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

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double width = queryData.size.width;
    double height = queryData.size.height;

    return Scaffold(
        backgroundColor: Colors.white.withAlpha(245),
        body: ListView(shrinkWrap: true, children: [
          Align(alignment: Alignment.topRight, child: CloseButton()),
          ListTile(
            title: Center(child: Text(_date)),
            subtitle: Center(child: Text('How was your day, Dani?')),
          ),
          colorContainer(height / 10),
          noteInputField(width * 3 / 5),
          saveButton(),
        ]));
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
