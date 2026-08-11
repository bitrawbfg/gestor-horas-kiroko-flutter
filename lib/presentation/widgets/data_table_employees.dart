import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:side_panel/side_panel.dart';

class DataTableEmployees extends StatelessWidget {
  const DataTableEmployees({
    super.key,
    required this.employeeViewModel,
    required this.employeeTimeTrackViewModel,
    required this.dateViewModel,
    required this.sidePanelController,
  });

  final EmployeeViewModel employeeViewModel;
  final TimeTrackViewModel employeeTimeTrackViewModel;
  final DateViewModel dateViewModel;
  final SidePanelController sidePanelController;

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
          Duration timeWorkedInWeek = employeeTimeTrackViewModel.getTimeWorkedInWeekByEmployee(
            employee.id!,
          );

          return DataRow(
            cells: [
              DataCell(Text(employee.name)),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                0,
                employee.id!,
                context,
              ),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                1,
                employee.id!,
                context,
              ),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                2,
                employee.id!,
                context,
              ),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                3,
                employee.id!,
                context,
              ),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                4,
                employee.id!,
                context,
              ),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                5,
                employee.id!,
                context,
              ),
              employeeTimeTrackViewModel.checkColumnWeekDayWithTimeTrackings(
                6,
                employee.id!,
                context,
              ),
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