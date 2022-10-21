import 'package:flutter/material.dart';
import 'package:googlemap_demo/src/Page/GoogleMap/map_screen.dart';
///import 'package:googlemap_demo/src/Page/GoogleLocation/google_location.dart';
import 'package:googlemap_demo/src/Page/GoogleMap/search_screen.dart';
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
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}