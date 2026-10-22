import 'package:flutter/material.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../data/models/time_trackings/time_track_model.dart';

class SidePanelTimeTracking extends StatefulWidget {
  const SidePanelTimeTracking({super.key});

  @override
  State<SidePanelTimeTracking> createState() => _SidePanelTimeTrackingState();
}

class _SidePanelTimeTrackingState extends State<SidePanelTimeTracking> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<EmployeeViewModel, TimeTrackViewModel>(
      builder:
          (
            context,
            EmployeeViewModel employeeViewModel,
            TimeTrackViewModel timeTrackViewModel,
            child,
          ) {
            List<TimeTrackModel> timeTrackingsFromEmployee =
                timeTrackViewModel.timeTrackingsFromEmployee;

            return Container(
              color: Colors.blueGrey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                      'Registros de ${employeeViewModel.selectedEmployee?.name}',
                    ),
                    ...List.generate(timeTrackingsFromEmployee.length, (int index) {
                      TimeTrackModel timeTracking = timeTrackingsFromEmployee[index];

                      DateTime startTime = timeTracking.startTime!;
                      DateTime? finishTime = timeTracking.finishTime;
                      Duration? duration = (finishTime != null && timeTracking.difference != null)
                          ? Duration(minutes: timeTracking.difference!)
                          : null;

                      int startSelectedHour = startTime.hour;
                      int startSelectedMinute = startTime.minute;
                      int? finishSelectedHour = finishTime?.hour;
                      int? finishSelectedMinute = finishTime?.minute;

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
                                finishTime != null && duration != null
                                    ? '${duration.inHours}h ${duration.inMinutes % 60}min'
                                    : 'En curso',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          children: [
                            StatefulBuilder(
                              builder:
                                  (BuildContext context, void Function(void Function()) setState) {
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
                                                        items: List<DropdownMenuItem<int>>.generate(
                                                          24,
                                                          (int index) {
                                                            return DropdownMenuItem<int>(
                                                              value: index,
                                                              child: Text('$index'),
                                                            );
                                                          },
                                                        ),
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
                                                        items: List<DropdownMenuItem<int>>.generate(
                                                          60,
                                                          (int index) {
                                                            return DropdownMenuItem<int>(
                                                              value: index,
                                                              child: Text('$index'),
                                                            );
                                                          },
                                                        ),
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
                                                            finishTime = finishTime?.copyWith(
                                                              hour: newValue,
                                                            );
                                                          });
                                                        },
                                                        items: List<DropdownMenuItem<int>>.generate(
                                                          24,
                                                          (int index) {
                                                            return DropdownMenuItem<int>(
                                                              value: index,
                                                              child: Text('$index'),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      DropdownButton<int>(
                                                        value: finishSelectedMinute,
                                                        onChanged: (int? newValue) {
                                                          setState(() {
                                                            finishSelectedMinute = newValue!;
                                                            finishTime = finishTime?.copyWith(
                                                              minute: newValue,
                                                            );
                                                          });
                                                        },
                                                        items: List<DropdownMenuItem<int>>.generate(
                                                          60,
                                                          (int index) {
                                                            return DropdownMenuItem<int>(
                                                              value: index,
                                                              child: Text('$index'),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      if (finishTime != null) {
                                                        await timeTrackViewModel.editTimeTrack(
                                                          timeTracking,
                                                          startTime,
                                                          finishTime!,
                                                        );

                                                        if (!context.mounted) return; // https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('Actualizado tiempo'),
                                                          ),
                                                        );
                                                      }
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
                    }),
                  ],
                ),
              ),
            );
          },
    );
  }
}
