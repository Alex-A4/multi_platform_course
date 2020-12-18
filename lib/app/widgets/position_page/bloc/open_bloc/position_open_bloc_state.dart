import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

abstract class PositionOpenBlocState extends Equatable {}

class PositionOpenBlocLoadingState extends PositionOpenBlocState {
  final List<Position> positions;

  PositionOpenBlocLoadingState(this.positions);

  @override
  List<Object> get props => [positions];
}

class PositionOpenBlocDataState extends PositionOpenBlocState {
  final List<Position> positions;
  final bool isEndOfList;

  PositionOpenBlocDataState(this.positions, [this.isEndOfList = false]);

  @override
  List<Object> get props => [positions];
}
