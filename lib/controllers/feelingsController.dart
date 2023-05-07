import 'package:flutter/material.dart';
import 'package:year_in_pixels/data/feelingsCollectionDAO.dart';
import 'package:year_in_pixels/models/feelingModel.dart';
import 'package:year_in_pixels/models/feelingsCollectionModel.dart';

class FeelingsController extends ChangeNotifier {
  FeelingsCollectionModel feelingsCollection;
  FeelingsDAO _feelingsDAO;

  FeelingsController() {
    int year = DateTime.now().year;
    _feelingsDAO = FeelingsDAO();
    _feelingsDAO.getAllFeelings(year).then((collection) {
      updateFeelings(collection);
    });
  }

  void updateFeelings(FeelingsCollectionModel collection) {
    feelingsCollection = collection;
    notifyListeners();
  }

  FeelingModel getFeelingByColor(Color color) {
    return feelingsCollection.feelings
        .firstWhere((feeling) => feeling.color.value == color.value);
  }
}
