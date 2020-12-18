import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/navigation/router.dart';
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
          children = employeesActions(context);
        }
        if (state is MainBlocPositionsState) {
          children = positionActions(context);
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          itemCount: children.length,
          itemBuilder: (_, i) => children[i],
        );
      },
    );
  }

  List<Widget> employeesActions(BuildContext context) {
    return [
      ActionCard(
        title: 'Посмотреть работников',
        action: () => Navigator.of(context).pushNamed(EMPLOYEES_VIEW),
      ),
      ActionCard(
        title: 'Посмотреть работников с фильтрами',
        action: () => Navigator.of(context).pushNamed(EMPLOYEES_VIEW_FILTER),
      ),
      ActionCard(
        title: 'Добавить работника',
        action: () => Navigator.of(context).pushNamed(EMPLOYEE_ADD),
      ),
    ];
  }

  List<Widget> positionActions(BuildContext context) {
    return [
      ActionCard(
        title: 'Посмотреть должности',
        action: () => Navigator.of(context).pushNamed(POSITION_VIEW),
      ),
      ActionCard(
        title: 'Посмотреть открытые вакансии',
        action: () => Navigator.of(context).pushNamed(POSITION_VIEW_OPEN),
      ),
      ActionCard(
        title: 'Добавить должность',
        action: () => Navigator.of(context).pushNamed(POSITION_ADD),
      ),
    ];
  }
}

/// Карточка, с помощью которой можно выбрать действие
class ActionCard extends StatelessWidget {
  final Function action;
  final String title;

  ActionCard({
    Key key,
    @required this.action,
    @required this.title,
  })  : assert(action != null && title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: action,
        child: SizedBox(
          height: 100,
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
