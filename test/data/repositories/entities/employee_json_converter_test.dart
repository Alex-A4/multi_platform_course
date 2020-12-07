import 'dart:convert' show json;

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_platform_course/data/repositories/entity_converters/employee_json_converter.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

void main() {
  EmployeeJsonConverter converter;
  setUp(() {
    converter = EmployeeJsonConverter();
  });

  group('convertFromString', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          converter.convertFromString(null);
        } catch (e) {
          // assert
          expect(e, isA<ArgumentError>());
        }
      },
    );

    test(
      'должен корректно конвертировать данные из строки',
      () async {
        // arrange
        final data = {
          'id': 13,
          'age': 21,
          'specialization': 'Мобильная разработка',
          'education': 'Высшее техническое',
          'lastName': 'Адрианов',
          'firstName': 'Алексей',
          'middleName': 'Сергеевич',
        };

        // act
        final emp = converter.convertFromString(json.encode(data));

        // assert
        expect(emp.id, 13);
        expect(emp.age, 21);
        expect(emp.specialization, 'Мобильная разработка');
        expect(emp.education, 'Высшее техническое');
        expect(emp.lastName, 'Адрианов');
        expect(emp.firstName, 'Алексей');
        expect(emp.middleName, 'Сергеевич');
      },
    );
  });

  group('convertToString', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          converter.convertToString(null);
        } catch (e) {
          // assert
          expect(e, isA<ArgumentError>());
        }
      },
    );

    test(
      'должен корректно конвертировать данные в строку',
      () async {
        // arrange
        final data = {
          'id': 13,
          'age': 21,
          'specialization': 'Мобильная разработка',
          'education': 'Высшее техническое',
          'firstName': 'Алексей',
          'lastName': 'Адрианов',
          'middleName': 'Сергеевич',
        };
        final emp = Employee(
          id: 13,
          age: 21,
          middleName: 'Сергеевич',
          lastName: 'Адрианов',
          firstName: 'Алексей',
          education: 'Высшее техническое',
          specialization: 'Мобильная разработка',
        );

        // act
        final str = converter.convertToString(emp);

        // assert
        expect(str, json.encode(data));
      },
    );
  });

  group('convertFromMap', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          converter.convertFromMap(null);
        } catch (e) {
          // assert
          expect(e, isA<ArgumentError>());
        }
      },
    );

    test(
      'должен корректно конвертировать данные из словаря',
      () async {
        // arrange
        final data = {
          'id': 13,
          'age': 21,
          'specialization': 'Мобильная разработка',
          'education': 'Высшее техническое',
          'firstName': 'Алексей',
          'lastName': 'Адрианов',
          'middleName': 'Сергеевич',
        };

        // act
        final emp = converter.convertFromMap(data);

        // assert
        expect(emp.id, 13);
        expect(emp.age, 21);
        expect(emp.specialization, 'Мобильная разработка');
        expect(emp.education, 'Высшее техническое');
        expect(emp.lastName, 'Адрианов');
        expect(emp.firstName, 'Алексей');
        expect(emp.middleName, 'Сергеевич');
      },
    );
  });


  group('convertToMap', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          converter.convertToMap(null);
        } catch (e) {
          // assert
          expect(e, isA<ArgumentError>());
        }
      },
    );


    test(
      'должен корректно конвертировать данные в словарь',
      () async {
        // arrange
        final data = {
          'id': 13,
          'age': 21,
          'specialization': 'Мобильная разработка',
          'education': 'Высшее техническое',
          'firstName': 'Алексей',
          'lastName': 'Адрианов',
          'middleName': 'Сергеевич',
        };

        final emp = Employee(
          id: 13,
          age: 21,
          middleName: 'Сергеевич',
          lastName: 'Адрианов',
          firstName: 'Алексей',
          education: 'Высшее техническое',
          specialization: 'Мобильная разработка',
        );

        // act
        final map = converter.convertToMap(emp);

        // assert
        expect(map, equals(data));
      },
    );
  });
}
