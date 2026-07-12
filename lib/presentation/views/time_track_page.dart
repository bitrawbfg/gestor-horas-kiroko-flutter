import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_viewmodel.dart';
import 'package:provider/provider.dart';

class TimeTrackPage extends StatefulWidget {
  const TimeTrackPage({super.key});

  @override
  State<TimeTrackPage> createState() => _TimeTrackPageState();
}

typedef MenuEntry = DropdownMenuEntry<EmployeeModel>;

class _TimeTrackPageState extends State<TimeTrackPage> {
  int? selectedEmployeeId;

  @override
  Widget build(BuildContext context) {
    return Consumer2<EmployeeViewModel, EmployeeTimeTrackViewmodel>(
      builder: (context, employeeViewModel, employeeTimeTrackViewModel, child) {
        List<EmployeeModel> employees = employeeViewModel.employees;

        if (selectedEmployeeId == null && employees.isNotEmpty) {
          selectedEmployeeId = employees.first.id;
        }
        final selectedEmployee = employees.where((employee) => employee.id == selectedEmployeeId).firstOrNull;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<EmployeeModel>(
                  onChanged: (EmployeeModel? value) {
                    setState(() {
                      selectedEmployeeId = value!.id;
                    });
                  },
                  value: selectedEmployee,
                  items: employees.map<DropdownMenuItem<EmployeeModel>>((
                    EmployeeModel employee,
                  ) => DropdownMenuItem(
                      value: employee,
                      child: Row(
                        children: [
                          Text(employee.name),

                        ],
                      ),
                    )).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectedEmployee?.timeTrack?.start_time == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(80, 80),
                              foregroundColor: Colors.blue,
                            ),
                            onPressed: () async {
                              await employeeViewModel.addTimeStart(
                                selectedEmployee!,
                              );
                            },
                            child: Icon(Icons.play_arrow),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(80, 80),
                              foregroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              if (selectedEmployee?.timeTrack != null ||
                                  selectedEmployee?.timeTrack?.start_time !=
                                      null) {
                                await employeeViewModel.addTimeFinish(
                                  selectedEmployee!,
                                );
                              }
                            },
                            child: Icon(Icons.stop_circle),
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
