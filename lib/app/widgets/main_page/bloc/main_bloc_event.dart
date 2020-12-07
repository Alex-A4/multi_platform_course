import 'package:equatable/equatable.dart';

/// Абстрактное событие, которое можно совершить в MainBloc
abstract class MainBlocEvent extends Equatable {}

/// Открыть вкладку с работниками
class MainBlocOpenEmployees extends MainBlocEvent {
  @override
  List<Object> get props => [];
}

/// Открыть вкладку с должностями
class MainBlocOpenPositions extends MainBlocEvent {
  @override
  List<Object> get props => [];
}
