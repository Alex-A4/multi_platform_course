import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/main_page/bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/main_page/ui/main_page_app_bar.dart';
import 'package:multi_platform_course/app/widgets/main_page/ui/main_page_body.dart';
import 'package:multi_platform_course/app/widgets/main_page/ui/main_page_bottom_bar.dart';

/// Главная страница, на которой можно открыть просмотр записей
/// по должностям или по работникам.
class MainPage extends StatelessWidget {
  final MainBloc bloc;

  MainPage({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(bloc: bloc),
      body: MainPageBody(bloc: bloc),
      bottomNavigationBar: MainPageBottomBar(bloc: bloc),
    );
  }
}
