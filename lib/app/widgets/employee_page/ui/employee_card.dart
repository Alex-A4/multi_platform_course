import 'package:flutter/material.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';

/// Карточка с данными о работнике
class EmployeeCard extends StatelessWidget {
  final Function(Employee, BuildContext) deleteAction;
  final Employee employee;

  EmployeeCard({Key key, @required this.employee, this.deleteAction})
      : assert(employee != null),
        super(key: key);

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
                    child: textRow(
                      'ФИО',
                      '${employee.lastName} ${employee.firstName} ${employee.middleName}',
                    ),
                  ),
                  if (deleteAction != null)
                    InkWell(
                      borderRadius: BorderRadius.circular(90),
                      onTap: () => deleteAction(employee, context),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.clear),
                      ),
                    ),
                ],
              ),
              textRow(
                'Возраст',
                '${employee.age}',
              ),
              textRow(
                'Образование',
                '${employee.education}',
              ),
              textRow(
                'Специальность',
                '${employee.specialization}',
              ),
            ],
          ),
        ),
      ),
    );
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
