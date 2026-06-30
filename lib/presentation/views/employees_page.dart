import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/presentation/viewmodels/employees/view_employees_viewmodel.dart';
import 'package:provider/provider.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeViewModel = Provider.of<ViewEmployeesViewmodel>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        children: [
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: SearchBar(
                  leading: Icon(Icons.search),
                  hintText: 'Buscar empleados...',
                ),
              ),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('Selecciona un rol'),
                  items: [],
                  onChanged: null,
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer<ViewEmployeesViewmodel>(
              builder: (context, viewModel, child) {
                return viewModel.employees!.isEmpty ||
                        viewModel.employees == null
                    ? Column(
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
                      )
                    : ListView.builder(
                        itemCount: viewModel.employees!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(child: Text("A")),
                              title: Text(viewModel.employees![index].name),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
