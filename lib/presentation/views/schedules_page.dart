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
  final List<Meeting> _appointments = List.empty(growable: true);
  late final MeetingDataSource dataSource;

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
      Meeting appointment = Meeting(
        recurrenceRule: 'FREQ=WEEKLY;INTERVAL=3;BYDAY=MO,TU,WE,TH,FR',
        from: schedule.startFirstTurnTime,
        to: schedule.finishFirstTurnTime,
        eventName: 'Turno',
        schedule: schedule,
      );

      print(WeekDays.monday.name.substring(0, 2));

      _appointments.add(appointment);
    }

    dataSource = MeetingDataSource(_appointments);
  }

  void _showScheduleForm(BuildContext context, {ScheduleModel? schedule}) {
    showDialog(
      context: context,
      builder: (context) {
        bool isSplitShift = schedule?.isSplitShift ?? false;
        WeekdaysEnum weekdayEnum = WeekdaysEnum.week1;
        EmployeeModel? selectedEmployee;

        int startFirstShiftSelectedHour = schedule?.startFirstTurnTime.hour ?? 8;
        int startFirstShiftSelectedMinute = schedule?.startFirstTurnTime.minute ?? 0;
        int finishFirstShiftSelectedHour = schedule?.finishFirstTurnTime.hour ?? 15;
        int finishFirstShiftSelectedMinute = schedule?.finishFirstTurnTime.minute ?? 0;

        int startSecondShiftSelectedHour = 15;
        int startSecondShiftSelectedMinute = 0;
        int finishSecondShiftSelectedHour = 23;
        int finishSecondShiftSelectedMinute = 0;

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
                              value: startFirstShiftSelectedHour,
                              onChanged: (int? newValue) {
                                setState(() {
                                  startFirstShiftSelectedHour = newValue!;
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(24, (int index) {
                                return DropdownMenuItem<int>(
                                  enabled: finishFirstShiftSelectedHour >= index,
                                  value: index,
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      color: (finishFirstShiftSelectedHour < index)
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            DropdownButton<int>(
                              value: startFirstShiftSelectedMinute,
                              onChanged: (int? newValue) {
                                setState(() {
                                  startFirstShiftSelectedMinute = newValue!;
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(60, (int index) {
                                return DropdownMenuItem<int>(
                                  enabled: finishFirstShiftSelectedMinute >= index,
                                  value: index,
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      color: (finishFirstShiftSelectedMinute < index)
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
                                  value: finishFirstShiftSelectedHour,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      finishFirstShiftSelectedHour = newValue!;
                                    });
                                  },
                                  items: List<DropdownMenuItem<int>>.generate(24, (int index) {
                                    return DropdownMenuItem<int>(
                                      enabled: startFirstShiftSelectedHour <= index,
                                      value: index,
                                      child: Text(
                                        '$index',
                                        style: TextStyle(
                                          color: (startFirstShiftSelectedHour > index)
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                DropdownButton<int>(
                                  value: finishFirstShiftSelectedMinute,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      finishFirstShiftSelectedMinute = newValue!;
                                    });
                                  },
                                  items: List<DropdownMenuItem<int>>.generate(60, (int index) {
                                    return DropdownMenuItem<int>(
                                      enabled: startFirstShiftSelectedMinute <= index,
                                      value: index,
                                      child: Text(
                                        '$index',
                                        style: TextStyle(
                                          color: (startFirstShiftSelectedMinute > index)
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
                                    value: startSecondShiftSelectedHour,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        startSecondShiftSelectedHour = newValue!;
                                      });
                                    },
                                    items: List<DropdownMenuItem<int>>.generate(24, (int index) {
                                      return DropdownMenuItem<int>(
                                        enabled: finishSecondShiftSelectedHour >= index,
                                        value: index,
                                        child: Text(
                                          '$index',
                                          style: TextStyle(
                                            color: (finishSecondShiftSelectedHour < index)
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  DropdownButton<int>(
                                    value: startSecondShiftSelectedMinute,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        startSecondShiftSelectedMinute = newValue!;
                                      });
                                    },
                                    items: List<DropdownMenuItem<int>>.generate(60, (int index) {
                                      return DropdownMenuItem<int>(
                                        enabled: finishSecondShiftSelectedMinute >= index,
                                        value: index,
                                        child: Text(
                                          '$index',
                                          style: TextStyle(
                                            color: (finishSecondShiftSelectedMinute < index)
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
                                        value: finishSecondShiftSelectedHour,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            finishSecondShiftSelectedHour = newValue!;
                                          });
                                        },
                                        items: List<DropdownMenuItem<int>>.generate(24, (
                                          int index,
                                        ) {
                                          return DropdownMenuItem<int>(
                                            enabled: startSecondShiftSelectedHour <= index,
                                            value: index,
                                            child: Text(
                                              '$index',
                                              style: TextStyle(
                                                color: (startSecondShiftSelectedHour > index)
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      DropdownButton<int>(
                                        value: finishSecondShiftSelectedMinute,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            finishSecondShiftSelectedMinute = newValue!;
                                          });
                                        },
                                        items: List<DropdownMenuItem<int>>.generate(60, (
                                          int index,
                                        ) {
                                          return DropdownMenuItem<int>(
                                            enabled: startSecondShiftSelectedMinute <= index,
                                            value: index,
                                            child: Text(
                                              '$index',
                                              style: TextStyle(
                                                color: (startSecondShiftSelectedMinute > index)
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
                      ScheduleModel newSchedule = createNewSchedule(
                        startFirstShiftSelectedHour,
                        startFirstShiftSelectedMinute,
                        finishFirstShiftSelectedHour,
                        finishFirstShiftSelectedMinute,
                      );

                      if (schedule == null) {
                        locator<ScheduleViewModel>().addSchedule(
                          newSchedule,
                          selectedEmployee!.id!,
                        );
                      } else {
                        locator<ScheduleViewModel>().updateSchedule(
                          schedule.copyWith(startFirstTurnTime: newSchedule.startFirstTurnTime, finishFirstTurnTime: newSchedule.finishFirstTurnTime),
                          selectedEmployee!.id!,
                        );
                      }

                      if (isSplitShift) {
                        ScheduleModel schedule = createNewSchedule(
                          startSecondShiftSelectedHour,
                          startSecondShiftSelectedMinute,
                          finishSecondShiftSelectedHour,
                          finishSecondShiftSelectedMinute,
                        );
                        locator<ScheduleViewModel>().addSchedule(schedule, selectedEmployee!.id!);
                      }



                      Navigator.pop(context);
                    } else {
                      // TODO: Añadir barra informativa sobre error al añadir empleado
                    }
                  },
                  child: Text(schedule == null ? 'Añadir nuevo turno' : 'Editar turno'),
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

  ScheduleModel createNewSchedule(
    int startFirstShiftSelectedHour,
    int startFirstShiftSelectedMinute,
    int finishFirstShiftSelectedHour,
    int finishFirstShiftSelectedMinute,
  ) {
    DateTime startTime = DateTime.now().copyWith(
      hour: startFirstShiftSelectedHour,
      minute: startFirstShiftSelectedMinute,
      second: 0,
    );
    DateTime finishTime = DateTime.now().copyWith(
      hour: finishFirstShiftSelectedHour,
      minute: finishFirstShiftSelectedMinute,
      second: 0,
    );

    ScheduleModel schedule = ScheduleModel(
      startFirstTurnTime: startTime,
      finishFirstTurnTime: finishTime,
    );
    return schedule;
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
                Meeting? appointment = nepe.appointments?.first;
                if (appointment != null) {
                  _showScheduleForm(context, schedule: appointment.schedule);
                }
              },
              firstDayOfWeek: 1,
              allowViewNavigation: false,
              view: CalendarView.week,
              dataSource: dataSource,
              allowDragAndDrop: false,
              allowAppointmentResize: false,
            ),
          );
        },
      ),
    );
  }
}

class Meeting {
  Object? id;
  String? eventName;
  DateTime from;
  DateTime to;
  Color? background;
  bool? isAllDay;
  ScheduleModel schedule;
  String? recurrenceRule;
  Object? recurrenceId;
  List<DateTime>? exceptionDates;

  Meeting({
    this.id,
    this.eventName,
    required this.from,
    required this.to,
    this.background,
    this.isAllDay,
    required this.schedule,
    this.recurrenceRule,
    this.recurrenceId,
    this.exceptionDates,
  });
}

class MeetingDataSource extends CalendarDataSource<Meeting> {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  Object? getId(int index) {
    return appointments![index].id;
  }

  @override
  Object? getRecurrenceId(int index) {
    return appointments![index].recurrenceId as Object?;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background ?? Colors.blue;
  }

  @override
  List<DateTime>? getRecurrenceExceptionDates(int index) {
    return appointments![index].exceptionDates as List<DateTime>?;
  }

  @override
  String? getRecurrenceRule(int index) {
    return appointments![index].recurrenceRule;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName as String;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay == null ? false : appointments![index].isAllDay as bool;
  }

  @override
  Meeting? convertAppointmentToObject(Meeting? customData, Appointment appointment) {
    // TODO: implement convertAppointmentToObject
    return Meeting(
      from: appointment.startTime,
      to: appointment.endTime,
      eventName: appointment.subject,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
      id: appointment.id,
      recurrenceRule: appointment.recurrenceRule,
      recurrenceId: appointment.recurrenceId,
      exceptionDates: appointment.recurrenceExceptionDates,
      schedule: customData!.schedule,
    );
  }
}
