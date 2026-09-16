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

  Widget hourSelectionWidget({List<Widget>? widgets}) {
    return Placeholder();
  }

  void _showScheduleForm(BuildContext context, {ScheduleModel? schedule}) {
    showDialog(
      context: context,
      builder: (context) {
        bool isSplitShift = schedule?.isSplitShift ?? false;
        EmployeeModel? selectedEmployee;

        int startFirstShiftSelectedHour = schedule?.startFirstTurnTime.hour ?? 8;
        int startFirstShiftSelectedMinute = schedule?.startFirstTurnTime.minute ?? 0;
        int finishFirstShiftSelectedHour = schedule?.finishFirstTurnTime.hour ?? 15;
        int finishFirstShiftSelectedMinute = schedule?.finishFirstTurnTime.minute ?? 0;

        int startSecondShiftSelectedHour = 15;
        int startSecondShiftSelectedMinute = 0;
        int finishSecondShiftSelectedHour = 23;
        int finishSecondShiftSelectedMinute = 0;

        ShiftTimeData shiftTimeData = selectedEmployee != null ? ShiftTimeData(startHour: selectedEmployee.schedules![0].startFirstTurnTime.hour) : ShiftTimeData();

        List<ShiftTimeData> shiftsData = [shiftTimeData];
        List<EmployeeSelectionData> employeeWidgets = [EmployeeSelectionData()];

        final ScrollController scrollController = ScrollController();

        List<bool?> controllers = List.filled(7, false);
        List<String> weekDaysName = [
          'Lunes',
          'Martes',
          'Miércoles',
          'Jueves',
          'Viernes',
          'Sábado',
          'Domingo',
        ];

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
                                      title: Text(weekDaysName[index]),
                                      value: controllers[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controllers[index] = value;
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
                        ...employeeWidgets.map(
                          (data) => EmployeeSelectionWidget(
                            employeeSelectionData: data,
                            onDelete: employeeWidgets.length > 1
                                ? () => setState(() => employeeWidgets.remove(data))
                                : null,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (employeeWidgets.length < 4) {
                              setState(() {
                                employeeWidgets.add(EmployeeSelectionData());
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
                    for (int i = 0; i < 7; i++) {
                      print('${controllers[i]} ${weekDaysName[i]}');
                    }

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
                          schedule.copyWith(
                            startFirstTurnTime: newSchedule.startFirstTurnTime,
                            finishFirstTurnTime: newSchedule.finishFirstTurnTime,
                          ),
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
