import 'package:flutter/material.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:provider/provider.dart';

class SidePanelTimeTrackingWidget extends StatefulWidget {
  const SidePanelTimeTrackingWidget({super.key});

  @override
  State<SidePanelTimeTrackingWidget> createState() => _SidePanelTimeTrackingWidgetState();
}

class _SidePanelTimeTrackingWidgetState extends State<SidePanelTimeTrackingWidget> {
  EmployeeModel? employee = locator<EmployeeViewModel>().selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return Consumer3<TimeTrackViewModel, EmployeeViewModel, DateViewModel>(
      builder:
          (
            BuildContext context,
            TimeTrackViewModel timeTrackViewModel,
            EmployeeViewModel employeeViewModel,
            DateViewModel dateViewModel,
            Widget? child,
          ) {
            List<TimeTrackModel> timeTrackingsFromEmployee =
                timeTrackViewModel.timeTrackingsFromEmployee;

            return Container(
              color: Colors.blueGrey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                      'Registros de ${employee?.name}',
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: timeTrackingsFromEmployee.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          TimeTrackModel timeTracking = timeTrackingsFromEmployee[index];

                          DateTime startTime = timeTracking.startTime!;
                          DateTime finishTime = timeTracking.finishTime!;
                          Duration duration = Duration(minutes: timeTracking.difference!);

                          int startSelectedHour = startTime.hour;
                          int startSelectedMinute = startTime.minute;
                          int finishSelectedHour = finishTime.hour;
                          int finishSelectedMinute = finishTime.minute;

                          return Card(
                            child: ExpansionTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    'Duración',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${duration.inHours}h ${duration.inMinutes % 60}min',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              children: [
                                StatefulBuilder(
                                  builder:
                                      (
                                        BuildContext context,
                                        void Function(void Function()) setState,
                                      ) {
                                        return ListTile(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                        'Hora de entrada',
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Row(
                                                        children: [
                                                          DropdownButton<int>(
                                                            value: startSelectedHour,
                                                            onChanged: (int? newValue) {
                                                              setState(() {
                                                                startSelectedHour = newValue!;
                                                                startTime = startTime.copyWith(
                                                                  hour: newValue,
                                                                );
                                                              });
                                                            },
                                                            items:
                                                                List<
                                                                  DropdownMenuItem<int>
                                                                >.generate(24, (int index) {
                                                                  return DropdownMenuItem<int>(
                                                                    enabled:
                                                                        finishSelectedHour >= index,
                                                                    value: index,
                                                                    child: Text(
                                                                      '$index',
                                                                      style: TextStyle(
                                                                        color:
                                                                            (finishSelectedHour <
                                                                                index)
                                                                            ? Colors.grey
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                          DropdownButton<int>(
                                                            value: startSelectedMinute,
                                                            onChanged: (int? newValue) {
                                                              setState(() {
                                                                startSelectedMinute = newValue!;
                                                                startTime = startTime.copyWith(
                                                                  minute: newValue,
                                                                );
                                                              });
                                                            },
                                                            items:
                                                                List<
                                                                  DropdownMenuItem<int>
                                                                >.generate(60, (int index) {
                                                                  return DropdownMenuItem<int>(
                                                                    enabled:
                                                                        finishSelectedMinute >=
                                                                        index,
                                                                    value: index,
                                                                    child: Text(
                                                                      '$index',
                                                                      style: TextStyle(
                                                                        color:
                                                                            (finishSelectedMinute <
                                                                                index)
                                                                            ? Colors.grey
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  // For finish time
                                                  Row(
                                                    children: [
                                                      Text(
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                        'Hora de salida',
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Row(
                                                        children: [
                                                          DropdownButton<int>(
                                                            value: finishSelectedHour,
                                                            onChanged: (int? newValue) {
                                                              setState(() {
                                                                finishSelectedHour = newValue!;
                                                                finishTime = finishTime.copyWith(
                                                                  hour: newValue,
                                                                );
                                                              });
                                                            },
                                                            items:
                                                                List<
                                                                  DropdownMenuItem<int>
                                                                >.generate(24, (int index) {
                                                                  return DropdownMenuItem<int>(
                                                                    enabled:
                                                                        startSelectedHour <= index,
                                                                    value: index,
                                                                    child: Text(
                                                                      '$index',
                                                                      style: TextStyle(
                                                                        color:
                                                                            (startSelectedHour >
                                                                                index)
                                                                            ? Colors.grey
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                          DropdownButton<int>(
                                                            value: finishSelectedMinute,
                                                            onChanged: (int? newValue) {
                                                              setState(() {
                                                                finishSelectedMinute = newValue!;
                                                                finishTime = finishTime.copyWith(
                                                                  minute: newValue,
                                                                );
                                                              });
                                                            },
                                                            items:
                                                                List<
                                                                  DropdownMenuItem<int>
                                                                >.generate(60, (int index) {
                                                                  return DropdownMenuItem<int>(
                                                                    enabled:
                                                                        startSelectedMinute <=
                                                                        index,
                                                                    value: index,
                                                                    child: Text(
                                                                      '$index',
                                                                      style: TextStyle(
                                                                        color:
                                                                            (startSelectedMinute >
                                                                                index)
                                                                            ? Colors.grey
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await timeTrackViewModel.editTimeTrack(
                                                            timeTracking,
                                                            startTime,
                                                            finishTime,
                                                          );
                                                        },
                                                        child: Text('Guardar cambios'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await timeTrackViewModel.deleteTimeTrack(
                                                            timeTracking,
                                                          );
                                                        },
                                                        child: Text('Eliminar registro'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        );
                                      },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
    );
  }
}
