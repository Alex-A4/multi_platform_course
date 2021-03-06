import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Сущность работника
class Employee extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final int age;
  final String education;
  final String specialization;

  Employee({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.middleName,
    @required this.age,
    @required this.education,
    @required this.specialization,
  });

  @override
  List<Object> get props =>
      [id, firstName, lastName, middleName, age, education, specialization];
}
