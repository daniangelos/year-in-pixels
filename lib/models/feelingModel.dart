import 'package:flutter/material.dart';

class FeelingModel {
  Color color;
  String description;

  FeelingModel({required this.color, required this.description});

  static List colors = [
    Color.fromARGB(255, 217, 217, 217),
    Colors.pink,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  static List<String> descriptions = [
    "",
    "Marvelous",
    "Very Sad",
    "Normal",
    "Stressed",
    "Productive",
    "Happy",
  ];

  static List<FeelingModel> getDefaultFeelings() {
    List<FeelingModel> feelings = [];
    for (int i = 1; i < 7; i++) {
      feelings
          .add(FeelingModel(color: colors[i], description: descriptions[i]));
    }

    return feelings;
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'description': description,
    };
  }

  static FeelingModel fromMap(Map<String, dynamic> map) {
    return FeelingModel(
        color: Color(map['color']), description: map['description']);
  }
}
