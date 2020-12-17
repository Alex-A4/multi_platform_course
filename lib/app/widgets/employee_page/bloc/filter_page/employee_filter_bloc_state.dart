import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

abstract class EmployeeFilterBlocState extends Equatable {}

class EmployeeFilterBlocDataState extends EmployeeFilterBlocState {
  final List<Employee> employees;
  final SortField sortField;
  final bool isEndOfList;

  EmployeeFilterBlocDataState(this.employees, this.sortField,
      [this.isEndOfList = false]);

  @override
  List<Object> get props => [employees, sortField, isEndOfList];
}

class EmployeeFilterBlocLoadingState extends EmployeeFilterBlocState {
  final List<Employee> employees;
  final SortField sortField;

  EmployeeFilterBlocLoadingState(this.employees, this.sortField);

  @override
  List<Object> get props => [employees, sortField];
}
