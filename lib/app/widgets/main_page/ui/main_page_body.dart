import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';

/// Тело главной страницы. Отображает действия для работников или для должностей
class MainPageBody extends StatelessWidget {
  final MainBloc bloc;

  MainPageBody({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainBlocState>(
      stream: bloc,
      initialData: bloc.state,
      builder: (_, snap) {
        final state = snap.data;
        List<Widget> children;
        if (state is MainBlocEmployeesState) {
          children = employeesActions;
        }
        if (state is MainBlocPositionsState) {
          children = positionActions;
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          itemCount: children.length,
          itemBuilder: (_, i) => children[i],
        );
      },
    );
  }

  List<Widget> get employeesActions {
    return [];
  }

  List<Widget> get positionActions {
    return [];
  }
}
