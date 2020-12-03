import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/repositories/entity_encoder.dart';
import 'dart:convert' show json;

/// JSON конвертер для должности компании
class PositionJsonConverter extends EntityConverter<Position> {
  final PositionRequirementsJsonConverter requirementsConverter;

  PositionJsonConverter(this.requirementsConverter);

  @override
  Position convertFromStringImpl(String str) {
    final map = json.decode(str);

    return Position(
      title: map['title'],
      department: map['department'],
      requirements:
          requirementsConverter.convertFromString(map['requirements']),
      salary: map['salary'],
      workplaceCount: map['workplaceCount'],
    );
  }

  @override
  String convertToStringImpl(Position pos) {
    final data = {
      'title': pos.title,
      'department': pos.department,
      'salary': pos.salary,
      'workplaceCount': pos.workplaceCount,
      'requirements': requirementsConverter.convertToString(pos.requirements),
    };

    return json.encode(data);
  }

  @override
  Position convertFromMapImpl(Map<String, dynamic> map) {
    return Position(
      title: map['title'],
      department: map['department'],
      requirements:
          requirementsConverter.convertFromString(map['requirements']),
      salary: map['salary'],
      workplaceCount: map['workplaceCount'],
    );
  }

  @override
  Map<String, dynamic> convertToMapImpl(Position pos) {
    return {
      'title': pos.title,
      'department': pos.department,
      'salary': pos.salary,
      'workplaceCount': pos.workplaceCount,
      'requirements': requirementsConverter.convertToString(pos.requirements),
    };
  }

  @override
  List<String> get fieldNames =>
      ['title', 'department', 'salary', 'workplaceCount', 'requirements'];
}

/// JSON конвертер для требований к должности в компании
class PositionRequirementsJsonConverter
    extends EntityConverter<PositionRequirements> {
  @override
  PositionRequirements convertFromStringImpl(String str) {
    final map = json.decode(str);

    return PositionRequirements(
      education: map['education'],
      specialization: map['specialization'],
      maxAge: map['maxAge'],
      minAge: map['minAge'],
    );
  }

  @override
  String convertToStringImpl(PositionRequirements requirements) {
    final data = {
      'education': requirements.education,
      'specialization': requirements.specialization,
      'maxAge': requirements.maxAge,
      'minAge': requirements.minAge,
    };

    return json.encode(data);
  }

  @override
  PositionRequirements convertFromMapImpl(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> convertToMapImpl(PositionRequirements entity) {
    throw UnimplementedError();
  }

  @override
  List<String> get fieldNames => throw UnimplementedError();
}
