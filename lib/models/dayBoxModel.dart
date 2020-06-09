import 'package:sembast/timestamp.dart';

import 'feelingModel.dart';

class DayBoxModel {
  FeelingModel feeling;
  DateTime date;
  int id, year;

  DayBoxModel({this.date, this.feeling}) : year = date.year;

  // We are converting from DateTime to Timestamp
  // because Sembast doesn't accept DateTime type
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDateTime(date),
      'year': year,
      'feeling': feeling.toMap()
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel(
        date: map['date'].toDateTime(),
        feeling: FeelingModel.fromMap(map['feeling']));
  }

  void setFeeling(FeelingModel feeling) {
    this.feeling = feeling;
  }
}
