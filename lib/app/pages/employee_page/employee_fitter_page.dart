import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/employee_page/bloc/filter_page/bloc.dart';
import 'package:multi_platform_course/app/widgets/employee_page/ui/employee_card.dart';
import 'package:multi_platform_course/domain/database/company_database.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

/// Страница для просмотра пользователей с фильтрами
class EmployeeFilterPage extends StatefulWidget {
  final EmployeeFilterBloc bloc;

  EmployeeFilterPage({Key key, @required this.bloc}) : super(key: key);

  @override
  _EmployeeFilterPageState createState() => _EmployeeFilterPageState();
}

class _EmployeeFilterPageState extends State<EmployeeFilterPage> {
  final ScrollController controller = ScrollController();
  bool isLoading = true;
  bool isEndOfList = false;

  bool showSortDialog = false;

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
      body: StreamBuilder<EmployeeFilterBlocState>(
        stream: widget.bloc,
        initialData: widget.bloc.state,
        builder: (_, snap) {
          final state = snap.data;
          List<Employee> data;
          if (state is EmployeeFilterBlocDataState) {
            data = state.employees;
            isLoading = false;
            isEndOfList = state.isEndOfList;
          } else if (state is EmployeeFilterBlocLoadingState) {
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
                    widget.bloc.add(EmployeeFilterBlocDeleteEvent(e)),
              );
            },
          );
        },
      ),
      bottomSheet: !showSortDialog
          ? null
          : BottomSheet(
              builder: (BuildContext context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Фильтрация по:'),
                    ListTile(
                      title: Text('Должности'),
                      onTap: () {
                        widget.bloc.add(
                            EmployeeFilterBlocChangeSort(SortField.Position));
                        setState(() => showSortDialog = false);
                      },
                    ),
                    ListTile(
                      title: Text('Фамилии'),
                      onTap: () {
                        widget.bloc.add(
                            EmployeeFilterBlocChangeSort(SortField.LastName));
                        setState(() => showSortDialog = false);
                      },
                    ),
                  ],
                );
              },
              onClosing: () {},
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => showSortDialog = !showSortDialog),
        child: Icon(Icons.filter_list),
      ),
    );
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 200 && !isLoading && !isEndOfList) {
      isLoading = true;
      widget.bloc.add(EmployeeFilterBlocLoadEvent());
    }
  }
}
