
import 'package:sembast/sembast.dart';
import 'package:year_in_pixels/data/app_database.dart';
import 'package:year_in_pixels/models/feeling_model.dart';
import 'package:year_in_pixels/models/feelings_collection_model.dart';

class FeelingsDAO {
  static const String feelingsStoreName = 'feelings';
  final _feelingsStore = intMapStoreFactory.store(feelingsStoreName);
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
