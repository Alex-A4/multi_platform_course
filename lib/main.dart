import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/navigation/router.dart';
import 'package:multi_platform_course/data/core/service_locator.dart';

void main() {
  initServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: ROOT,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
