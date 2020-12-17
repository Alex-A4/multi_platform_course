import 'package:bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/employee_page/bloc/basic_page/bloc.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

/// Блок, который позволяет загружать информацию о сотрудниках без фильтров
class SimpleEmployeeBloc
    extends Bloc<SimpleEmployeeBlocEvent, SimpleEmployeeBlocState> {
  final CompanyRepository repository;

  SimpleEmployeeBloc(this.repository) : super(SimpleEmployeeBlocDataState([])) {
    add(SimpleEmployeeBlocLoadEvent());
  }

  final List<Employee> employees = [];

  @override
  Stream<SimpleEmployeeBlocState> mapEventToState(
      SimpleEmployeeBlocEvent event) async* {
    if (event is SimpleEmployeeBlocLoadEvent) {
      yield SimpleEmployeeBlocLoadingState(employees);
      try {
        final newData = await repository.getEmployees(employees.length, 15);
        if (newData.isNotEmpty) {
          employees.addAll(newData);
          yield SimpleEmployeeBlocDataState(List.from(employees));
        } else {
          yield SimpleEmployeeBlocDataState(List.from(employees), true);
        }
      } catch (e) {
        print(e);
        yield SimpleEmployeeBlocDataState(List.from(employees), true);
      }
    }
    if (event is SimpleEmployeeBlocDeleteEvent) {
      print(event.employee.id);
      await repository.deleteEmployee(event.employee);
      print(employees.remove(event.employee));
      yield SimpleEmployeeBlocDataState(List.from(employees));
    }
  }
}
