import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelingsController.dart';
import 'package:year_in_pixels/controllers/gridController.dart';
import 'package:year_in_pixels/helpers/constants.dart';
import 'package:year_in_pixels/helpers/util.dart';
import 'package:year_in_pixels/widgets/daybox.dart';

class Grid extends StatelessWidget {
  final int year;

  Grid({Key key, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double boxsize = (queryData.size.width / 14.0);

    List<int> numberOfDaysPerMonth = getAllNumberOfDaysPerMonth(year);
    List<List<int>> monthsListOfDaysIndexes = List<List<int>>();

    int index = 0;
    numberOfDaysPerMonth.forEach((numberOfDays) {
      List<int> daysIndexes = List<int>();
      for (int i = 0; i < numberOfDays; i++) {
        daysIndexes.add(index);
        index++;
      }
      monthsListOfDaysIndexes.add(daysIndexes);
    });

    List<Month> allMonths = monthsListOfDaysIndexes
        .map((daysIndexes) => Month(days: daysIndexes, boxsize: boxsize))
        .toList();

    return Consumer2<GridController, FeelingsController>(
        builder: (context, grid, feelingsController, child) {
      if (grid.days.isEmpty || feelingsController.feelingsCollection == null) {
        return Text("Loading...");
      }
      return ListView(
        children: <Widget>[
          MonthsDisplay(boxsize: boxsize),
          Container(
            height: 31 * boxsize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allMonths.length + 1,
              itemBuilder: (context, index) {
                return index == 0
                    ? DaysDisplay(boxsize: boxsize)
                    : allMonths[index - 1];
              },
            ),
          )
        ],
      );
    });
  }
}

class MonthsDisplay extends StatelessWidget {
  final months;
  final double boxsize;

  MonthsDisplay({Key key, this.boxsize})
      : months = new List<Container>.generate(
            12,
            (i) => Container(
                width: boxsize,
                height: boxsize,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(monthsFirstLetter(i + 1),
                      style: TextStyle(fontSize: MONTHFONTSIZE)),
                ))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
            Container(
              width: boxsize,
              height: boxsize,
            )
          ] +
          months,
    );
  }
}

class DaysDisplay extends StatelessWidget {
  final days;
  final double boxsize;

  DaysDisplay({Key key, this.boxsize})
      : days = new List<Container>.generate(
            31,
            (i) => Container(
                width: boxsize,
                height: boxsize,
                child: Align(
                  alignment: Alignment.center,
                  child: Text((i + 1).toString()),
                ))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: days,
    );
  }
}

class Month extends StatelessWidget {
  final List<int> days;
  final List<DayBox> dayBoxes;
  final double boxsize;

  Month({Key key, this.days, this.boxsize})
      : dayBoxes = days.map((index) => DayBox(index, boxsize)).toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: dayBoxes,
    );
  }
}
