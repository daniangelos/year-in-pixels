import 'package:year_in_pixels/models/feelingModel.dart';

class FeelingsCollectionModel {
  List<FeelingModel> feelings;
  int id;

  FeelingsCollectionModel({this.feelings});

  Map<String, dynamic> toMap() {
    return {'feelings': feelings?.map((feeling) => feeling.toMap())?.toList()};
  }

  static FeelingsCollectionModel fromMap(Map<String, dynamic> map) {
    return FeelingsCollectionModel(
        feelings: map['feelings']
            .map((mapping) => FeelingModel.fromMap(mapping))
            .toList()
            .cast<FeelingModel>());
  }
}
