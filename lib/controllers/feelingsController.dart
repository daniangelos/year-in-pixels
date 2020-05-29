import 'package:flutter/material.dart';
import 'package:year_in_pixels/models/feelingModel.dart';

class FeelingsController {
  List<FeelingModel> feelings;

  FeelingsController() {
    feelings = FeelingModel.getAllFeelings();
  }

  FeelingModel getFeelingByColor(Color color) {
    return feelings.firstWhere((feeling) => feeling.color.value == color.value);
  }
}
