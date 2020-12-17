import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

abstract class EmployeeFilterBlocEvent extends Equatable {}

class EmployeeFilterBlocLoadEvent extends EmployeeFilterBlocEvent {
  @override
  List<Object> get props => [];
}

class EmployeeFilterBlocChangeSort extends EmployeeFilterBlocEvent {
  final SortField sortField;

  EmployeeFilterBlocChangeSort(this.sortField);

  @override
  List<Object> get props => [sortField];
}

class EmployeeFilterBlocDeleteEvent extends EmployeeFilterBlocEvent {
  final Employee employee;

  EmployeeFilterBlocDeleteEvent(this.employee);

  @override
  List<Object> get props => [employee];
}
