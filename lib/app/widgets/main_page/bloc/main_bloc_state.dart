import 'package:equatable/equatable.dart';

/// Абстрактное состояние MainBloc
abstract class MainBlocState extends Equatable {}

/// Состояние, в котором отображаются действия, доступные для работников
class MainBlocEmployeesState extends MainBlocState {
  @override
  List<Object> get props => [];
}

/// Состояние, в котором отображаются действия, доступные для должностей
class MainBlocPositionsState extends MainBlocState {
  @override
  List<Object> get props => [];
}
