import 'package:citizen/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  runApp(const CivicWatchApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
