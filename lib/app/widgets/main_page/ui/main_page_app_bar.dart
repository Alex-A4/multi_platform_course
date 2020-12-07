import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';

/// Заголовок главной страницы
class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MainBloc bloc;

  MainPageAppBar({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainBlocState>(
      initialData: bloc.state,
      stream: bloc,
      builder: (_, snap) {
        final state = snap.data;
        String title;
        if (state is MainBlocPositionsState) {
          title = 'Должности';
        }
        if (state is MainBlocEmployeesState) {
          title = 'Работники';
        }

        return AppBar(title: Text(title));
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
