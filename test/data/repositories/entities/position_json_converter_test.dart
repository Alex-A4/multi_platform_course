import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_platform_course/data/repositories/entity_converters/position_json_converter.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

void main() {
  PositionRequirementsJsonConverter requirementsConverter;
  PositionJsonConverter positionConverter;

  setUp(() {
    requirementsConverter = PositionRequirementsJsonConverter();
    positionConverter = PositionJsonConverter(requirementsConverter);
  });

  group('PositionRequirementsJsonConverter.convertFromString', () {
    test(
      'должен выбрасывать ошибку, если передан null',
      () async {
        try {
          // act
          requirementsConverter.convertFromString(null);
        } catch (e) {
          // assert
          expect(e, isA<ArgumentError>());
        }
      },
    );

    test(
      'должен корректно корвертировать данные из строки',
      () async {
        // arrange
        final data = {
          'education': 'Высшее, техническое',
          'specialization': 'Мобильная разработка',
          'maxAge': 60,
          'minAge': 20
        };

        // act
        final req = requirementsConverter.convertFromString(json.encode(data));

        // assert
        expect(req.minAge, 20);
        expect(req.maxAge, 60);
        expect(req.education, 'Высшее, техническое');
        expect(req.specialization, 'Мобильная разработка');
      },
    );
  });

  group('PositionRequirementsJsonConverter.convertToString', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          requirementsConverter.convertToString(null);
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
          'education': 'Высшее, техническое',
          'specialization': 'Мобильная разработка',
          'maxAge': 60,
          'minAge': 20
        };
        final req = PositionRequirements(
          education: 'Высшее, техническое',
          specialization: 'Мобильная разработка',
          maxAge: 60,
          minAge: 20,
        );

        // act
        final str = requirementsConverter.convertToString(req);

        // assert
        expect(str, json.encode(data));
      },
    );
  });

  group('PositionJsonConverter.convertFromString', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          positionConverter.convertFromString(null);
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
          'title': 'Flutter разработчик',
          'department': 'Отдел разработки',
          'salary': 70000.0,
          'workplaceCount': 2,
          'requirements':
              '{"education":"Высшее, техническое","specialization":"Мобильная разработка","maxAge":60,"minAge":20}',
        };

        // act
        final pos = positionConverter.convertFromString(json.encode(data));
        final req = pos.requirements;

        // assert
        expect(pos.title, 'Flutter разработчик');
        expect(pos.department, 'Отдел разработки');
        expect(pos.salary, 70000.0);
        expect(pos.workplaceCount, 2);
        expect(req.education, 'Высшее, техническое');
        expect(req.specialization, 'Мобильная разработка');
        expect(req.maxAge, 60);
        expect(req.minAge, 20);
      },
    );
  });

  group('PositionJsonConverter.convertToString', () {
    test(
      'должен выбросить ошибку, если передан null',
      () async {
        try {
          // act
          positionConverter.convertToString(null);
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
          'title': 'Flutter разработчик',
          'department': 'Отдел разработки',
          'salary': 70000.0,
          'workplaceCount': 2,
          'requirements':
              '{"education":"Высшее, техническое","specialization":"Мобильная разработка","maxAge":null,"minAge":null}',
        };
        final req = PositionRequirements(
          education: 'Высшее, техническое',
          specialization: 'Мобильная разработка',
        );
        final pos = Position(
          title: 'Flutter разработчик',
          department: 'Отдел разработки',
          salary: 70000.0,
          workplaceCount: 2,
          requirements: req,
        );

        // act
        final str = positionConverter.convertToString(pos);
        // assert
        expect(str, json.encode(data));
      },
    );
  });
}
