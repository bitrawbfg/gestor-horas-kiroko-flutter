import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:provider/provider.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final TextEditingController _nameController = TextEditingController();

  void _showForm(BuildContext context, {EmployeeModel? employee}) {
    _nameController.text = employee?.name ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            employee == null ? 'Añadir un nuevo empleado' : 'Editar empleado',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (employee == null) {
                  Provider.of<EmployeeViewModel>(
                    context,
                    listen: false,
                  ).addEmployee(_nameController.text);
                } else {
                  Provider.of<EmployeeViewModel>(
                    context,
                    listen: false,
                  ).updateEmployee(
                    EmployeeModel(id: employee.id, name: _nameController.text),
                  );
                }

                Navigator.pop(context);
              },
              child: Text(
                employee == null ? 'Añadir nuevo empleado' : 'Editar empleado',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarController = TextEditingController();

    return Consumer<EmployeeViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: SearchBar(
                      leading: Icon(Icons.search),
                      hintText: 'Buscar empleados...',
                      controller: searchBarController,
                      onChanged: (search) async {
                        await viewModel.getEmployeesByName(search);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showForm(context);
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all<Size>(Size(200, 60)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Icon(Icons.add), Text('Añadir empleado')],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(height: 10, child: Divider()),
              ),
              viewModel.employees.isEmpty
                  ? searchBarController.text.isEmpty
                        ? Expanded(
                            child: Column(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Añade un nuevo empleado'),
                                ElevatedButton(
                                  onPressed: () {
                                    _showForm(context);
                                  },
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
                            child: Column(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No se han encontrado empleados con el nombre "${searchBarController.text}"',
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
                              leading: CircleAvatar(
                                child: Text(
                                  employee.name.substring(0, 1).toUpperCase(),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      employee.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'asdf@gmail.com',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _showForm(context, employee: employee);
                                    },
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
          ),
        );
      },
    );
  }
}
