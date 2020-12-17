import 'package:flutter/material.dart';
import 'package:multi_platform_course/domain/entities/employee.dart';
import 'package:multi_platform_course/domain/repositories/company_repository.dart';

/// Страница для добавления работника
class EmployeeAddPage extends StatefulWidget {
  final CompanyRepository repository;

  EmployeeAddPage({Key key, @required this.repository}) : super(key: key);

  @override
  _EmployeeAddPageState createState() => _EmployeeAddPageState();
}

class _EmployeeAddPageState extends State<EmployeeAddPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();

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
                textField('Фамилия', (v) {
                  if (v.isEmpty) return 'Фамилия не должна быть пустой';
                  return null;
                }, lastNameController),
                textField('Имя', (v) {
                  if (v.isEmpty) return 'Имя не должно быть пустым';
                  return null;
                }, nameController),
                textField('Отчество', (v) {
                  if (v.isEmpty) return 'Отчество не должно быть пустым';
                  return null;
                }, middleNameController),
                textField('Образование', (v) {
                  if (v.isEmpty) return 'Образование не должно быть пустым';
                  return null;
                }, educationController),
                textField('Специальность', (v) {
                  if (v.isEmpty) return 'Специальность не должна быть пустой';
                  return null;
                }, specializationController),
                textField('Возраст', (v) {
                  if (v.isEmpty) return 'Возраст не должен быть пустым';
                  if (int.tryParse(v) == null) return 'Некорректное значение';
                  return null;
                }, ageController),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        widget.repository.addEmployee(Employee(
                          lastName: lastNameController.text,
                          firstName: nameController.text,
                          middleName: middleNameController.text,
                          education: educationController.text,
                          specialization: specializationController.text,
                          age: int.parse(ageController.text),
                          id: null,
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Добавить работника'),
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
