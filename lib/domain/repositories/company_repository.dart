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
}
