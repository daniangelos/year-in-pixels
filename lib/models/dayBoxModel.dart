import 'dayInfoModel.dart';
import 'feelingModel.dart';

class DayBoxDate {
  int day, month, year;
  DayBoxDate({this.day, this.month, this.year});
}

class DayBoxModel {
  DayInfoModel dayInfo;
  DayBoxDate date;
  int id;

  DayBoxModel({this.date, FeelingModel feeling, String description})
      : dayInfo = DayInfoModel(feeling: feeling, description: description);

  DayBoxModel.withDayInfo({this.date, this.dayInfo});

  Map<String, dynamic> toMap() {
    return {
      'day': date.day,
      'month': date.month,
      'year': date.year,
      'dayInfo': dayInfo.toMap(),
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel.withDayInfo(
      date: DayBoxDate(day: map['day'], month: map['month'], year: map['year']),
      dayInfo: DayInfoModel.fromMap(map['dayInfo']),
    );
  }

  void setDayInfo(DayInfoModel dayInfo) {
    this.dayInfo = dayInfo;
  }
}
