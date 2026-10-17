import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/widgets/data_table_employees.dart';
import 'package:gestor_horas/presentation/widgets/side_panel_time_tracking.dart';
import 'package:provider/provider.dart';
import 'package:side_panel/side_panel.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../configuration/service_locator.dart';

class TimeTrackPage extends StatefulWidget {
  const TimeTrackPage({super.key});

  @override
  State<TimeTrackPage> createState() => _TimeTrackPageState();
}

class _TimeTrackPageState extends State<TimeTrackPage> {
  final _sidePanelController = SidePanelController();

  int? selectedEmployeeId;

  @override
  Widget build(BuildContext context) {
    return SidePanel(
      right: Panel(size: 400, overlay: true, child: SidePanelTimeTrackingWidget()),
      controller: locator<SidePanelController>(),
      child: Consumer3<EmployeeViewModel, TimeTrackViewModel, DateViewModel>(
        builder: (context, employeeViewModel, employeeTimeTrackViewModel, dateViewModel, child) {
          List<EmployeeModel> employees = employeeViewModel.employees;

          if (selectedEmployeeId == null && employees.isNotEmpty) {
            selectedEmployeeId = employees.first.id;
          }

          final selectedEmployee = employees
              .where((employee) => employee.id == selectedEmployeeId)
              .firstOrNull;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Calendar widget
                      MenuAnchor(
                        menuChildren: [
                          Container(
                            width: 350,
                            height: 500,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: TableCalendar(
                                    focusedDay: dateViewModel.selectedDate,
                                    firstDay: dateViewModel.calendarMinSelectableData,
                                    lastDay: dateViewModel.calendarMaxSelectableData,
                                    rangeStartDay: dateViewModel.firstDayOfWeek,
                                    rangeEndDay: dateViewModel.lastDayOfWeek,
                                    rangeSelectionMode: RangeSelectionMode.enforced,
                                    calendarFormat: CalendarFormat.month,
                                    locale: 'es_ES',
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    headerStyle: const HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                    ),
                                    onDaySelected: (selectedDay, focusedDay) {
                                      dateViewModel.setSelectedDate(selectedDay);
                                      locator<TimeTrackViewModel>().getAllTimeTrackings();
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed:
                                      (dateViewModel.selectedDate.weekday ==
                                              DateTime.now().weekday) &&
                                          (dateViewModel.selectedDate.day == DateTime.now().day) &&
                                          (dateViewModel.selectedDate.month ==
                                              DateTime.now().month) &&
                                          (dateViewModel.selectedDate.year == DateTime.now().year)
                                      ? null
                                      : () {
                                          dateViewModel.setSelectedDate(DateTime.now());
                                        },
                                  child: Text('Volver a hoy'),
                                ),
                              ],
                            ),
                          ),
                        ],
                        builder: (BuildContext context, MenuController controller, Widget? child) {
                          return ElevatedButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: const Icon(Icons.calendar_month),
                          );
                        },
                      ),
                    ],
                  ),
                  DataTableEmployees(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
