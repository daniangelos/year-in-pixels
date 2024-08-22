import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelings_controller.dart';
import 'package:year_in_pixels/models/day_info_model.dart';
import 'package:year_in_pixels/models/day_box_model.dart';
import 'package:year_in_pixels/models/feeling_model.dart';

class _ModalUpdateDayState extends State<ModalUpdateDay> {
  final _textDescriptionController = TextEditingController();
  late DayInfoModel _dayInfo;
  late List<FeelingModel> _feelings;
  late String _date;
  late FeelingModel _selected;
  late FeelingModel _feeling;

  @override
  void initState(){
    super.initState();

    _dayInfo = widget.dayInfo;
    _feeling = _dayInfo.feeling;
    _textDescriptionController.text = _dayInfo.description ?? "";

    var dateTime = DateTime(widget.date.year, widget.date.month, widget.date.day);
    DateFormat formatter = DateFormat('MMM d, y');
    _date = formatter.format(dateTime);
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
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
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
            borderRadius: const BorderRadius.all(Radius.circular(4.0))),
        child: TextField(
          controller: _textDescriptionController,
          decoration: const InputDecoration(hintText: 'Describe your day :)'),
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

  @override
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
          const Align(alignment: Alignment.topRight, child: CloseButton()),
          ListTile(
            title: Center(child: Text(_date)),
            subtitle: const Center(child: Text('How was your day, Dani?')),
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

  const ModalUpdateDay({Key? key, required this.dayInfo, required this.date})
      : super(key: key);

  @override
  _ModalUpdateDayState createState() => _ModalUpdateDayState();
}
