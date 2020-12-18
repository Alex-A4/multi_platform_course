import 'package:equatable/equatable.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

abstract class PositionOpenBlocEvent extends Equatable {}

class PositionOpenBlocLoadEvent extends PositionOpenBlocEvent {
  @override
  List<Object> get props => [];
}

class PositionOpenBlocDeleteEvent extends PositionOpenBlocEvent {
  final Position position;

  PositionOpenBlocDeleteEvent(this.position);

  @override
  List<Object> get props => [position];
}
