import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_horas/core/injection.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';
import 'package:provider/provider.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoursInContractController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showEmployeeForm(BuildContext context, {EmployeeEntity? employee}) {
    _nameController.text = employee?.name ?? '';
    _hoursInContractController.text =
        employee?.hoursInContract == null || employee?.hoursInContract == 0
        ? ''
        : '${employee?.hoursInContract}';

    showDialog(
      context: context,
      builder: (context) {
        bool hasContract = employee?.hasContract ?? false;

        return AlertDialog(
          title: Text(employee == null ? 'Añadir un nuevo empleado' : 'Editar empleado'),
          content: SizedBox(
            width: 600,
            height: 100,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: true,
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Nombre'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserta un nombre por favor';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: TextFormField(
                          controller: _hoursInContractController,
                          decoration: InputDecoration(labelText: 'Horas por contrato'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }

                            int hours = int.parse(value);

                            if (hours < 0 || hours > 40) {
                              return 'Debe estar entre 1 y 40 horas semanales';
                            }

                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String name = _nameController.text;
                  String hours = _hoursInContractController.text;
                  int hoursInContract = hours.isEmpty ? 0 : int.parse(hours);

                  EmployeeEntity currentEmployee =
                      employee?.copyWith(name: name, hoursInContract: hoursInContract) ??
                      EmployeeEntity(name: name, hoursInContract: hoursInContract);

                  if (employee == null) {
                    locator<EmployeeViewModel>().addEmployee(currentEmployee);
                  } else {
                    locator<EmployeeViewModel>().updateEmployee(currentEmployee);
                  }

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(employee == null ? 'Empleado añadido' : 'Empleado actualizado'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
              child: Text(employee == null ? 'Añadir nuevo empleado' : 'Editar empleado'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                backgroundColor: Colors.redAccent[50],
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
                      _showEmployeeForm(context);
                    },
                    style: ButtonStyle(fixedSize: WidgetStateProperty.all<Size>(Size(200, 60))),
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
                                    _showEmployeeForm(context);
                                  },
                                  style: ButtonStyle(
                                    fixedSize: WidgetStateProperty.all<Size>(Size(200, 60)),
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
                          EmployeeEntity employee = viewModel.employees[index];

                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(employee.name.substring(0, 1).toUpperCase()),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(employee.name, overflow: TextOverflow.ellipsis),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      employee.hoursInContract == 0
                                          ? ''
                                          : '${employee.hoursInContract} horas/semana',
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
                                      _showEmployeeForm(context, employee: employee);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      locator<EmployeeViewModel>().deleteEmployee(employee);
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
