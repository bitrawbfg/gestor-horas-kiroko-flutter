import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer2<EmployeeViewModel, EmployeeTimeTrackViewmodel>(
      builder: (context, employeeViewModel, employeeTimeTrackViewModel, child) {
        List<EmployeeModel> employees = employeeViewModel.employees;
        List<MenuEntry> menuEntries = UnmodifiableListView(
          employees.map<MenuEntry>(
            (EmployeeModel employee) =>
                MenuEntry(value: employee, label: employee.name),
          ),
        );
        EmployeeModel dropdownEmployee = employees.first;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownMenu(
                  dropdownMenuEntries: menuEntries,
                  initialSelection: employees.first,
                  onSelected: (EmployeeModel? employee) {
                    setState(() {
                      dropdownEmployee = employee!;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 80),
                        foregroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        EmployeeTimeTrackModel? returnEmployee =
                            await employeeTimeTrackViewModel.addTimeStart(
                              dropdownEmployee,
                            );

                        if (returnEmployee != null) {
                          EmployeeModel employee = dropdownEmployee.copyWith(
                            timeTrack: returnEmployee,
                          );
                          dropdownEmployee = employee;
                        }
                      },
                      child: Icon(Icons.play_arrow),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(80, 80),
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        if (dropdownEmployee.timeTrack != null || dropdownEmployee.timeTrack?.start_time != null) {
                          await employeeTimeTrackViewModel.addTimeFinish(dropdownEmployee);
                        }
                      },
                      child: Icon(dropdownEmployee.timeTrack?.start_time != null ? Icons.eleven_mp : Icons.stop_circle),
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
