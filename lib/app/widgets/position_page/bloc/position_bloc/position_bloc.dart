import 'package:bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/position_page/bloc/position_bloc/bloc.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

/// Блок, который позволяет оперировать с должностями и загружать их без форматирования
class PositionBloc extends Bloc<PositionBlocEvent, PositionBlocState> {
  final CompanyRepository repository;

  PositionBloc(this.repository) : super(PositionBlocDataState([])) {
    add(PositionBlocLoadEvent());
  }

  final List<Position> positions = [];

  @override
  Stream<PositionBlocState> mapEventToState(PositionBlocEvent event) async* {
    if (event is PositionBlocLoadEvent) {
      yield PositionBlocLoadingState(List.from(positions));
      try {
        final newData = await repository.getPositions(positions.length, 15);
        if (newData.isNotEmpty) {
          positions.addAll(newData);
          yield PositionBlocDataState(List.from(positions));
        } else {
          yield PositionBlocDataState(List.from(positions), true);
        }
      } catch (e) {
        print(e);
        yield PositionBlocDataState(List.from(positions), true);
      }
    }
    if (event is PositionBlocDeleteEvent) {
      await repository.deletePosition(event.position);
      print(positions.remove(event.position));
      yield PositionBlocDataState(List.from(positions));
    }
  }
}
