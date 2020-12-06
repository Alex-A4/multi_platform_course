import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

/// Реализация репозитория, который предоставляет доступ к данным из базы
class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyDatabase database;

  CompanyRepositoryImpl(this.database);

  @override
  Future<List<Employee>> getEmployees(int offset, int limit) =>
      database.getEmployees(offset, limit);

  @override
  Future<List<Position>> getPositions(int offset, int limit) =>
      database.getPositions(offset, limit);

  @override
  Future<void> addEmployee(Employee employee) => database.addEmployee(employee);

  @override
  Future<void> addPosition(Position position) => database.addPosition(position);

  @override
  Future<void> deleteEmployee(Employee employee) =>
      database.deleteEmployee(employee);

  @override
  Future<void> deletePosition(Position position) =>
      database.deletePosition(position);

  @override
  Future<List<Position>> getOpenPositions() => database.getOpenPositions();
}
