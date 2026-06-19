import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class CivicWatchApp extends StatelessWidget {

  const CivicWatchApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      debugShowCheckedModeBanner:false,
      theme:AppTheme.light,
      routerConfig:router,
    );
  }
}