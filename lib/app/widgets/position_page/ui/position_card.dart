import 'package:flutter/material.dart';
import 'package:multi_platform_course/domain/entities/position.dart';

class PositionCard extends StatelessWidget {
  final Position position;
  final Function(Position, BuildContext) deleteAction;

  PositionCard({Key key, @required this.position, this.deleteAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: textRow('Название', '${position.title}'),
                  ),
                  if (deleteAction != null)
                    InkWell(
                      borderRadius: BorderRadius.circular(90),
                      onTap: () => deleteAction(position, context),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.clear),
                      ),
                    ),
                ],
              ),
              textRow('Отдел', '${position.department}'),
              textRow('Зарплата', '${position.salary.toStringAsFixed(1)}'),
              textRow('Количество мест', '${position.workplaceCount}'),
              textRow('Образование', '${position.requirements.education}'),
              textRow(
                  'Специальность', '${position.requirements.specialization}'),
              textRow('Возраст',
                  '${getAgePart(position.requirements.minAge, 'от')} ${getAgePart(position.requirements.maxAge, 'до')}'),
            ],
          ),
        ),
      ),
    );
  }

  String getAgePart(int value, String title) {
    if (value == null) return '';
    return '$title $value';
  }

  Widget textRow(String title, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title:  ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: text, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
