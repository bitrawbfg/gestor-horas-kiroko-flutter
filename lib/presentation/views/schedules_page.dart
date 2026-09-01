import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/data/models/weekdays_enum.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../configuration/service_locator.dart';
import '../view_models/employee_viewmodel.dart';
import '../view_models/schedule_view_model.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  final List<ScheduleModel> _schedules = List.empty(growable: true);
  final List<Appointment> _appointments = List.empty(growable: true);
  late EmpleadosDataSource dataSource;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await locator<ScheduleViewModel>().loadSchedules();
      _schedules.addAll(locator<ScheduleViewModel>().schedules);
      await loadAppointments();
    });
  }

  Future<void> loadAppointments() async {
    for (ScheduleModel schedule in _schedules) {
      Appointment appointment = Appointment(
        startTime: schedule.startFirstTurnTime,
        endTime: schedule.finishFirstTurnTime,
        subject: 'Turno',
      );

      _appointments.add(appointment);
    }

    dataSource = EmpleadosDataSource(source: _appointments);
    print(_appointments);
  }

  void _showScheduleForm(BuildContext context, {ScheduleModel? schedule}) {
    showDialog(
      context: context,
      builder: (context) {
        bool isSplitShift = schedule?.isSplitShift ?? false;
        WeekdaysEnum weekdayEnum = WeekdaysEnum.week1;
        EmployeeModel? selectedEmployee;

        int startSelectedHour = DateTime.now().hour;
        int startSelectedMinute = DateTime.now().minute;
        int finishSelectedHour = DateTime.now().hour;
        int finishSelectedMinute = DateTime.now().minute;

        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text(schedule == null ? 'Añadir un nuevo horario' : 'Editar horario'),
              content: SizedBox(
                width: 800,
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DropdownButton<EmployeeModel>(
                            hint: Text('Selecciona a un empleado'),
                            items: locator<EmployeeViewModel>().employees.map((
                              EmployeeModel employee,
                            ) {
                              return DropdownMenuItem(value: employee, child: Text(employee.name));
                            }).toList(),
                            onChanged: (EmployeeModel? employee) {
                              setState(() {
                                {
                                  selectedEmployee = employee!;
                                }
                              });
                            },
                            value: selectedEmployee,
                          ),
                        ),
                        Expanded(
                          child: DropdownButton<WeekdaysEnum>(
                            items: WeekdaysEnum.values.map((WeekdaysEnum weekday) {
                              return DropdownMenuItem(value: weekday, child: Text(weekday.value));
                            }).toList(),
                            onChanged: (WeekdaysEnum? weekday) {
                              setState(() {
                                {
                                  weekdayEnum = weekday!;
                                }
                              });
                            },
                            value: weekdayEnum,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: Text(
                              'Es turno partido',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            value: isSplitShift,
                            onChanged: (bool? value) => setState(() {
                              isSplitShift = value!;
                            }),
                          ),
                        ),
                      ],
                    ),
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
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(24, (int index) {
                                return DropdownMenuItem<int>(
                                  enabled: finishSelectedHour >= index,
                                  value: index,
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      color: (finishSelectedHour < index)
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
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(60, (int index) {
                                return DropdownMenuItem<int>(
                                  enabled: finishSelectedMinute >= index,
                                  value: index,
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      color: (finishSelectedMinute < index)
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
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
                                    });
                                  },
                                  items: List<DropdownMenuItem<int>>.generate(24, (int index) {
                                    return DropdownMenuItem<int>(
                                      enabled: startSelectedHour <= index,
                                      value: index,
                                      child: Text(
                                        '$index',
                                        style: TextStyle(
                                          color: (startSelectedHour > index)
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
                                    });
                                  },
                                  items: List<DropdownMenuItem<int>>.generate(60, (int index) {
                                    return DropdownMenuItem<int>(
                                      enabled: startSelectedMinute <= index,
                                      value: index,
                                      child: Text(
                                        '$index',
                                        style: TextStyle(
                                          color: (startSelectedMinute > index)
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
                      ],
                    ),
                    isSplitShift
                        ? Row(
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
                                      });
                                    },
                                    items: List<DropdownMenuItem<int>>.generate(24, (int index) {
                                      return DropdownMenuItem<int>(
                                        enabled: finishSelectedHour >= index,
                                        value: index,
                                        child: Text(
                                          '$index',
                                          style: TextStyle(
                                            color: (finishSelectedHour < index)
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
                                      });
                                    },
                                    items: List<DropdownMenuItem<int>>.generate(60, (int index) {
                                      return DropdownMenuItem<int>(
                                        enabled: finishSelectedMinute >= index,
                                        value: index,
                                        child: Text(
                                          '$index',
                                          style: TextStyle(
                                            color: (finishSelectedMinute < index)
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
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
                                          });
                                        },
                                        items: List<DropdownMenuItem<int>>.generate(24, (
                                          int index,
                                        ) {
                                          return DropdownMenuItem<int>(
                                            enabled: startSelectedHour <= index,
                                            value: index,
                                            child: Text(
                                              '$index',
                                              style: TextStyle(
                                                color: (startSelectedHour > index)
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
                                          });
                                        },
                                        items: List<DropdownMenuItem<int>>.generate(60, (
                                          int index,
                                        ) {
                                          return DropdownMenuItem<int>(
                                            enabled: startSelectedMinute <= index,
                                            value: index,
                                            child: Text(
                                              '$index',
                                              style: TextStyle(
                                                color: (startSelectedMinute > index)
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
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedEmployee != null) {
                      DateTime startTime = DateTime.now().copyWith(
                        hour: startSelectedHour,
                        minute: startSelectedMinute,
                        second: 0,
                      );
                      DateTime finishTime = DateTime.now().copyWith(
                        hour: finishSelectedHour,
                        minute: finishSelectedMinute,
                        second: 0,
                      );

                      ScheduleModel schedule = ScheduleModel(
                        startFirstTurnTime: startTime,
                        finishFirstTurnTime: finishTime,
                      );
                      locator<ScheduleViewModel>().addSchedule(schedule, selectedEmployee!.id!);

                      Navigator.pop(context);
                    } else {
                      // TODO: Añadir barra informativa sobre error al añadir empleado
                    }
                  },
                  child: Text(schedule == null ? 'Añadir nuevo empleado' : 'Editar empleado'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.redAccent),
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios de Empleados'),
        actions: [
          ElevatedButton(
            onPressed: () {
              _showScheduleForm(context);
            },
            child: Icon(Icons.add_alarm),
          ),
        ],
      ),
      body: Consumer<ScheduleViewModel>(
        builder: (BuildContext context, ScheduleViewModel viewModel, Widget? child) {
          return Expanded(
            child: SfCalendar(
              timeSlotViewSettings: TimeSlotViewSettings(startHour: 6, endHour: 24),
              onTap: (CalendarTapDetails nepe) {
                _showScheduleForm(context);
              },
              firstDayOfWeek: 1,
              allowViewNavigation: false,
              view: CalendarView.week,
              dataSource: dataSource,
              allowDragAndDrop: true,
              allowAppointmentResize: true,
              onDragEnd: (AppointmentDragEndDetails detalles) {
                final Appointment? turnoModificado = detalles.appointment as Appointment?;
                final DateTime? nuevaHoraInicio = detalles.droppingTime;

                if (turnoModificado != null && nuevaHoraInicio != null) {
                  // Calcular la duración original del turno para mantenerla al moverlo
                  final DateTime horaInicioAjustada = redondearA30Minutos(nuevaHoraInicio);
                  final Duration duracionOriginal = turnoModificado.endTime.difference(
                    turnoModificado.startTime,
                  );

                  setState(() {
                    turnoModificado.startTime = horaInicioAjustada;
                    // Mantenemos la duración original partiendo desde la hora ajustada
                    turnoModificado.endTime = horaInicioAjustada.add(duracionOriginal);
                  });
                  // Notificar al origen de datos que la lista cambió
                  dataSource.notifyListeners(CalendarDataSourceAction.reset, _appointments);
                }
              },

              // SOLUCIÓN AL PROBLEMA 1 (CONTINUACIÓN): Capturar el final del redimensionamiento
              onAppointmentResizeEnd: (AppointmentResizeEndDetails detalles) {
                final Appointment? turnoModificado = detalles.appointment as Appointment?;

                if (turnoModificado != null) {
                  setState(() {
                    // Asignamos las horas exactas calculadas por el widget al estirarlo
                    turnoModificado.startTime = redondearA30Minutos(detalles.startTime!);
                    turnoModificado.endTime = redondearA30Minutos(detalles.endTime!);
                  });

                  // Forzar al calendario a redibujarse correctamente con los nuevos datos
                  dataSource.notifyListeners(CalendarDataSourceAction.reset, _appointments);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// Clase obligatoria para enlazar los datos con Syncfusion
class EmpleadosDataSource extends CalendarDataSource {
  EmpleadosDataSource({required List<Appointment> source}) {
    appointments = source;
  }
}

DateTime redondearA30Minutos(DateTime fechaOriginal) {
  int minutos = fechaOriginal.minute;
  int hora = fechaOriginal.hour;
  DateTime dia = DateTime(fechaOriginal.year, fechaOriginal.month, fechaOriginal.day);

  if (minutos < 15) {
    minutos = 0;
  } else if (minutos >= 15 && minutos < 45) {
    minutos = 30;
  } else {
    minutos = 0;
    hora += 1;
  }

  return dia.add(Duration(hours: hora, minutes: minutos));
}
