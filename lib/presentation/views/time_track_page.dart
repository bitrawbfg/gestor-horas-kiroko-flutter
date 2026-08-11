import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/widgets/data_table_employees.dart';
import 'package:gestor_horas/presentation/widgets/side_panel_time_tracking.dart';
import 'package:provider/provider.dart';
import 'package:side_panel/side_panel.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../configuration/service_locator.dart';

class TimeTrackPage extends StatefulWidget {
  const TimeTrackPage({super.key});

  @override
  State<TimeTrackPage> createState() => _TimeTrackPageState();
}

class _TimeTrackPageState extends State<TimeTrackPage> {
  final _sidePanelController = SidePanelController();

  int? selectedEmployeeId;

  OverlayEntry? _datePickerEntry;
  final GlobalKey _dateButtonKey = GlobalKey();

  final double _pickerOffsetY = 48; // adjust if your button height differs

  void _closeDatePickerOverlay() {
    _datePickerEntry?.remove();
    _datePickerEntry = null;
  }

  void _showDatePickerOverlay(
    BuildContext context,
    EmployeeViewModel employeeViewModel,
    TimeTrackViewModel timeTrackViewModel,
    DateViewModel dateViewModel,
  ) {
    if (_datePickerEntry != null) return;

    final overlay = Overlay.of(context, rootOverlay: true);

    final buttonBox = _dateButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (buttonBox == null) return;

    final buttonSize = buttonBox.size;
    final buttonOffset = buttonBox.localToGlobal(Offset.zero);

    // Where the picker should start (below the button)
    final left = buttonOffset.dx;
    final top = buttonOffset.dy + buttonSize.height + _pickerOffsetY;

    // Keep it inside the viewport: clamp if needed
    final screenSize = MediaQuery.of(context).size;
    final maxWidth = screenSize.width - 16; // small margin
    final desiredWidth = (buttonSize.width + 300).clamp(0, maxWidth) as double;

    // Reduce height so it won't go past bottom too aggressively
    const pickerHeight = 220.0;

    _datePickerEntry = OverlayEntry(
      builder: (context) {
        return TapRegion(
          //behavior: HitTestBehavior.translucent,
          onTapOutside: (tap) {
            // close on outside tap
            if (dateViewModel.isCalendarOpen) dateViewModel.toggleCalendarView();
            // remove after tap processing
            _closeDatePickerOverlay();
          },
          child: Stack(
            children: [
              Positioned(
                left: left,
                top: top,
                width: desiredWidth,
                height: desiredWidth + 80,
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      SizedBox(
                        child: TableCalendar(
                          focusedDay: dateViewModel.selectedDate,
                          firstDay: dateViewModel.minDate,
                          lastDay: dateViewModel.maxDate,
                          rangeStartDay: dateViewModel.firstDayOfWeek,
                          rangeEndDay: dateViewModel.lastDayOfWeek,
                          rangeSelectionMode: RangeSelectionMode.enforced,
                          calendarFormat: CalendarFormat.month,
                          locale: 'es_ES',
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          onDaySelected: (selectedDay, focusedDay) {
                            dateViewModel.setSelectedDate(selectedDay);
                            timeTrackViewModel.loadTimeTrackings();

                            _closeDatePickerOverlay();
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed:
                            (dateViewModel.selectedDate.weekday == DateTime.now().weekday) &&
                                (dateViewModel.selectedDate.day == DateTime.now().day) &&
                                (dateViewModel.selectedDate.month == DateTime.now().month) &&
                                (dateViewModel.selectedDate.year == DateTime.now().year)
                            ? null
                            : () {
                                dateViewModel.setSelectedDate(DateTime.now());
                                _closeDatePickerOverlay();
                              },
                        child: Text('Volver a hoy'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_datePickerEntry!);
  }

  @override
  void dispose() {
    _closeDatePickerOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SidePanel(
      right: Panel(size: 400, overlay: true, child: SidePanelTimeTrackingWidget()),
      controller: locator<SidePanelController>(),
      child: Consumer3<EmployeeViewModel, TimeTrackViewModel, DateViewModel>(
        builder: (context, employeeViewModel, employeeTimeTrackViewModel, dateViewModel, child) {
          List<EmployeeModel> employees = employeeViewModel.employees;

          if (selectedEmployeeId == null && employees.isNotEmpty) {
            selectedEmployeeId = employees.first.id;
          }

          final selectedEmployee = employees
              .where((employee) => employee.id == selectedEmployeeId)
              .firstOrNull;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<EmployeeModel>(
                    onChanged: (EmployeeModel? value) {
                      setState(() {
                        selectedEmployeeId = value!.id;
                      });
                    },
                    value: selectedEmployee,
                    items: employees
                        .map<DropdownMenuItem<EmployeeModel>>(
                          (EmployeeModel employee) => DropdownMenuItem(
                            value: employee,
                            child: Row(children: [Text(employee.name)]),
                          ),
                        )
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedEmployee?.currentTimeTrack?.startTime == null
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(80, 80),
                                foregroundColor: Colors.blue,
                              ),
                              onPressed: () async {
                                EmployeeModel? employeeWithTimeStart =
                                    await employeeTimeTrackViewModel.addTimeStart(
                                      selectedEmployee!,
                                    );
                                await employeeViewModel.updateEmployee(employeeWithTimeStart!);
                              },
                              child: const Icon(Icons.play_arrow),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(80, 80),
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                if (selectedEmployee?.currentTimeTrack != null ||
                                    selectedEmployee?.currentTimeTrack?.startTime != null) {
                                  int differenceBetweenTimes = DateTime.now()
                                      .difference(selectedEmployee!.currentTimeTrack!.startTime!)
                                      .inMinutes;

                                  if (differenceBetweenTimes != 0) {
                                    await employeeTimeTrackViewModel.addTimeFinish(
                                      selectedEmployee!,
                                    );
                                  } else {
                                    await employeeTimeTrackViewModel.deleteTimeTrack(
                                      selectedEmployee!.currentTimeTrack!,
                                    );
                                  }

                                  employeeViewModel.updateEmployee(
                                    selectedEmployee.copyWith(currentTimeTrack: null),
                                  );
                                }
                              },
                              child: const Icon(Icons.stop_circle),
                            ),

                      // Date button (anchors the overlay)
                      ElevatedButton(
                        key: _dateButtonKey,
                        onPressed: () {
                          dateViewModel.toggleCalendarView();

                          // show immediately (so it feels responsive)
                          // (overlay insertion is also handled in addPostFrameCallback)
                          if (dateViewModel.isCalendarOpen) {
                            _showDatePickerOverlay(
                              context,
                              employeeViewModel,
                              employeeTimeTrackViewModel,
                              dateViewModel,
                            );
                          } else {
                            _closeDatePickerOverlay();
                          }
                        },
                        child: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                  DataTableEmployees(
                    employeeTimeTrackViewModel: employeeTimeTrackViewModel,
                    employeeViewModel: employeeViewModel,
                    dateViewModel: dateViewModel,
                    sidePanelController: _sidePanelController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
