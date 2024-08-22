import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/grid_controller.dart';
import 'package:year_in_pixels/helpers/util.dart';
import 'package:year_in_pixels/models/day_info_model.dart';
import 'package:year_in_pixels/models/day_box_model.dart';
import 'package:year_in_pixels/widgets/modals/update_day.dart';

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

  const DayBox(this.index, this.boxsize, {Key? key})
      : super(key: key);

  @override
  DayBoxState createState() => DayBoxState();
}
