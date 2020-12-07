import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

/// Репозиторий компании, который предоставляет доступ к данным
abstract class CompanyRepository {
  /// Получение должностей компании
  Future<List<Position>> getPositions(int offset, int limit);

  /// Получение работников компании
  Future<List<Employee>> getEmployees(int offset, int limit);

  /// Добавление работника
  Future<void> addEmployee(Employee employee);

  /// Удаление работника
  Future<void> deleteEmployee(Employee employee);

  /// Добавление должности
  Future<void> addPosition(Position position);

  /// Добавление должности
  Future<void> deletePosition(Position position);

  /// Получение списка открытых вакансий
  Future<List<Position>> getOpenPositions();

  /// Получение позиции, на которой работает указанный сотрудник.
  /// Возвращает null, если позиция не указана.
  Future<Position> getEmployeePosition(Employee emp);

  /// Получение работника, который работает на данной должности.
  /// Возвращает null, если работника такого нет.
  Future<Employee> getEmployeeAtPosition(Position pos);

  /// Связываем работника и должность
  Future<void> linkPositionAndEmployee(Position pos, Employee emp);

  /// Получение сотрудников(заняты должности) с сортировкой [sort].
  Future<List<Employee>> getSortedEmployees(
      SortType sort, SortField field, int offset, int limit);
}
