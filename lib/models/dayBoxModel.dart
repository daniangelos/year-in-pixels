import 'package:flutter/material.dart';

class DayBoxModel {
  Color color;
  int index;

  DayBoxModel(int index) {
    color = Colors.white;
    this.index = index;
  }

  static List<DayBoxModel> getAllDays() {
    return List.generate(366, (i) => DayBoxModel(i));
  }

  void setColor(Color color) {
    this.color = color;
  }
}
