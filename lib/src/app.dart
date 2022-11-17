import 'package:flutter/material.dart';
import 'package:googlemap_demo/src/Page/GoogleLocation/google_Map_Screen_vc.dart';

import 'Repository/Services/Navigation/navigation_service.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}