import 'package:flutter/material.dart';
import 'package:multi_platform_course/domain/entities/position.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

/// Страница для добавления должности без указания ей сотрудника.
class PositionAddPage extends StatefulWidget {
  final CompanyRepository repository;

  PositionAddPage({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  _PositionAddPageState createState() => _PositionAddPageState();
}

class _PositionAddPageState extends State<PositionAddPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController workplaceCountController =
      TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController minAgeController = TextEditingController();
  final TextEditingController maxAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить работника')),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              children: [
                textField('Название', (v) {
                  if (v.isEmpty) return 'Название не должно быть пустой';
                  return null;
                }, titleController),
                textField('Отдел', (v) {
                  if (v.isEmpty) return 'Отдел не должен быть пустым';
                  return null;
                }, departmentController),
                textField('Зарплата', (v) {
                  if (v.isEmpty) return 'Зарплата не должна быть пустой';
                  if (double.tryParse(v) == null)
                    return 'Некорректное значение';
                  return null;
                }, salaryController),
                textField('Количество рабочих мест', (v) {
                  if (v.isEmpty) return 'Количество не должно быть пустым';
                  if (int.tryParse(v) == null) return 'Некорректное значение';
                  return null;
                }, workplaceCountController),
                textField('Образование', (v) {
                  if (v.isEmpty) return 'Образование не должно быть пустым';
                  return null;
                }, educationController),
                textField('Специализация', (v) {
                  if (v.isEmpty) return 'Специализация не должна быть пустой';
                  return null;
                }, specializationController),
                textField('Минимальный возраст (не обязателен)', (v) {
                  if (v.isEmpty) return null;
                  if (int.tryParse(v) == null) return 'Некорректное значение';
                  return null;
                }, minAgeController),
                textField('Максимальный возраст (не обязателен)', (v) {
                  if (v.isEmpty) return null;
                  if (int.tryParse(v) == null) return 'Некорректное значение';
                  return null;
                }, maxAgeController),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        widget.repository.addPosition(Position(
                          title: titleController.text,
                          department: departmentController.text,
                          salary: double.parse(salaryController.text),
                          workplaceCount: int.parse(workplaceCountController.text),
                          requirements: PositionRequirements(
                            specialization: specializationController.text,
                            education: educationController.text,
                            maxAge: int.tryParse(maxAgeController.text),
                            minAge: int.tryParse(minAgeController.text),
                          ),
                          id: null,
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Добавить должность'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(String label, FormFieldValidator<String> validator,
      TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
    );
  }
}
