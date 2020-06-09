import 'dart:ffi';

import 'package:sembast/timestamp.dart';

import 'feelingModel.dart';

class DayBoxDate {
  int day, month, year;
  DayBoxDate({this.day, this.month, this.year});
}

class DayBoxModel {
  FeelingModel feeling;
  DayBoxDate date;
  String description;
  int id;

  DayBoxModel({this.date, this.feeling, this.description});

  Map<String, dynamic> toMap() {
    return {
      'day': date.day,
      'month': date.month,
      'year': date.year,
      'feeling': feeling.toMap(),
      'description': description
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel(
        date:
            DayBoxDate(day: map['day'], month: map['month'], year: map['year']),
        feeling: FeelingModel.fromMap(map['feeling']),
        description: map['description']);
  }

  void setFeeling(FeelingModel feeling) {
    this.feeling = feeling;
  }

  void setDescription(String description) {
    this.description = description;
  }
}
