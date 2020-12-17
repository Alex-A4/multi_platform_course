import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

abstract class SimpleEmployeeBlocEvent extends Equatable {}

class SimpleEmployeeBlocLoadEvent extends SimpleEmployeeBlocEvent {
  @override
  List<Object> get props => [];
}

class SimpleEmployeeBlocDeleteEvent extends SimpleEmployeeBlocEvent {
  final Employee employee;

  SimpleEmployeeBlocDeleteEvent(this.employee);

  @override
  List<Object> get props => [employee];
}
