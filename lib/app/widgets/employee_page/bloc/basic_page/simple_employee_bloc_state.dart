import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

abstract class SimpleEmployeeBlocState extends Equatable {}

class SimpleEmployeeBlocLoadingState extends SimpleEmployeeBlocState {
  final List<Employee> employees;

  SimpleEmployeeBlocLoadingState(this.employees);

  @override
  List<Object> get props => [employees];
}

class SimpleEmployeeBlocDataState extends SimpleEmployeeBlocState {
  final List<Employee> employees;
  final bool isEndOfList;

  SimpleEmployeeBlocDataState(this.employees, [this.isEndOfList = false]);

  @override
  List<Object> get props => [employees];
}
