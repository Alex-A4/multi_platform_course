import 'package:bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';

/// Блок, ответственный за то, какая страница отображается на главном экране
class MainBloc extends Bloc<MainBlocEvent, MainBlocState> {
  MainBloc() : super(MainBlocEmployeesState());

  @override
  Stream<MainBlocState> mapEventToState(MainBlocEvent event) async* {
    if (event is MainBlocOpenEmployees) {
      yield MainBlocEmployeesState();
    }
    if (event is MainBlocOpenPositions) {
      yield MainBlocPositionsState();
    }
  }
}
