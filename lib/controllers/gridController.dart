import 'package:flutter/material.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';

class GridController {
  List<DayBoxModel> days;
  int year;

  GridController() {
    year = DateTime.now().year;
    days = DayBoxModel.getAllDays(year);
  }

  Color getDayColor(int index) {
    return days[index].color;
  }

  DateTime getDayDate(int index) {
    return days[index].date;
  }

  void setDayColor(int index, Color color) {
    days[index].setColor(color);
  }
}
