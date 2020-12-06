import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/repositories/entity_encoder.dart';

/// Хелпер БД, который позволяет универсально вставлять и получать данные
mixin EntityDatabaseHelper on CompanyDatabase {
  /// Получение списка записей по отступу с указанным количеством.
  /// Сущности конвертируются в словарь.
  Future<List<T>> getEntities<T>(EntityConverter<T> converter, String tableName,
      int offset, int limit) async {
    final db = await database;
    final data = await db.query(tableName, limit: limit, offset: offset);
    return data.map<T>((e) => converter.convertFromMap(e)).toList();
  }

  /// Добавление сущности в базу, используется конвертация в словарь
  Future<int> addEntity<T>(
      EntityConverter<T> converter, String tableName, T entity) async {
    final db = await database;
    return await db.insert(tableName, converter.convertToMap(entity));
  }

  /// Удаление записи из таблицы
  Future<int> deleteEntity(
      String tableName, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }
}
