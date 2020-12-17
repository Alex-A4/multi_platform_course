import 'package:bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/employee_page/bloc/filter_page/bloc.dart';
import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

/// Блок для просмотра работников с возможностью их фильтрации по полю [sortField]
class EmployeeFilterBloc
    extends Bloc<EmployeeFilterBlocEvent, EmployeeFilterBlocState> {
  final CompanyRepository repository;

  EmployeeFilterBloc(this.repository)
      : super(EmployeeFilterBlocDataState([], SortField.Position)) {
    add(EmployeeFilterBlocLoadEvent());
  }

  final List<Employee> employees = [];
  SortField sortField = SortField.Position;

  @override
  Stream<EmployeeFilterBlocState> mapEventToState(
      EmployeeFilterBlocEvent event) async* {
    if (event is EmployeeFilterBlocLoadEvent) {
      yield EmployeeFilterBlocLoadingState(List.from(employees), sortField);
      try {
        final newData = await repository.getSortedEmployees(
            SortType.ASC, sortField, employees.length, 15);
        if (newData.isNotEmpty) {
          employees.addAll(newData);
          yield EmployeeFilterBlocDataState(List.from(employees), sortField);
        } else {
          yield EmployeeFilterBlocDataState(
              List.from(employees), sortField, true);
        }
      } catch (e) {
        print(e);
        yield EmployeeFilterBlocDataState(
            List.from(employees), sortField, true);
      }
    }
    if (event is EmployeeFilterBlocChangeSort) {
      if (event.sortField != sortField) {
        sortField = event.sortField;
        employees.clear();
        add(EmployeeFilterBlocLoadEvent());
      }
    }
    if (event is EmployeeFilterBlocDeleteEvent) {
      print(event.employee.id);
      await repository.deleteEmployee(event.employee);
      print(employees.remove(event.employee));
      yield EmployeeFilterBlocDataState(List.from(employees), sortField);
    }
  }
}
