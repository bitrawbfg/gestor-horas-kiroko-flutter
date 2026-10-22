import 'package:data_table_2/data_table_2.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';
import 'package:gestor_horas/features/time-trackings/presentation/viewmodels/time_track_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:side_panel/side_panel.dart';

import '../../../../core/injection.dart';
import '../../../employees/domain/entities/employee_entity.dart';

class WeeklyTimeTrackTable extends StatelessWidget {
  final DateTime firstDayOfWeek;
  final List<EmployeeEntity> employees;
  final DateTime lastDayOfWeek;
  final TimeTrackViewModel timeTrackViewModel;
  final DateViewModel dateViewModel;
  final EmployeeViewModel employeeViewModel;

  const WeeklyTimeTrackTable({
    super.key,
    required this.firstDayOfWeek,
    required this.employees,
    required this.lastDayOfWeek,
    required this.timeTrackViewModel,
    required this.dateViewModel,
    required this.employeeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text(style: TextStyle(fontWeight: FontWeight.bold), 'Empleado'),
              size: ColumnSize.L,
            ),
            // Generate the header with the name and number of the weekday
            ...List<DataColumn2>.generate(7, (int index) {
              DateTime currentDay = firstDayOfWeek.add(Duration(days: index));
              return DataColumn2(
                headingRowAlignment: MainAxisAlignment.center,
                label: Column(
                  children: [
                    Text(
                      DateFormat.EEEE('es_ES').format(currentDay).capitalize,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${currentDay.day}', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              );
            }),
            DataColumn2(
              headingRowAlignment: MainAxisAlignment.start,
              label: Text('Total'),
              numeric: true,
            ),
          ],
          rows: List<DataRow2>.generate(employees.length, (index) {
            EmployeeEntity employee = employees[index];
            Duration weeklyTimeWorked = timeTrackViewModel.getTimeWorkedInWeekByEmployee(
              employee.id!,
              firstDayOfWeek,
              lastDayOfWeek,
            );

            return DataRow2(
              cells: [
                DataCell(Text(employee.name)),
                ...List<DataCell>.generate(7, (int index) {
                  DateTime currentDay = firstDayOfWeek.add(Duration(days: index));
                  Duration dailyTimeWorked = timeTrackViewModel.getDailyTimeWorkedByEmployee(
                    employee.id!,
                    currentDay,
                  );

                  return DataCell(
                    GestureDetector(
                      onDoubleTap: () async {
                        await timeTrackViewModel.getTimeTrackingsBySpecificDayAndEmployee(
                          employee.id!,
                          currentDay,
                        );

                        employeeViewModel.setSelectedEmployee = employee;

                        // Wait for Flutter next cycle to not open the panel right away
                        // This solves the problem with not showing selected employee on time
                        if (!context.mounted) return;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          locator<SidePanelController>().showRightPanel();
                        });
                      },
                      child: Center(
                        child: Text(
                          dailyTimeWorked.inMinutes == 0
                              ? '-'
                              : '${dailyTimeWorked.inHours.remainder(24)}h ${dailyTimeWorked.inMinutes.remainder(60)}m',
                        ),
                      ),
                    ),
                  );
                }),
                DataCell(
                  Text(
                    weeklyTimeWorked.inMinutes == 0
                        ? '-'
                        : '${weeklyTimeWorked.inHours.remainder(24)}h ${weeklyTimeWorked.inMinutes.remainder(60)}m',
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
