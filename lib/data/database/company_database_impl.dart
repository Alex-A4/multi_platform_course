import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/database/entity_database_helper.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/providers/path_provider.dart';
import 'package:multi_platform_course/domain/repositories/entity_encoder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

/// Реализация базы данных компании, которая позволяет получать и добавлять
/// новые данные о работниках и должностях.
class CompanyDatabaseImpl extends CompanyDatabase with EntityDatabaseHelper {
  static const EMPLOYEE_TABLE = 'Employees';
  static const POSITION_TABLE = 'Positions';

  /// Смежная таблица, которая показывает, какой сотруднк, какую должность занимает
  static const CROSS_TABLE = 'EmployeePosition';

  final EntityConverter<Employee> employeeConverter;
  final EntityConverter<Position> positionConverter;
  final PathProvider pathProvider;

  CompanyDatabaseImpl(
      this.employeeConverter, this.positionConverter, this.pathProvider);

  @override
  Future<int> addEmployee(Employee emp) =>
      addEntity<Employee>(employeeConverter, EMPLOYEE_TABLE, emp);

  @override
  Future<List<Employee>> getEmployees(int offset, int limit) =>
      getEntities<Employee>(employeeConverter, EMPLOYEE_TABLE, offset, limit);

  @override
  Future<int> deleteEmployee(Employee emp) => deleteEntity(
        EMPLOYEE_TABLE,
        'firstName = ?, lastName = ?, middleName = ?, age = ?',
        [emp.firstName, emp.lastName, emp.middleName, emp.age],
      );

  @override
  Future<int> addPosition(Position pos) =>
      addEntity<Position>(positionConverter, POSITION_TABLE, pos);

  @override
  Future<List<Position>> getPositions(int offset, int limit) =>
      getEntities<Position>(positionConverter, POSITION_TABLE, offset, limit);

  @override
  Future<Database> initDatabase() async {
    final path = await pathProvider.concatWithRoot('company.db');
    return openDatabase(path, version: 1, onOpen: (db) async {
      await db.execute(
        '''
        CREATE TABLE IF NOT EXISTS $EMPLOYEE_TABLE (
          employee_id     INTEGER PRIMARY KEY NOT NULL,
          age             TEXT NOT NULL,
          specialization  TEXT NOT NULL,
          education       TEXT NOT NULL,
          firstName       TEXT NOT NULL,
          lastName        TEXT NOT NULL,
          middleName      TEXT NOT NULL,
        )''',
      );

      await db.execute(
        '''
        CREATE TABLE IF NOT EXISTS $POSITION_TABLE (
          position_id     INTEGER PRIMARY KEY NOT NULL,
          title           TEXT NOT NULL,
          department      TEXT NOT NULL,
          salary          REAL NOT NULL,
          workplaceCount  INTEGER NOT NULL,
          requirements    TEXT NOT NULL,
        )''',
      );

      await db.execute(
        '''
        CREATE TABLE IF NOT EXISTS $CROSS_TABLE (
          id            INTEGER PRIMARY KEY NOT NULL,
          employee_id   INTEGER NOT NULL,
          position_id   INTEGER NOT NULL,
          
          FOREIGN KEY (employee_id)
            REFERENCES Employee(employee_id)
              ON UPDATE NO ACTION
              ON DELETE CASCADE
          FOREIGN KEY (position_id)
            REFERENCES Position(position_id)
              ON UPDATE NO ACTION
              ON DELETE CASCADE
        )''',
      );
    });
  }

  @override
  Future<void> calculateMonthSalary() {
    return null;
  }

  @override
  Future<int> deletePosition(Position pos) => deleteEntity(
        POSITION_TABLE,
        'title = ?, department = ?, salary = ?',
        [pos.title, pos.department, pos.salary],
      );

  @override
  Future<List<Position>> getOpenPositions() async {
    final db = await database;
    final data = await db.rawQuery(
      '''
      SELECT * FROM $POSITION_TABLE 
      WHERE position_id NOT IN (SELECT position_id FROM $CROSS_TABLE)
      ''',
    );
    return data
        .map<Position>((e) => positionConverter.convertFromMap(e))
        .toList();
  }
}
