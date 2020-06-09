import 'package:flutter/foundation.dart';
import 'package:year_in_pixels/data/dayBoxDAO.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';
import 'package:year_in_pixels/models/feelingModel.dart';

class GridController extends ChangeNotifier {
  List<DayBoxModel> days;
  int year;
  DayBoxDAO _dayBoxDAO;

  GridController() {
    year = DateTime.now().year;
    days = [];
    _dayBoxDAO = DayBoxDAO();
    _dayBoxDAO.getAllDays(year).then((daysList) {
      if (daysList.isEmpty) {
        _dayBoxDAO.createAllDays(year).then((newList) => updateDays(newList));
      } else {
        updateDays(daysList);
      }
    });
  }

  void updateDays(List<DayBoxModel> daysList) {
    days = daysList;
    notifyListeners();
  }

  FeelingModel getDayFeeling(int index) {
    return days[index].feeling;
  }

  DateTime getDayDate(int index) {
    return days[index].date;
  }

  void setDayFeeling(int index, FeelingModel feeling) {
    days[index].setFeeling(feeling);
    _dayBoxDAO.update(days[index]);
  }
}
