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

  int id;

  DayBoxModel({this.date, this.feeling});

  Map<String, dynamic> toMap() {
    return {
      'day': date.day,
      'month': date.month,
      'year': date.year,
      'feeling': feeling.toMap()
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel(
        date:
            DayBoxDate(day: map['day'], month: map['month'], year: map['year']),
        feeling: FeelingModel.fromMap(map['feeling']));
  }

  void setFeeling(FeelingModel feeling) {
    this.feeling = feeling;
  }
}
