import 'dart:collection';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_viewmodel.dart';
import 'package:provider/provider.dart';

class TimeTrackPage extends StatefulWidget {
  const TimeTrackPage({super.key});

  @override
  State<TimeTrackPage> createState() => _TimeTrackPageState();
}

class _TimeTrackPageState extends State<TimeTrackPage> {
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
    EmployeeTimeTrackViewmodel timeTrackViewModel,
  ) {
    if (_datePickerEntry != null) return;

    final overlay = Overlay.of(context, rootOverlay: true);

    final buttonBox =
        _dateButtonKey.currentContext?.findRenderObject() as RenderBox?;
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
            if (employeeViewModel.open) employeeViewModel.toggle();
            // remove after tap processing
            _closeDatePickerOverlay();
          },
          child: Stack(
            children: [
              Positioned(
                left: left,
                top: top,
                width: desiredWidth,
                height: desiredWidth - 40,
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      SizedBox(
                        height: pickerHeight + 40,
                        child: CalendarDatePicker(
                          initialDate:
                              employeeViewModel.selectedDate ?? DateTime.now(),
                          firstDate: employeeViewModel.firstDate,
                          lastDate: employeeViewModel.lastDate,
                          onDateChanged: (date) {
                            employeeViewModel.setDate(date);
                            timeTrackViewModel.loadTimeTrackings(
                              selectedDay: date,
                            );

                            _closeDatePickerOverlay();
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed:
                            (employeeViewModel.selectedDate.weekday ==
                                    DateTime.now().weekday) &&
                                (employeeViewModel.selectedDate.day ==
                                    DateTime.now().day) &&
                                (employeeViewModel.selectedDate.month ==
                                    DateTime.now().month) &&
                                (employeeViewModel.selectedDate.year ==
                                    DateTime.now().year)
                            ? null
                            : () {
                                employeeViewModel.setDate(DateTime.now());
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
    EmployeeViewModel viewModel = context.watch<EmployeeViewModel>();

    return Consumer2<EmployeeViewModel, EmployeeTimeTrackViewmodel>(
      builder: (context, employeeViewModel, employeeTimeTrackViewModel, child) {
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
                    selectedEmployee?.currentTimeTrack?.start_time == null
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
                              await employeeViewModel.updateEmployee(
                                employeeWithTimeStart!,
                              );
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
                                  selectedEmployee
                                          ?.currentTimeTrack
                                          ?.start_time !=
                                      null) {
                                await employeeTimeTrackViewModel.addTimeFinish(
                                  selectedEmployee!,
                                );

                                employeeViewModel.updateEmployee(
                                  selectedEmployee.copyWith(
                                    currentTimeTrack: null,
                                  ),
                                );
                              }
                            },
                            child: const Icon(Icons.stop_circle),
                          ),

                    // Date button (anchors the overlay)
                    ElevatedButton(
                      key: _dateButtonKey,
                      onPressed: () {
                        employeeViewModel.toggle();

                        // show immediately (so it feels responsive)
                        // (overlay insertion is also handled in addPostFrameCallback)
                        if (employeeViewModel.open) {
                          _showDatePickerOverlay(
                            context,
                            employeeViewModel,
                            employeeTimeTrackViewModel,
                          );
                        } else {
                          _closeDatePickerOverlay();
                        }
                      },
                      child: Icon(Icons.calendar_month),
                    ),

                    // Remove your old Expanded + AnimatedSize picker here.
                    // The overlay will render above everything else.
                  ],
                ),
                DataTableEmployees(
                  employeeTimeTrackViewModel: employeeTimeTrackViewModel,
                  employeeViewModel: employeeViewModel,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DataTableEmployees extends StatelessWidget {
  const DataTableEmployees({
    super.key,
    required this.employeeViewModel,
    required this.employeeTimeTrackViewModel,
  });

  final EmployeeViewModel employeeViewModel;
  final EmployeeTimeTrackViewmodel employeeTimeTrackViewModel;

  @override
  Widget build(BuildContext context) {
    DateTime startOfWeek = employeeViewModel.selectedDate.subtract(
      Duration(days: employeeViewModel.selectedDate.weekday - 1),
    );

    List<DateTime> weekDates = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });

    return Expanded(
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: [
          DataColumn2(label: Text('Nombre'), size: ColumnSize.L),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text('Lunes', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${weekDates[0].day}',
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
                  '${weekDates[1].day}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Column(
              children: [
                Text(
                  'Miércoles',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${weekDates[2].day}',
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
                  '${weekDates[3].day}',
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
                  '${weekDates[4].day}',
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
                  '${weekDates[5].day}',
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
                  '${weekDates[6].day}',
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
        rows: List<DataRow>.generate(employeeViewModel.employees.length, (
          index,
        ) {
          EmployeeModel employee = employeeViewModel.employees[index];
          int timeWorkedInWeek = employeeTimeTrackViewModel
              .getTimeWorkedInWeekByEmployee(
                employee.id!,
                weekDates[0],
                weekDates[6],
              );

          return DataRow(
            cells: [
              DataCell(Text(employee.name)),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        0,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        1,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        2,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        3,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        4,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        5,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: employeeTimeTrackViewModel
                      .checkColumnWeekDayWithTimeTrackings(
                        6,
                        employee.id!,
                        weekDates,
                      ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    timeWorkedInWeek == 0 ? '-' : '$timeWorkedInWeek',
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
