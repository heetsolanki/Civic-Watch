import 'exports.dart';

void main() {
  runApp(const CivicWatchApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
