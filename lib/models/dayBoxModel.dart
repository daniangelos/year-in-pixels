import 'dart:math';
import '../util.dart';
import 'feelingModel.dart';

class DayBoxModel {
  FeelingModel feeling;
  DateTime date;
  int id;

  static Random random = new Random();

  DayBoxModel(this.id, this.date)
      : feeling = FeelingModel.getAllFeelings()[random.nextInt(6)];

  static List<DayBoxModel> getAllDays(int year) {
    // Mocked data
    List<int> numberOfDaysPerMonth = getAllNumberOfDaysPerMonth(year);
    List<DayBoxModel> allDays = List<DayBoxModel>();

    int currentId = 0;
    for (int month = 1; month <= 12; month++) {
      for (int day = 1; day <= numberOfDaysPerMonth[month - 1]; day++) {
        allDays.add(DayBoxModel(currentId++, DateTime.utc(year, month, day)));
      }
    }

    return allDays;
  }

  void setFeeling(FeelingModel feeling) {
    this.feeling = feeling;
  }
}
