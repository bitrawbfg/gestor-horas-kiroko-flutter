import 'package:flutter/material.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/features/time-trackings/presentation/viewmodels/time_track_viewmodel.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';
import 'package:gestor_horas/features/time-trackings/presentation/widgets/time_track_calendar.dart';
import 'package:provider/provider.dart';
import 'package:side_panel/side_panel.dart';

import '../../../../core/injection.dart';
import '../widgets/side_panel_time_tracking.dart';
import '../widgets/weekly_time_track_table.dart';

class TimeTrackPage extends StatefulWidget {
  const TimeTrackPage({super.key});

  @override
  State<TimeTrackPage> createState() => _TimeTrackPageState();
}

class _TimeTrackPageState extends State<TimeTrackPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<EmployeeViewModel, TimeTrackViewModel, DateViewModel>(
      builder: (context, employeeViewModel, timeTrackViewModel, dateViewModel, child) {
        // Show circular progress while the data is loading
        if (timeTrackViewModel.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (timeTrackViewModel.hasError) {
          return Center(child: Text(timeTrackViewModel.error!));
        }

        List<EmployeeEntity> employees = employeeViewModel.employees;

        DateTime firstDayOfWeek = dateViewModel.firstDayOfWeek;
        DateTime lastDayOfWeek = dateViewModel.lastDayOfWeek;

        return SidePanel(
          right: Panel(size: 600, overlay: true, child: SidePanelTimeTracking()),
          controller: locator<SidePanelController>(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Calendar widget
                      TimeTrackCalendar(
                        timeTrackViewModel: timeTrackViewModel,
                        dateViewModel: dateViewModel,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent.shade100,
                        ),

                        onPressed: () async {
                          // locator<TimeTrackViewModel>().exportDataToExcel();
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.ios_share, size: 24),
                              SizedBox(width: 10),
                              Text('Exportar'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Table with timetrackings and employees
                  WeeklyTimeTrackTable(
                    timeTrackViewModel: timeTrackViewModel,
                    employeeViewModel: employeeViewModel,
                    dateViewModel: dateViewModel,
                    firstDayOfWeek: firstDayOfWeek,
                    employees: employees,
                    lastDayOfWeek: lastDayOfWeek,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
