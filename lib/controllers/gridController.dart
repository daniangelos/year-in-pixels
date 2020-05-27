import 'package:year_in_pixels/models/dayBoxModel.dart';
import 'package:year_in_pixels/models/feelingModel.dart';

class GridController {
  List<DayBoxModel> days;
  int year;

  GridController() {
    year = DateTime.now().year;
    days = DayBoxModel.getAllDays(year);
  }

  FeelingModel getDayFeeling(int index) {
    return days[index].feeling;
  }

  DateTime getDayDate(int index) {
    return days[index].date;
  }

  void setDayFeeling(int index, FeelingModel feeling) {
    days[index].setFeeling(feeling);
  }
}
