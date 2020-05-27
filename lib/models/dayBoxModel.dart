import 'dart:math';
import 'package:sembast/timestamp.dart';

import 'feelingModel.dart';

class DayBoxModel {
  FeelingModel feeling;
  DateTime date;
  int id, year;

  static Random random = new Random();

  DayBoxModel({this.date})
      : year = date.year,
        feeling = FeelingModel.getAllFeelings()[random.nextInt(6)];

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDateTime(date),
      'year': year,
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel(date: map['date'].toDateTime());
  }

  void setFeeling(FeelingModel feeling) {
    this.feeling = feeling;
  }
}
