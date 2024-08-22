import 'package:flutter/material.dart';
import 'package:year_in_pixels/data/feelings_collection_dao.dart';
import 'package:year_in_pixels/models/feeling_model.dart';
import 'package:year_in_pixels/models/feelings_collection_model.dart';

class FeelingsController extends ChangeNotifier {
  late FeelingsCollectionModel feelingsCollection;
  late FeelingsDAO _feelingsDAO;

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
