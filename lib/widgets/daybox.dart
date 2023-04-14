import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/gridController.dart';
import 'package:year_in_pixels/helpers/util.dart';
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
            child: Container(
              child: SizedBox(
                width: widget.boxsize,
                height: widget.boxsize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _color,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          left: widget.boxsize / 10.0,
                          bottom: widget.boxsize / 20.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            _date.day.toString(),
                            style: TextStyle(
                              fontSize: widget.boxsize / 3.2,
                              color: getTextColor(_color),
                            ),
                          ))),
                ),
              ),
            )));
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
  final double boxsize;

  DayBox(int index, double boxsize, {Key key})
      : this.index = index,
        this.boxsize = boxsize,
        super(key: key);

  @override
  DayBoxState createState() => DayBoxState();
}
