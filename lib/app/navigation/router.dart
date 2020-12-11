import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/pages/main_page/main_page.dart';
import 'package:multi_platform_course/data/core/service_locator.dart';

const ROOT = '/';
const EMPLOYEES_VIEW = '/employees';
const POSITION_VIEW = '/positions';

Map<String, WidgetBuilder> routes = {
  ROOT: (_) => MainPage(bloc: sl()),
  EMPLOYEES_VIEW: (_) => null,
  POSITION_VIEW: (_) => null,
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  switch (name) {
    default:
      throw Exception('No root specified');
  }
}
