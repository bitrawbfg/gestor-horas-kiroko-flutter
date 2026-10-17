import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:side_panel/side_panel.dart';

import '../../configuration/service_locator.dart';

class DataTableEmployees extends StatelessWidget {
  DataTableEmployees({super.key});

  final EmployeeViewModel employeeViewModel = locator<EmployeeViewModel>();
  final TimeTrackViewModel timeTrackViewModel = locator<TimeTrackViewModel>();
  final DateViewModel dateViewModel = locator<DateViewModel>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: [
          DataColumn2(
            label: Text(style: TextStyle(fontWeight: FontWeight.bold), 'Empleado'),
            size: ColumnSize.L,
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Lunes', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[0].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Martes', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[1].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Miércoles', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[2].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Jueves', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[3].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Viernes', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[4].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Sábado', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[5].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Domingo', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${dateViewModel.weekDates[6].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.start,
            label: Text('Total'),
            numeric: true,
          ),
        ],
        rows: List<DataRow>.generate(employeeViewModel.employees.length, (index) {
          EmployeeModel employee = employeeViewModel.employees[index];
          Duration timeWorkedInWeek = timeTrackViewModel.getTimeWorkedInWeekByEmployee(
            employee.id!,
            dateViewModel.firstDayOfWeek,
            dateViewModel.lastDayOfWeek,
          );

          return DataRow(
            cells: [
              DataCell(Text(employee.name)),
              ...List<DataCell>.generate(7, (int index) {
                DateTime currentDay = dateViewModel.firstDayOfWeek.copyWith(
                  day: dateViewModel.firstDayOfWeek.day + index,
                );
                var employeeId = employee.id!;

                Duration duration = timeTrackViewModel.getDailyTimeWorkedByEmployee(employeeId, currentDay);
                return DataCell(
                  GestureDetector(
                    onDoubleTap: () async {
                      locator<SidePanelController>().showRightPanel();
                      timeTrackViewModel.getTimeTrackingsBySpecificDayAndEmployee(employeeId, currentDay);

                      await employeeViewModel.getEmployeesById(employeeId);
                    },
                    child: Center(
                      child: Text(
                        duration.inMinutes == 0
                            ? '-'
                            : '${duration.inHours.remainder(24)}h ${duration.inMinutes.remainder(60)}m',
                      ),
                    ),
                  ),
                );
              }),
              DataCell(
                Text(
                  timeWorkedInWeek.inMinutes == 0
                      ? '-'
                      : '${timeWorkedInWeek.inHours.remainder(24)}h ${timeWorkedInWeek.inMinutes.remainder(60)}m',
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
