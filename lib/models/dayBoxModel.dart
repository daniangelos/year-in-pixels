import 'package:sembast/timestamp.dart';

import 'feelingModel.dart';

class DayBoxModel {
  FeelingModel feeling;
  String description;
  final DateTime date;
  final int year;
  int id;

  DayBoxModel({this.date, this.feeling, this.description}) : year = date.year;

  // We are converting from DateTime to Timestamp
  // because Sembast doesn't accept DateTime type
  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDateTime(date),
      'year': year,
      'feeling': feeling.toMap(),
      'description': description
    };
  }

  static DayBoxModel fromMap(Map<String, dynamic> map) {
    return DayBoxModel(
        date: map['date'].toDateTime(isUtc: true),
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
