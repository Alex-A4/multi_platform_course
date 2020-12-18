import 'package:bloc/bloc.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

import 'bloc.dart';

/// Блок, который позволяет оперировать открытыми с вакансиями и загружать их
class PositionOpenBloc
    extends Bloc<PositionOpenBlocEvent, PositionOpenBlocState> {
  final CompanyRepository repository;

  PositionOpenBloc(this.repository) : super(PositionOpenBlocDataState([])) {
    add(PositionOpenBlocLoadEvent());
  }

  final List<Position> positions = [];

  @override
  Stream<PositionOpenBlocState> mapEventToState(
      PositionOpenBlocEvent event) async* {
    if (event is PositionOpenBlocLoadEvent) {
      yield PositionOpenBlocLoadingState(List.from(positions));
      try {
        final newData = await repository.getOpenPositions();
        if (newData.isNotEmpty) {
          positions.addAll(newData);
          yield PositionOpenBlocDataState(List.from(positions));
        } else {
          yield PositionOpenBlocDataState(List.from(positions), true);
        }
      } catch (e) {
        print(e);
        yield PositionOpenBlocDataState(List.from(positions), true);
      }
    }
    if (event is PositionOpenBlocDeleteEvent) {
      await repository.deletePosition(event.position);
      print(positions.remove(event.position));
      yield PositionOpenBlocDataState(List.from(positions));
    }
  }
}
