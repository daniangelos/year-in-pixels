import 'package:flutter/material.dart';

class FeelingModel {
  Color color;
  String description;

  FeelingModel(this.color, this.description);

  static List colors = [
    Colors.pink,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  static List<String> descriptions = [
    "Marvelous",
    "Very Sad",
    "Normal",
    "Stressed",
    "Productive",
    "Happy",
  ];

  static List<FeelingModel> getAllFeelings() {
    List<FeelingModel> feelings = List<FeelingModel>();
    for (int i = 0; i < 6; i++) {
      feelings.add(FeelingModel(colors[i], descriptions[i]));
    }

    return feelings;
  }
}
