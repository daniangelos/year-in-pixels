import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:year_in_pixels/data/appDatabase.dart';
import 'package:year_in_pixels/models/feelingModel.dart';
import 'package:year_in_pixels/models/feelingsCollectionModel.dart';

class FeelingsDAO {
  static const String FEELINGS_STORE_NAME = 'feelings';
  final _feelingsStore = intMapStoreFactory.store(FEELINGS_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(FeelingsCollectionModel feelings) async {
    await _feelingsStore.add(await _db, feelings.toMap());
  }

  Future update(FeelingsCollectionModel feelings) async {
    final finder = Finder(filter: Filter.byKey(feelings.id));
    await _feelingsStore.update(
      await _db,
      feelings.toMap(),
      finder: finder,
    );
  }

  Future delete(FeelingsCollectionModel feelings) async {
    final finder = Finder(filter: Filter.byKey(feelings.id));
    await _feelingsStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<FeelingsCollectionModel> getAllFeelings(int year) async {
    final snapshot = await _feelingsStore.findFirst(
      await _db,
    );

    if (snapshot == null) return null;

    final feelings = FeelingsCollectionModel.fromMap(snapshot.value);
    feelings.id = snapshot.key;
    return feelings;
  }

  static Random random = new Random();

  Future<FeelingsCollectionModel> createDefaultCollection(int year) async {
    List<Color> colors = [
      Colors.pink,
      Colors.black,
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
    ];

    List<String> descriptions = [
      "Marvelous",
      "Very Sad",
      "Normal",
      "Stressed",
      "Productive",
      "Happy",
    ];

    List<FeelingModel> feelings = List<FeelingModel>();
    for (int i = 0; i < 6; i++) {
      feelings
          .add(FeelingModel(color: colors[i], description: descriptions[i]));
    }

    await insert(FeelingsCollectionModel(feelings: feelings));

    return getAllFeelings(year);
  }
}
