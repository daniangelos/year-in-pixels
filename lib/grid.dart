import 'package:flutter/material.dart';
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
    return 
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: allMonths.length, itemBuilder: (context, index) {
          return allMonths[index];
        },
      );
  }
}

class Month extends StatelessWidget {
  final int numberOfDays;
  final dayBoxes;

  Month({ Key key, this.numberOfDays }) : 
    dayBoxes = new List<DayBox>.generate(numberOfDays, (i) => DayBox()), 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: dayBoxes,
      );
  }

}