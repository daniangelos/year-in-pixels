import 'feeling_model.dart';

class DayInfoModel {
  FeelingModel feeling;
  String? description;

  DayInfoModel({required this.feeling, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'feeling': feeling.toMap(),
      'description': description,
    };
  }

  static DayInfoModel fromMap(Map<String, dynamic> map) {
    return DayInfoModel(
        feeling: FeelingModel.fromMap(map['feeling']),
        description: map['description']);
  }
}
