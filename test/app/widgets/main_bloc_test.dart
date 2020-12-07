import 'package:flutter_test/flutter_test.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';

void main() {
  MainBloc bloc;
  setUp(() {
    bloc = MainBloc();
  });

  test(
    'на старте должны быть выбраны работники',
    () async {
      // assert
      expect(bloc.state, MainBlocEmployeesState());
    },
  );

  test(
    'состояние должно меняться с работников на должности и обратно',
    () async {
      // act
      bloc.add(MainBlocOpenPositions());
      bloc.add(MainBlocOpenEmployees());

      // assert
      await expectLater(
        bloc,
        emitsInOrder([MainBlocPositionsState(), MainBlocEmployeesState()]),
      );
    },
  );
}
