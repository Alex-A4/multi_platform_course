import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:sqflite/sqflite.dart';

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

  /// Получение списка должностей
  Future<List<Position>> getPositions(int offset, int limit);

  /// Добавление новой должности
  Future<int> addPosition(Position pos);
}
