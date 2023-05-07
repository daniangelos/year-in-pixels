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

  Future<int> insert(FeelingsCollectionModel feelings) async {
    return _feelingsStore.add(await _db, feelings.toMap());
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
    final finder = Finder(filter: Filter.equals('year', year));
    final snapshot = await _feelingsStore.findFirst(await _db, finder: finder);

    if (snapshot == null) {
      final feelings = await createDefaultCollection(year);
      return feelings;
    }

    final feelings = FeelingsCollectionModel.fromMap(snapshot.value);
    feelings.id = snapshot.key;

    return feelings;
  }

  Future<FeelingsCollectionModel> createDefaultCollection(int year) async {
    final defaultFeelingsCollection = FeelingsCollectionModel(
        feelings: FeelingModel.getDefaultFeelings(), year: year);

    defaultFeelingsCollection.id = await insert(defaultFeelingsCollection);
    return defaultFeelingsCollection;
  }
}
