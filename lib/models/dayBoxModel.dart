import 'dart:math';

import 'package:flutter/material.dart';

import '../util.dart';

class DayBoxModel {
  Color color;
  DateTime date;
  int id;

  static List colors = [
    Colors.pink,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow
  ];
  static Random random = new Random();

  DayBoxModel(this.id, this.date) : color = colors[random.nextInt(6)];

  static List<DayBoxModel> getAllDays(int year) {
    // Mocked data
    List<int> numberOfDaysPerMonth = getAllNumberOfDaysPerMonth(year);
    List<DayBoxModel> allDays = List<DayBoxModel>();

    int currentId = 0;
    for (int month = 1; month <= 12; month++) {
      for (int day = 1; day <= numberOfDaysPerMonth[month - 1]; day++) {
        allDays.add(DayBoxModel(currentId++, DateTime.utc(year, month, day)));
      }
    }

    return allDays;
  }

  void setColor(Color color) {
    this.color = color;
  }
}
