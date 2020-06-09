import 'package:flutter/material.dart';

List<int> getAllNumberOfDaysPerMonth(int year) {
  int february = isLeapYear(year) ? 29 : 28;
  return [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
}

bool isLeapYear(int year) {
  return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

String monthsFirstLetter(int monthIndex) {
  final List<String> monthsLetter = [
    'J',
    'F',
    'M',
    'A',
    'M',
    'J',
    'J',
    'A',
    'S',
    'O',
    'N',
    'D'
  ];
  return monthsLetter[monthIndex - 1];
}

Color getTextColor(Color color) {
  double greyScale =
      0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue;

  return greyScale < 128 ? Colors.white : Colors.black;
}
