import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateViewModel extends ChangeNotifier {
  /// This values are set in the calendar like the min. and max. year you can select
  final calendarMinSelectableData = DateTime(2000);
  final calendarMaxSelectableData = DateTime(2100);

  DateTime selectedDate = DateTime.now();
  bool isCalendarOpen = false;

  DateTime get _mostRecentMonday => DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day - (selectedDate.weekday - 1),
  );

  List<DateTime> get weekDates => List.generate(
    7, // Days of the week
    (index) => _mostRecentMonday.add(Duration(days: index)),
  );

  DateTime get firstDayOfWeek => weekDates[0].copyWith(hour: 00, minute: 00, second: 00);
  DateTime get lastDayOfWeek => weekDates[6].copyWith(hour: 23, minute: 59, second: 59);
  DateTime get firstDayOfMonth => firstDayOfWeek.copyWith(day: 1);
  DateTime get lastDayOfMonth => firstDayOfWeek.copyWith(day: getTotalDaysOfMonth());

  void setSelectedDate(DateTime selectedDateByUser) {
    selectedDate = selectedDateByUser;
    isCalendarOpen = false;

    /// Closes the calendar view when a date is selected
    notifyListeners();
  }

  int getTotalDaysOfMonth() {
    return DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month);
  }

  String getFileNameSelectedDate() {
    return '${DateFormat("MMMM", 'es_ES').format(selectedDate)}-${selectedDate.year}';
  }
}
