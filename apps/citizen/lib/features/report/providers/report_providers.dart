import 'package:citizen/exports.dart' hide Provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportLocalSourceProvider = Provider<ReportLocalDataSource>((ref) {
  return ReportLocalDataSource();
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  return ReportRepository(ref.read(reportLocalSourceProvider));
});
