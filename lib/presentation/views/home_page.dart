import 'dart:io';

import 'package:excel_plus/excel_plus.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:gestor_horas/configuration/excel_exporter.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/views/schedules_page.dart';
import 'package:gestor_horas/presentation/views/time_track_page.dart';
import 'package:provider/provider.dart';

import 'employees_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TimeTrackPage(),
    const EmployeesPage(),
    const SchedulesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    locator<EmployeeViewModel>().loadEmployees();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[100],
        title: const Text('Kiroko'),
        leading: const Icon(Icons.house_rounded, size: 40),
        actions: [
          Consumer2<EmployeeViewModel, TimeTrackViewModel>(
            builder:
                (
                  BuildContext context,
                  EmployeeViewModel employeeViewModel,
                  TimeTrackViewModel timeTrackViewModel,
                  Widget? child,
                ) {
                  List<EmployeeModel> employees = employeeViewModel.employees;

                  return SingleChildScrollView(
                    child: MenuAnchor(
                      menuChildren: employees
                          .map(
                            (EmployeeModel employee) => ListTile(
                              leading: Text(employee.name),
                              trailing: employee.currentTimeTrack?.startTime == null
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(80, 80),
                                        foregroundColor: Colors.blue,
                                      ),
                                      onPressed: () async {
                                        EmployeeModel? employeeWithTimeStart =
                                            await timeTrackViewModel.addStartTimeTrackToEmployee(employee);
                                        await employeeViewModel.updateEmployee(
                                          employeeWithTimeStart!,
                                        );
                                      },
                                      child: const Icon(Icons.play_arrow),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(80, 80),
                                        foregroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        if (employee.currentTimeTrack != null ||
                                            employee.currentTimeTrack?.startTime != null) {
                                          int differenceBetweenTimes = DateTime.now()
                                              .difference(employee.currentTimeTrack!.startTime!)
                                              .inMinutes;

                                          if (differenceBetweenTimes != 0) {
                                            await timeTrackViewModel.addTimeFinish(employee);
                                          } else {
                                            await timeTrackViewModel.deleteTimeTrack(
                                              employee.currentTimeTrack!,
                                            );
                                          }

                                          employeeViewModel.updateEmployee(
                                            employee.copyWith(currentTimeTrack: null),
                                          );
                                        }
                                      },
                                      child: const Icon(Icons.stop_circle),
                                    ),
                            ),
                          )
                          .toList(),
                      builder: (BuildContext context, MenuController controller, Widget? child) {
                        return ElevatedButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: const Icon(Icons.person),
                        );
                      },
                    ),
                  );
                },
          ),
        ],
      ),
      body: Row(
        children: [
          SideMenu(
            builder: (data) => SideMenuData(
              items: [
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {
                    _onItemTapped(0);
                  },
                  title: 'Hoja de Horas',
                  icon: const Icon(Icons.hourglass_bottom),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {
                    _onItemTapped(1);
                  },
                  title: 'Empleados',
                  icon: const Icon(Icons.people),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {
                    _onItemTapped(2);
                  },
                  title: 'Horarios',
                  icon: const Icon(Icons.schedule),
                ),
              ],
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: Colors.orangeAccent,
                  ),

                  onPressed: () async {
                    locator<TimeTrackViewModel>().exportDataToExcel();
                  },
                  child: Icon(Icons.ios_share),
                ),
              ),
            ),
          ),
          Expanded(child: _widgetOptions[_selectedIndex]),
        ],
      ),
    );
  }
}
