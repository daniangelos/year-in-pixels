import 'package:sembast/sembast.dart';
import 'package:year_in_pixels/data/appDatabase.dart';
import 'package:year_in_pixels/models/dayBoxModel.dart';

import '../util.dart';

class DayBoxDAO {
  static const String DAY_STORE_NAME = 'days';
  final _dayStore = intMapStoreFactory.store(DAY_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(DayBoxModel dayBox) async {
    await _dayStore.add(await _db, dayBox.toMap());
  }

  Future update(DayBoxModel dayBox) async {
    final finder = Finder(filter: Filter.byKey(dayBox.id));
    await _dayStore.update(
      await _db,
      dayBox.toMap(),
      finder: finder,
    );
  }

  Future delete(DayBoxModel dayBox) async {
    final finder = Finder(filter: Filter.byKey(dayBox.id));
    await _dayStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<DayBoxModel>> getAllDays(int year) async {
    final finder = Finder(sortOrders: [
      SortOrder('date'),
    ], filter: Filter.equals('year', year));

    final recordSnapshots = await _dayStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final dayBox = DayBoxModel.fromMap(snapshot.value);
      dayBox.id = snapshot.key;
      return dayBox;
    }).toList();
  }

  Future<List<DayBoxModel>> createAllDays(int year) async {
    List<int> numberOfDaysPerMonth = getAllNumberOfDaysPerMonth(year);

    for (int month = 1; month <= 12; month++) {
      for (int day = 1; day <= numberOfDaysPerMonth[month - 1]; day++) {
        await insert(DayBoxModel(date: DateTime.utc(year, month, day)));
      }
    }

    return getAllDays(year);
  }
}
