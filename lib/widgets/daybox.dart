import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/gridController.dart';
import 'package:year_in_pixels/helpers/constants.dart';
import 'package:year_in_pixels/models/feelingModel.dart';
import 'package:year_in_pixels/widgets/modalUpdateDay.dart';

class DayBoxState extends State<DayBox> {
  Color _color;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    GridController grid = Provider.of<GridController>(context);
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