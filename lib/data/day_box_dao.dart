
import 'package:sembast/sembast.dart';
import 'package:year_in_pixels/data/app_database.dart';
import 'package:year_in_pixels/helpers/util.dart';
import 'package:year_in_pixels/models/day_box_model.dart';
import 'package:year_in_pixels/models/feeling_model.dart';

class DayBoxDAO {
  static const String dayStoreName = 'days';
  final _dayStore = intMapStoreFactory.store(dayStoreName);
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

    List<DayBoxModel> daysList = recordSnapshots.map((snapshot) {
      final dayBox = DayBoxModel.fromMap(snapshot.value);
      dayBox.id = snapshot.key;
      return dayBox;
    }).toList();

    if (daysList.isEmpty) {
      daysList = await createAllDays(year);
    }
    return daysList;
  }

  Future<List<DayBoxModel>> createAllDays(int year) async {
    List<int> numberOfDaysPerMonth = getAllNumberOfDaysPerMonth(year);

    for (int month = 1; month <= 12; month++) {
      for (int day = 1; day <= numberOfDaysPerMonth[month - 1]; day++) {
        await insert(DayBoxModel(
            date: DayBoxDate(day: day, month: month, year: year),
            description: "",
            feeling: FeelingModel(
                color: FeelingModel.colors[0],
                description: FeelingModel.descriptions[0])));
      }
    }

    return getAllDays(year);
  }
}
