import 'package:flutter/cupertino.dart';

/// Вспомогательный класс-обертка, который позволяет конвертировать сущности
/// в строковый формат и обратно посредством некоторого алгоритма, например, json
abstract class EntityConverter<T> {
  /// Возвращает список полей класса, используется в БД
  List<String> get fieldNames;

  /// Функция-обертка, которая сама проверяет на null.
  T convertFromString(String str) {
    if (str == null) throw ArgumentError('String should not be null');
    return convertFromStringImpl(str);
  }

  /// Функция для конвертирования строки в объект
  @protected
  T convertFromStringImpl(String str);

  String convertToString(T entity) {
    if (entity == null) throw ArgumentError('Entity should not be null');
    return convertToStringImpl(entity);
  }

  /// Функция для конвертирования объекта в строку
  @protected
  String convertToStringImpl(T entity);

  /// Функция для конвертации объекта из словаря (json)
  T convertFromMap(Map<String, dynamic> map) {
    if (map == null) throw ArgumentError('Map should not be null');
    return convertFromMapImpl(map);
  }

  @protected
  T convertFromMapImpl(Map<String, dynamic> map);

  /// Функция для конвертации объекта в словарь (json)
  Map<String, dynamic> convertToMap(T entity) {
    if (entity == null) throw ArgumentError('Entity should not be null');
    return convertToMapImpl(entity);
  }

  Map<String, dynamic> convertToMapImpl(T entity);
}
