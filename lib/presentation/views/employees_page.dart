import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_model.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_viewmodel.dart';
import 'package:provider/provider.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            viewModel.employees.isEmpty
                ? Expanded(
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Añade un nuevo empleado'),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            fixedSize: WidgetStateProperty.all<Size>(
                              Size(200, 60),
                            ),
                          ),
                          child: Text('Añadir'),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.employees.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        EmployeeModel employee = viewModel.employees[index];

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Text("A")),
                            title: Text(employee.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<EmployeeViewModel>(
                                      context,
                                      listen: false,
                                    ).deleteEmployee(employee);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
