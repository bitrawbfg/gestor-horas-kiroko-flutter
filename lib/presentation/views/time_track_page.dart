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

  final LayerLink _datePickerLink = LayerLink();
  OverlayEntry? _datePickerEntry;
  final GlobalKey _dateButtonKey = GlobalKey();

  final double _pickerOffsetY = 48; // adjust if your button height differs

  void _removeDatePickerOverlay() {
    _datePickerEntry?.remove();
    _datePickerEntry = null;
  }

  void _showDatePickerOverlay(BuildContext context, EmployeeViewModel vm) {
    // prevent duplicates
    if (_datePickerEntry != null) return;

    // measure button width so picker aligns nicely
    final buttonBox =
        _dateButtonKey.currentContext?.findRenderObject() as RenderBox?;
    final buttonWidth = buttonBox?.size.width;

    _datePickerEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (vm.open) vm.toggle();
            _removeDatePickerOverlay();
          },
          child: Stack(
            children: [
              CompositedTransformFollower(
                link: _datePickerLink,
                showWhenUnlinked: false,
                offset: Offset(0, _pickerOffsetY),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: Expanded(
                    child: SizedBox(
                      width: buttonWidth! + 300,
                      height: 320, // try 180–220
                      child: CalendarDatePicker(
                        initialDate: vm.selectedDate ?? DateTime.now(),
                        firstDate: vm.firstDate,
                        lastDate: vm.lastDate,
                        onDateChanged: (d) {
                          vm.setDate(d);
                          _removeDatePickerOverlay();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_datePickerEntry!);
  }

  @override
  void dispose() {
    _removeDatePickerOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startOfWeek = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );

    List<DateTime> weekDates = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });

    return Consumer2<EmployeeViewModel, EmployeeTimeTrackViewmodel>(
      builder: (context, employeeViewModel, employeeTimeTrackViewModel, child) {
        List<EmployeeModel> employees = employeeViewModel.employees;

        if (selectedEmployeeId == null && employees.isNotEmpty) {
          selectedEmployeeId = employees.first.id;
        }

        final selectedEmployee = employees
            .where((employee) => employee.id == selectedEmployeeId)
            .firstOrNull;

        // keep overlay in sync with vm.open
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final vm = employeeViewModel;
          if (vm.open && _datePickerEntry == null) {
            _showDatePickerOverlay(context, vm);
          } else if (!vm.open && _datePickerEntry != null) {
            _removeDatePickerOverlay();
          }
        });

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
                              await employeeViewModel.addTimeStart(
                                selectedEmployee!,
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
                                await employeeViewModel.addTimeFinish(
                                  selectedEmployee!,
                                );
                              }
                            },
                            child: const Icon(Icons.stop_circle),
                          ),

                    // Date button (anchors the overlay)
                    CompositedTransformTarget(
                      link: _datePickerLink,
                      child: ElevatedButton(
                        key: _dateButtonKey,
                        onPressed: () {
                          employeeViewModel.toggle();

                          // show immediately (so it feels responsive)
                          // (overlay insertion is also handled in addPostFrameCallback)
                          if (employeeViewModel.open) {
                            _showDatePickerOverlay(context, employeeViewModel);
                          } else {
                            _removeDatePickerOverlay();
                          }
                        },
                        child: Text(
                          employeeViewModel.selectedDate == null
                              ? 'Pick a date'
                              : employeeViewModel.selectedDate!
                                    .toIso8601String()
                                    .split('T')
                                    .first,
                        ),
                      ),
                    ),

                    // Remove your old Expanded + AnimatedSize picker here.
                    // The overlay will render above everything else.
                  ],
                ),
                DataTableEmployees(
                  weekDates: weekDates,
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
    required this.weekDates,
    required this.employeeViewModel,
    required this.employeeTimeTrackViewModel,
  });

  final EmployeeViewModel employeeViewModel;
  final EmployeeTimeTrackViewmodel employeeTimeTrackViewModel;
  final List<DateTime> weekDates;

  @override
  Widget build(BuildContext context) {
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
          EmployeeTimeTrackModel? timeTrack = employee.currentTimeTrack;

          return DataRow(
            cells: [
              DataCell(Text(employee.name)),
              DataCell(
                Center(
                  child: Text(
                    timeTrack == null ? '-' : '${timeTrack.start_time}',
                  ),
                ),
              ),
              DataCell(Center(child: Text('C' * (15 - (index + 5) % 10)))),
              DataCell(Center(child: Text('D' * (15 - (index + 10) % 10)))),
              DataCell(Center(child: Text('A' * (10 - index % 10)))),
              DataCell(Center(child: Text('B' * (10 - (index + 5) % 10)))),
              DataCell(Center(child: Text('C' * (15 - (index + 5) % 10)))),
              DataCell(Center(child: Text('D' * (15 - (index + 10) % 10)))),
              DataCell(Text(((index + 0.1) * 25.4).toString())),
            ],
          );
        }),
      ),
    );
  }
}
