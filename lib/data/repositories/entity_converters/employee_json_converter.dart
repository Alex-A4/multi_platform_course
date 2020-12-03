import 'dart:convert' show json;

import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/repositories/entity_encoder.dart';

class EmployeeJsonConverter extends EntityConverter<Employee> {
  @override
  Employee convertFromStringImpl(String str) {
    final map = json.decode(str);

    return Employee(
      age: map['age'],
      specialization: map['specialization'],
      education: map['education'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'],
    );
  }

  @override
  String convertToStringImpl(Employee emp) {
    final data = {
      'age': emp.age,
      'specialization': emp.specialization,
      'education': emp.education,
      'firstName': emp.firstName,
      'lastName': emp.lastName,
      'middleName': emp.middleName,
    };

    return json.encode(data);
  }

  @override
  Employee convertFromMapImpl(Map<String, dynamic> map) {
    return Employee(
      age: map['age'],
      specialization: map['specialization'],
      education: map['education'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'],
    );
  }

  @override
  Map<String, dynamic> convertToMapImpl(Employee emp) {
    return {
      'age': emp.age,
      'specialization': emp.specialization,
      'education': emp.education,
      'firstName': emp.firstName,
      'lastName': emp.lastName,
      'middleName': emp.middleName,
    };
  }

  @override
  List<String> get fieldNames => [
        'age',
        'specialization',
        'education',
        'firstName',
        'lastName',
        'middleName',
      ];
}
