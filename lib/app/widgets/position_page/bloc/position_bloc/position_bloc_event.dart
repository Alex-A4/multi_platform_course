import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

abstract class PositionBlocEvent extends Equatable {}

class PositionBlocLoadEvent extends PositionBlocEvent {
  @override
  List<Object> get props => [];
}

class PositionBlocDeleteEvent extends PositionBlocEvent {
  final Position position;

  PositionBlocDeleteEvent(this.position);

  @override
  List<Object> get props => [position];
}
