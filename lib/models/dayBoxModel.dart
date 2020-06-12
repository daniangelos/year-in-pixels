import 'package:sembast/timestamp.dart';

import 'DayInfoModel.dart';
import 'feelingModel.dart';

class DayBoxModel {
  DayInfoModel dayInfo;
  final DateTime date;
  final int year;
  int id;

  DayBoxModel({this.date, FeelingModel feeling, String description})
      : year = date.year,
        dayInfo = DayInfoModel(feeling: feeling, description: description);

  DayBoxModel.withDayInfo({this.date, this.dayInfo}) : year = date.year;

  // We are converting from DateTime to Timestamp
  // because Sembast doesn't accept DateTime type
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDateTime(date),
      'year': year,
      'dayInfo': dayInfo.toMap(),
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel.withDayInfo(
      date: map['date'].toDateTime(isUtc: true),
      dayInfo: DayInfoModel.fromMap(map['dayInfo']),
    );
  }

  void setDayInfo(DayInfoModel dayInfo) {
    this.dayInfo = dayInfo;
  }
}
