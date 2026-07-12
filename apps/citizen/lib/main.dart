import 'exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await HiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              ReportsProvider(ReportRepository(ReportLocalDataSource()))
                ..loadReports(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              DraftProvider(DraftRepository(DraftLocalDataSource()))
                ..loadDrafts(),
        ),
      ],
      child: const CivicWatchApp(),
    ),
  );
}
