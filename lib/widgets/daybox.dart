import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/gridController.dart';
import 'package:year_in_pixels/helpers/util.dart';
import 'package:year_in_pixels/models/dayInfoModel.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';
import 'package:year_in_pixels/widgets/modalUpdateDay.dart';

class DayBoxState extends State<DayBox> {
  late DayBoxModel _dayBoxModel;

  @override
  Widget build(BuildContext context) {
    GridController grid = Provider.of<GridController>(context);
    _dayBoxModel = grid.getDayByID(widget.index);

    return Center(
        child: GestureDetector(
            onTap: () {
              createUpdateDayDialog().then((model) {
                setState(() {
                  if (model != null) grid.setDay(widget.index, model);
                });
              });
            },
            child: Container(
              child: SizedBox(
                width: widget.boxsize,
                height: widget.boxsize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _dayBoxModel.dayInfo.feeling.color,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          left: widget.boxsize / 10.0,
                          bottom: widget.boxsize / 20.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            _dayBoxModel.date.day.toString(),
                            style: TextStyle(
                              fontSize: widget.boxsize / 3.2,
                              color: getTextColor(
                                  _dayBoxModel.dayInfo.feeling.color),
                            ),
                          ))),
                ),
              ),
            )));
  }

  Future<DayInfoModel?> createUpdateDayDialog() async {
    final result = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ModalUpdateDay(
            dayInfo: _dayBoxModel.dayInfo,
            date: _dayBoxModel.date,
          );
        }));

    return result;
  }
}

class DayBox extends StatefulWidget {
  final int index;
  final double boxsize;

  DayBox(int index, double boxsize, {Key? key})
      : this.index = index,
        this.boxsize = boxsize,
        super(key: key);

  @override
  DayBoxState createState() => DayBoxState();
}
