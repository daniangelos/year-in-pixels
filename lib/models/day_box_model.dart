import 'day_info_model.dart';
import 'feeling_model.dart';

class DayBoxDate {
  int day, month, year;
  DayBoxDate({required this.day, required this.month, required this.year});
}

class DayBoxModel {
  DayInfoModel dayInfo;
  DayBoxDate date;
  late int id;

  DayBoxModel(
      {required this.date,
      required FeelingModel feeling,
      required String description})
      : dayInfo = DayInfoModel(feeling: feeling, description: description);

  DayBoxModel.withDayInfo({required this.date, required this.dayInfo});

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
