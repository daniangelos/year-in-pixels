import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:year_in_pixels/controllers/feelingsController.dart';
import 'package:year_in_pixels/controllers/gridController.dart';
import 'package:year_in_pixels/helpers/constants.dart';
import 'package:year_in_pixels/helpers/util.dart';
import 'package:year_in_pixels/widgets/daybox.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double boxsize = (queryData.size.width / 12.0);

    return Consumer2<GridController, FeelingsController>(
        builder: (context, grid, feelingsController, child) {
      if (grid.days.isEmpty) {
        return const Text("Loading...");
      }

      List<int> numberOfDaysPerMonth = getAllNumberOfDaysPerMonth(grid.year);
      List<List<int>> monthsListOfDaysIndexes = [];

      int index = 0;
      for (var numberOfDays in numberOfDaysPerMonth) {
        List<int> daysIndexes = [];
        for (int i = 0; i < numberOfDays; i++) {
          daysIndexes.add(index);
          index++;
        }
        monthsListOfDaysIndexes.add(daysIndexes);
      }

      List<Month> allMonths = monthsListOfDaysIndexes
          .map((daysIndexes) => Month(days: daysIndexes, boxsize: boxsize))
          .toList();

      return ListView(
        children: [
          MonthsDisplay(boxsize: boxsize),
          SizedBox(
            height: 31 * boxsize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allMonths.length,
              itemBuilder: (context, index) {
                return allMonths[index];
              },
            ),
          )
        ],
      );
    });
  }
}

class MonthsDisplay extends StatelessWidget {
  final List<SizedBox> months;
  final double boxsize;

  MonthsDisplay({Key? key, required this.boxsize})
      : months = List<SizedBox>.generate(
            12,
            (i) => SizedBox(
                width: boxsize,
                height: boxsize,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(monthsFirstLetter(i + 1),
                      style: const TextStyle(fontSize: MONTHFONTSIZE)),
                ))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: months,
    );
  }
}

class DaysDisplay extends StatelessWidget {
  final days;
  final double boxsize;

  DaysDisplay({required Key key, required this.boxsize})
      : days = List<SizedBox>.generate(
            31,
            (i) => SizedBox(
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

  Month({Key? key, required this.days, required this.boxsize})
      : dayBoxes = days.map((index) => DayBox(index, boxsize)).toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: dayBoxes,
    );
  }
}
