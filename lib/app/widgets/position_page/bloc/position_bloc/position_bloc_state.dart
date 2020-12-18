import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

abstract class PositionBlocState extends Equatable {}

class PositionBlocLoadingState extends PositionBlocState {
  final List<Position> positions;

  PositionBlocLoadingState(this.positions);

  @override
  List<Object> get props => [positions];
}

class PositionBlocDataState extends PositionBlocState {
  final List<Position> positions;
  final bool isEndOfList;

  PositionBlocDataState(this.positions, [this.isEndOfList = false]);

  @override
  List<Object> get props => [positions];
}
