import 'package:flutter/material.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';

class GridController {
  List<DayBoxModel> days;

  GridController() {
    days = DayBoxModel.getAllDays();
  }

  Color getDayColor(int index) {
    return days[index].color;
  }

  void setDayColor(int index, Color color) {
    days[index].setColor(color);
  }
}
