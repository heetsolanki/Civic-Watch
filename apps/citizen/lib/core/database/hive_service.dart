import 'package:citizen/exports.dart';

final class HiveService {
  HiveService._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    Hive.registerAdapter(ReportAdapter());

    await Hive.deleteBoxFromDisk(HiveBoxes.reports);

    await Future.wait([
      Hive.openBox<Report>(HiveBoxes.reports),
      Hive.openBox(HiveBoxes.drafts),
      Hive.openBox(HiveBoxes.profile),
      Hive.openBox(HiveBoxes.settings),
      Hive.openBox(HiveBoxes.notifications),
    ]);
    _initialized = true;
  }
}