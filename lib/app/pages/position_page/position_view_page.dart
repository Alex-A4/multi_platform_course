import 'package:flutter/material.dart';
import 'package:multi_platform_course/app/widgets/position_page/bloc/position_bloc/bloc.dart';
import 'package:multi_platform_course/app/widgets/position_page/ui/position_card.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

/// Страница, которая отображает список работников
class PositionPage extends StatefulWidget {
  final PositionBloc bloc;

  PositionPage({Key key, @required this.bloc})
      : assert(bloc != null),
        super(key: key);

  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
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
      appBar: AppBar(title: Text('Должности')),
      body: StreamBuilder<PositionBlocState>(
        stream: widget.bloc,
        initialData: widget.bloc.state,
        builder: (_, snap) {
          final state = snap.data;
          List<Position> data;
          if (state is PositionBlocDataState) {
            data = state.positions;
            isLoading = false;
            isEndOfList = state.isEndOfList;
          } else if (state is PositionBlocDataState) {
            data = state.positions;
            isLoading = true;
          }

          return ListView.builder(
            controller: controller,
            itemCount: data.length + (isLoading ? 1 : 0),
            itemBuilder: (_, i) {
              if (i == data.length) {
                return Center(child: CircularProgressIndicator());
              }
              return PositionCard(
                position: data[i],
                deleteAction: (e, _) =>
                    widget.bloc.add(PositionBlocDeleteEvent(e)),
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
      widget.bloc.add(PositionBlocLoadEvent());
    }
  }
}
