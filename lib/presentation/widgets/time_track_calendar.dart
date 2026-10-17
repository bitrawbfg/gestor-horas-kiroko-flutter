import 'package:flutter/material.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTrackCalendar extends StatelessWidget {
  final DateViewModel dateViewModel;
  final TimeTrackViewModel timeTrackViewModel;

  const TimeTrackCalendar({
    super.key,
    required this.dateViewModel,
    required this.timeTrackViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        Container(
          width: 350,
          height: 500,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: TableCalendar(
                  focusedDay: dateViewModel.selectedDate,
                  firstDay: dateViewModel.calendarMinSelectableData,
                  lastDay: dateViewModel.calendarMaxSelectableData,
                  rangeStartDay: dateViewModel.firstDayOfWeek,
                  rangeEndDay: dateViewModel.lastDayOfWeek,
                  rangeSelectionMode: RangeSelectionMode.enforced,
                  calendarFormat: CalendarFormat.month,
                  locale: 'es_ES',
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                  onDaySelected: (selectedDay, focusedDay) async {
                    dateViewModel.setSelectedDate(selectedDay);
                    await timeTrackViewModel.getAllTimeTrackings();
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
                        timeTrackViewModel.getAllTimeTrackings();
                      },
                child: Text('Volver a hoy'),
              ),
            ],
          ),
        ),
      ],
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return ElevatedButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Icon(Icons.calendar_month),
        );
      },
    );
  }
}
