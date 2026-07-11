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
              ReportProvider(ReportRepository(ReportLocalDataSource()))
                ..loadReports(),
        ),
      ],
      child: const CivicWatchApp(),
    ),
  );
}
