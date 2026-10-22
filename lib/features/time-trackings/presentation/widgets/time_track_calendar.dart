import 'package:flutter/material.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/features/time-trackings/presentation/viewmodels/time_track_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTrackCalendar extends StatefulWidget {
  final DateViewModel dateViewModel;
  final TimeTrackViewModel timeTrackViewModel;

  const TimeTrackCalendar({super.key, required this.dateViewModel, required this.timeTrackViewModel});

  @override
  State<TimeTrackCalendar> createState() => _TimeTrackCalendarState();
}

class _TimeTrackCalendarState extends State<TimeTrackCalendar> {
  final OverlayPortalController _overlayController = OverlayPortalController();

  final LayerLink _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (context) {
        return Stack(
          children: [
            // This GestureDetector detects if the user clicks outside the widget
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _overlayController.hide,
              ),
            ),
            // This CompositedTransformFollower knows where to move thanks to the _layerLink in CompositedTransformTarget below
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 8),
              // This Material gives the surface pop-up window a style, if removed the background will be visible
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TableCalendar(
                        daysOfWeekHeight: 20,
                        shouldFillViewport: false,
                        rowHeight: 50,
                        focusedDay: widget.dateViewModel.selectedDate,
                        firstDay: widget.dateViewModel.calendarMinSelectableData,
                        lastDay: widget.dateViewModel.calendarMaxSelectableData,
                        rangeStartDay: widget.dateViewModel.firstDayOfWeek,
                        rangeEndDay: widget.dateViewModel.lastDayOfWeek,
                        rangeSelectionMode: RangeSelectionMode.enforced,
                        calendarFormat: CalendarFormat.month,
                        locale: 'es_ES',
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        onDaySelected: (selectedDay, focusedDay) async {
                          widget.dateViewModel.setSelectedDate(selectedDay);
                          await widget.timeTrackViewModel.getAllTimeTrackings();
                          _overlayController.hide();
                        },
                      ),
                      ElevatedButton(
                        onPressed:
                            DateUtils.isSameDay(widget.dateViewModel.selectedDate, DateTime.now())
                            ? null
                            : () async {
                                widget.dateViewModel.setSelectedDate(DateTime.now());
                                _overlayController.hide();
                                await widget.timeTrackViewModel.getAllTimeTrackings();
                              },
                        child: Text('Volver a hoy'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      // This indicates to CompositedTransforFollower above that this is where it should appear thanks to _layerLink
      child: CompositedTransformTarget(
        link: _layerLink,
        child: ElevatedButton(
          onPressed: () {
            if (_overlayController.isShowing) {
              _overlayController.hide();
            } else {
              _overlayController.show();
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade100),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Icon(Icons.ios_share, size: 24),
                SizedBox(width: 10),
                const Text('Selecciona una fecha'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
