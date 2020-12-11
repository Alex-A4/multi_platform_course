import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';

/// Нижняя панель навигации для главной страницы
class MainPageBottomBar extends StatelessWidget {
  final MainBloc bloc;

  MainPageBottomBar({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainBlocState>(
      stream: bloc,
      initialData: bloc.state,
      builder: (_, snap) {
        final state = snap.data;
        int index;
        if (state is MainBlocEmployeesState) {
          index = 0;
        }
        if (state is MainBlocPositionsState) {
          index = 1;
        }

        return BottomNavigationBar(
          items: items,
          currentIndex: index,
          onTap: (i) {
            if (i == 0)
              bloc.add(MainBlocOpenEmployees());
            else
              bloc.add(MainBlocOpenPositions());
          },
        );
      },
    );
  }

  List<BottomNavigationBarItem> get items => [
        BottomNavigationBarItem(label: 'Работники', icon: Icon(Icons.people)),
        BottomNavigationBarItem(label: 'Должности', icon: Icon(Icons.work)),
      ];
}
