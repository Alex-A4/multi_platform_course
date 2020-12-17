import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/pages/employee_page/employee_add_page.dart';
import 'package:multi_platform_course/app/pages/employee_page/employee_fitter_page.dart';
import 'package:multi_platform_course/app/pages/employee_page/employee_view_page.dart';
import 'package:multi_platform_course/app/pages/main_page/main_page.dart';
import 'package:multi_platform_course/data/core/service_locator.dart';

const ROOT = '/';
const EMPLOYEES_VIEW = '/employees';
const EMPLOYEES_VIEW_FILTER = '/employees_filter';
const EMPLOYEE_ADD = '/employee/add';
const POSITION_VIEW = '/positions';

Map<String, WidgetBuilder> routes = {
  ROOT: (_) => MainPage(bloc: sl()),
  EMPLOYEES_VIEW: (_) => EmployeePage(bloc: sl()),
  EMPLOYEES_VIEW_FILTER: (_) => EmployeeFilterPage(bloc: sl()),
  EMPLOYEE_ADD: (_) => EmployeeAddPage(repository: sl()),
  POSITION_VIEW: (_) => null,
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  switch (name) {
    default:
      throw Exception('No root specified');
  }
}
