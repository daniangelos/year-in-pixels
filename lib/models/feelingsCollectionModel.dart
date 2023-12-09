import 'package:year_in_pixels/models/feelingModel.dart';

class FeelingsCollectionModel {
  List<FeelingModel> feelings;
  late int id;
  int year;

  FeelingsCollectionModel({required this.feelings, required this.year});

  Map<String, dynamic> toMap() {
    return {
      'feelings': feelings?.map((feeling) => feeling.toMap())?.toList(),
      'year': year
    };
  }

  static FeelingsCollectionModel fromMap(Map<String, dynamic> map) {
    return FeelingsCollectionModel(
        feelings: map['feelings']
            .map((mapping) => FeelingModel.fromMap(mapping))
            .toList()
            .cast<FeelingModel>(),
        year: map['year']);
  }
}
