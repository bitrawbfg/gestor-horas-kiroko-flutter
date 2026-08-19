import 'package:flutter/material.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  /* void _showEmployeeForm(BuildContext context, {EmployeeModel? employee}) {

    showDialog(
      context: context,
      builder: (context) {
        bool hasContract = employee?.hasContract ?? false;

        return AlertDialog(
          title: Text(employee == null ? 'Añadir un nuevo empleado' : 'Editar empleado'),
          content: SizedBox(
            width: 600,
            height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Nombre'),
                      ),
                    ),
                    Expanded(
                      child: StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return CheckboxListTile(
                            title: Text('Tiene contrato', overflow: TextOverflow.ellipsis, maxLines: 1,),
                            value: hasContract,
                            onChanged: (bool? value) => setState(() {
                              hasContract = value!;
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty){
                  if (employee == null) {
                    locator<EmployeeViewModel>().addEmployee(
                      EmployeeModel(name: _nameController.text, hasContract: hasContract),
                    );
                  } else {
                    locator<EmployeeViewModel>().updateEmployee(
                      EmployeeModel(
                        id: employee.id,
                        name: _nameController.text,
                        hasContract: hasContract,
                      ),
                    );
                  }

                  Navigator.pop(context);
                } else {
                  // TODO: Añadir barra informativa sobre error al añadir empleado
                }
              },
              child: Text(employee == null ? 'Añadir nuevo empleado' : 'Editar empleado'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.redAccent),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(onPressed: () {}, child: Text('Añadir horario')),);
  }
}

