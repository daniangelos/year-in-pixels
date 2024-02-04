import 'package:flutter/foundation.dart';
import 'package:year_in_pixels/data/dayBoxDAO.dart';
import 'package:year_in_pixels/models/dayInfoModel.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';

class GridController extends ChangeNotifier {
  List<DayBoxModel> days = [];
  late int year;
  late DayBoxDAO _dayBoxDAO;

  GridController() {
    year = DateTime.now().year;
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

  void setDay(int index, DayInfoModel model) {
    days[index].setDayInfo(model);
    _dayBoxDAO.update(days[index]);
  }
}
