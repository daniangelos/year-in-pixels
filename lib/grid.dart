import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/constants.dart';
import 'package:year_in_pixels/controllers/gridController.dart';
import './daybox.dart';
import './util.dart';

class Grid extends StatelessWidget {
  final int year;

  Grid({Key key, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        .map((daysIndexes) => Month(days: daysIndexes))
        .toList();

    return Consumer<GridController>(builder: (context, grid, child) {
      if (grid.days.isEmpty) {
        return Text("Loading...");
      }
      return ListView(
        children: <Widget>[
          MonthsDisplay(),
          Container(
            height: 31 * BOXSIZE,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allMonths.length + 1,
              itemBuilder: (context, index) {
                return index == 0 ? DaysDisplay() : allMonths[index - 1];
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

  MonthsDisplay({Key key})
      : months = new List<Container>.generate(
            12,
            (i) => Container(
                width: BOXSIZE,
                height: BOXSIZE,
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
              width: 20,
              height: 20,
            )
          ] +
          months,
    );
  }
}

class DaysDisplay extends StatelessWidget {
  final days;

  DaysDisplay({Key key})
      : days = new List<Container>.generate(
            31,
            (i) => Container(
                width: BOXSIZE,
                height: BOXSIZE,
                child: Align(
                  alignment: Alignment.centerRight,
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

  Month({Key key, this.days})
      : dayBoxes = days.map((index) => DayBox(index)).toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: dayBoxes,
    );
  }
}
