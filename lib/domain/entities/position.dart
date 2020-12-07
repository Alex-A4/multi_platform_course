import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Сущность должности в компании
class Position extends Equatable {
  final int id;
  final String title;
  final String department;
  final double salary;
  final int workplaceCount;
  final PositionRequirements requirements;

  Position({
    @required this.id,
    @required this.title,
    @required this.department,
    @required this.salary,
    @required this.workplaceCount,
    @required this.requirements,
  });

  @override
  List<Object> get props =>
      [id, title, department, salary, workplaceCount, requirements];
}

/// Сущность требований к должности
class PositionRequirements extends Equatable {
  /// Ограниченая по возрасту, опциональны
  final int minAge;
  final int maxAge;

  final String education;
  final String specialization;

  PositionRequirements({
    @required this.education,
    @required this.specialization,
    this.minAge,
    this.maxAge,
  });

  @override
  List<Object> get props => [education, specialization, minAge, maxAge];
}
