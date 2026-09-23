import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_selection_data.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/data/models/shift_time_data.dart';
import 'package:gestor_horas/presentation/widgets/employee_selection_widget.dart';
import 'package:gestor_horas/presentation/widgets/time_selection_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../configuration/service_locator.dart';
import '../../data/models/weekdays_enum.dart';
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
      bool isSplitShift = schedule.isSplitShift;

      Meeting appointment = Meeting(
        recurrenceRule: 'FREQ=WEEKLY;BYDAY=${schedule.weekdays.join(',').toUpperCase()}',
        from: schedule.startFirstTurnTime,
        to: schedule.finishFirstTurnTime,
        eventName: 'Turno',
        schedule: schedule,
      );

      _appointments.add(appointment);

      if (isSplitShift) {
        ScheduleModel scheduleModel = schedule;

        Meeting appointment = Meeting(
          recurrenceRule: 'FREQ=WEEKLY;BYDAY=${schedule.weekdays.join(',').toUpperCase()}',
          from: schedule.startSecondTurnTime!,
          to: schedule.finishSecondTurnTime!,
          eventName: 'Turno',
          schedule: scheduleModel,
        );

        _appointments.add(appointment);
      }
    }

    dataSource = MeetingDataSource(_appointments);
  }

  Widget hourSelectionWidget({List<Widget>? widgets}) {
    return Placeholder();
  }

  void _showScheduleForm(BuildContext context, {ScheduleModel? schedule}) {
    showDialog(
      context: context,
      builder: (context) {
        EmployeeModel? selectedEmployee;
        ShiftTimeData shiftTimeData = selectedEmployee != null
            ? ShiftTimeData(
                startHour: selectedEmployee.schedules![0].startFirstTurnTime.hour,
                startMinute: selectedEmployee.schedules![0].startFirstTurnTime.minute,
                endHour: selectedEmployee.schedules![0].finishFirstTurnTime.hour,
                endMinute: selectedEmployee.schedules![0].finishFirstTurnTime.minute,
              )
            : ShiftTimeData();

        List<ShiftTimeData> shiftsData = [shiftTimeData];

        List<EmployeeSelectionData> employeesData =
            schedule != null && schedule.employeeWeekAssignments.isNotEmpty
            ? schedule.employeeWeekAssignments.toList()
            : [EmployeeSelectionData()];

        final ScrollController scrollController = ScrollController();

        List<Map<String, String>> weekDaysName = [
          {'Lunes': 'Mo'},
          {'Martes': 'Tu'},
          {'Miércoles': 'We'},
          {'Jueves': 'Th'},
          {'Viernes': 'Fr'},
          {'Sábado': 'Sa'},
          {'Domingo': 'Su'},
        ];

        // Checks if the schedule has days selected
        final List<int> selectedDays = [];
        if (schedule != null) {
          for (int i = 0; i < weekDaysName.length; i++) {
            for (String weekday in schedule.weekdays) {
              if (weekDaysName[i].containsValue(weekday)) {
                selectedDays.add(i);
              }
            }
          }
        }

        // If the schedule has days selected, add a true value to the controller
        List<bool?> weekDayControllers = List.filled(7, false);
        if (selectedDays.isNotEmpty) {
          for (int selectedDay in selectedDays) {
            for (int i = 0; i < weekDayControllers.length; i++) {
              if (selectedDay == i) {
                weekDayControllers[i] = true;
              }
            }
          }
        }

        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text(schedule == null ? 'Añadir un nuevo horario' : 'Editar horario'),
              content: SizedBox(
                width: 600,
                height: 600,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Selecciona un horario', style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 4),
                        ...shiftsData.map((data) => TimeSelectionWidget(shiftTimeData: data)),
                        ElevatedButton(
                          onPressed: () {
                            if (shiftsData.length < 2) {
                              setState(() {
                                shiftsData.add(ShiftTimeData());
                              });
                            } else {
                              setState(() {
                                shiftsData.removeLast();
                              });
                            }
                          },
                          child: Icon(shiftsData.length < 2 ? Icons.add : Icons.remove),
                        ),
                        Divider(height: 32),

                        Text('Selecciona los días de la semana', style: TextStyle(fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(weekDaysName.length, (index) {
                                  return SizedBox(
                                    width: 140,
                                    height: 70,
                                    child: CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      contentPadding: const EdgeInsets.all(6),
                                      title: Text(weekDaysName[index].keys.first),
                                      value: weekDayControllers[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          weekDayControllers[index] = value;
                                        });
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 32),

                        Text('Asigna empleados', style: TextStyle(fontSize: 20)),
                        ...employeesData.map(
                          (data) => EmployeeSelectionWidget(
                            employeeSelectionData: data,
                            onDelete: employeesData.length > 1
                                ? () => setState(() => employeesData.remove(data))
                                : null,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (employeesData.length < 4) {
                              setState(() {
                                employeesData.add(EmployeeSelectionData());
                              });
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    final DateTime now = DateTime(2000, 1, 1);
                    final ShiftTimeData shiftData = shiftsData[0];

                    final List<String> selectedDays = [];
                    for (int i = 0; i < weekDayControllers.length; i++) {
                      if (weekDayControllers[i] == true) {
                        selectedDays.add(weekDaysName[i].values.first);
                      }
                    }

                    final bool isSplitShift = shiftsData.length > 1;
                    final scheduleToInsert =
                        schedule ??
                        ScheduleModel(
                          isSplitShift: isSplitShift,
                          startFirstTurnTime: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            shiftData.startHour,
                            shiftData.startMinute,
                          ),
                          finishFirstTurnTime: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            shiftData.endHour,
                            shiftData.endMinute,
                          ),
                          startSecondTurnTime: isSplitShift
                              ? DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  shiftsData[1].startHour,
                                  shiftsData[1].startMinute,
                                )
                              : null,
                          finishSecondTurnTime: isSplitShift
                              ? DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  shiftsData[1].endHour,
                                  shiftsData[1].endMinute,
                                )
                              : null,
                          weekdays: selectedDays,
                        );

                    locator<ScheduleViewModel>().addScheduleForEmployee(
                      scheduleToInsert,
                      employeesData,
                    );
                    /*final List<Map<String, dynamic>> employeeScheduleAssignments = [];
                    for (EmployeeSelectionData employeeData in employeesData) {
                      if (employeeData.weekdayEnum != null && employeeData.selectedEmployee != null) {
                        for (String selectedDay in selectedDays) {
                          employeeScheduleAssignments.add({
                            'id_employee': employeeData.selectedEmployee?.id,
                            'weekday': selectedDay,
                            'assigned_week': employeeData.weekdayEnum?.value,
                          });
                        }
                      }
                    }

                    locator<ScheduleViewModel>().addScheduleWithAssignments(schedule: schedule, assignations: employeeScheduleAssignments);*/

                    Navigator.pop(context);
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
              onTap: (CalendarTapDetails details) {
                Meeting? appointment = details.appointments?.first;
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
