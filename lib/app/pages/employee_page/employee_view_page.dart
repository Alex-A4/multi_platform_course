import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/employee_page/bloc/basic_page/bloc.dart';
import 'package:multi_platform_course/app/widgets/employee_page/ui/employee_card.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

/// Страница, которая отображает список работников
class EmployeePage extends StatefulWidget {
  final SimpleEmployeeBloc bloc;

  EmployeePage({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final ScrollController controller = ScrollController();
  bool isLoading = true;
  bool isEndOfList = false;

  @override
  void initState() {
    controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Работники')),
      body: StreamBuilder<SimpleEmployeeBlocState>(
        stream: widget.bloc,
        initialData: widget.bloc.state,
        builder: (_, snap) {
          final state = snap.data;
          List<Employee> data;
          if (state is SimpleEmployeeBlocDataState) {
            data = state.employees;
            isLoading = false;
            isEndOfList = state.isEndOfList;
          } else if (state is SimpleEmployeeBlocLoadingState) {
            data = state.employees;
            isLoading = true;
          }

          return ListView.builder(
            controller: controller,
            itemCount: data.length + (isLoading ? 1 : 0),
            itemBuilder: (_, i) {
              if (i == data.length) {
                return Center(child: CircularProgressIndicator());
              }
              return EmployeeCard(
                employee: data[i],
                deleteAction: (e, _) =>
                    widget.bloc.add(SimpleEmployeeBlocDeleteEvent(e)),
              );
            },
          );
        },
      ),
    );
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 200 && !isLoading && !isEndOfList) {
      isLoading = true;
      widget.bloc.add(SimpleEmployeeBlocLoadEvent());
    }
  }
}
