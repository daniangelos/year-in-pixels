import 'package:flutter/material.dart';
import 'package:year_in_pixels/constants.dart';
import './daybox.dart';
import './util.dart';

class Grid extends StatelessWidget {
  final allMonths;
  final year;

  Grid({ Key key, this.year }) :
    allMonths = getAllNumberOfDaysPerMonth(year).map((days) => Month(numberOfDays: days)).toList(),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MonthsDisplay(),
        Container(
          height: 31*BOXSIZE,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allMonths.length + 1, itemBuilder: (context, index) {
              return index == 0 ? DaysDisplay() : allMonths[index - 1];
            },
          ),
        )
      ],
    );
  }
}

class MonthsDisplay extends StatelessWidget {
  final months;

  MonthsDisplay({ Key key }) :
    months = new List<Container>.generate(12, (i) => 
      Container(
        width: BOXSIZE,
        height: BOXSIZE,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            monthsFirstLetter(i+1),
            style: TextStyle(fontSize: MONTHFONTSIZE)
          ),
        )
      )
    ),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Row(
        children: <Widget>[Container(width: 20, height: 20,)] + months,
      );
  }
}

class DaysDisplay extends StatelessWidget {
  final days;

  DaysDisplay({ Key key }) :
    days = new List<Container>.generate(31, (i) => 
      Container(
        width: BOXSIZE,
        height: BOXSIZE,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text((i+1).toString()),
        )
      )
    ),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: days,
      );
  }
}

class Month extends StatelessWidget {
  final int numberOfDays;
  final dayBoxes;

  Month({ Key key, this.numberOfDays }) : 
    dayBoxes = List<DayBox>.generate(numberOfDays, (i) => DayBox()), 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: dayBoxes,
    );
  }
}