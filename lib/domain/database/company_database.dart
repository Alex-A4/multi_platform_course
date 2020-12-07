import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:sqflite/sqflite.dart';

/// База данных компании, которая позволяет обращаться к данным и делать запросы
abstract class CompanyDatabase {
  /// Экземпляр базы, который висит в памяти при работе
  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<Database> initDatabase();

  /// Получение списка работников
  Future<List<Employee>> getEmployees(int offset, int limit);

  /// Добавление нового работника
  Future<int> addEmployee(Employee emp);

  /// Удаление сотрудника
  Future<int> deleteEmployee(Employee emp);

  /// Получение позиции, на которой работает указанный сотрудник.
  /// Возвращает null, если позиция не указана.
  Future<Position> getEmployeePosition(Employee emp);

  /// Получение списка должностей
  Future<List<Position>> getPositions(int offset, int limit);

  /// Добавление новой должности
  Future<int> addPosition(Position pos);

  /// Удаление должности
  Future<int> deletePosition(Position pos);

  /// Получение работника, который работает на данной должности.
  /// Возвращает null, если работника такого нет.
  Future<Employee> getEmployeeAtPosition(Position pos);

  /// Связываем работника и должность
  Future<void> linkPositionAndEmployee(Position pos, Employee emp);

  /// Получение списка не занятых должностей (в кросс-таблице нет данных по ним)
  Future<List<Position>> getOpenPositions();

  Future<void> calculateMonthSalary();
}
