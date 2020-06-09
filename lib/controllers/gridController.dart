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
      updateDays(daysList);
    });
  }

  void updateDays(List<DayBoxModel> daysList) {
    days = daysList;
    notifyListeners();
  }

  DayBoxModel getDayByID(int index) {
    return days[index];
  }

  void setDay(int index, DayBoxModel model) {
    days[index].setFeeling(model.feeling);
    days[index].setDescription(model.description);
    _dayBoxDAO.update(days[index]);
  }

  void setDayFeeling(int index, FeelingModel feeling) {
    days[index].setFeeling(feeling);
    _dayBoxDAO.update(days[index]);
  }
}
