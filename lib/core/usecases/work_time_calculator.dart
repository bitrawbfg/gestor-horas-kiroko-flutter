import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';

class WorkTimeCalculator {
  static Duration getTimeWorkedInDayByEmployee(
    List<TimeTrackModel> timeTrackings,
    DateTime dayToFilter,
    int employeeId,
  ) {
    List<TimeTrackModel> timeTrackingsInDay = timeTrackings
        .where((timeTrack) {
          DateTime dateTime = timeTrack.registeredDate!;

          return dateTime.year == dayToFilter.year &&
              dateTime.month == dayToFilter.month &&
              dateTime.day == dayToFilter.day;
        })
        .where((timeTrack) => timeTrack.idEmployee == employeeId)
        .toList();

    return _calculateTotalWorkedTime(timeTrackingsInDay);
  }

  static Duration getTimeWorkedInRangeByEmployee(
    List<TimeTrackModel> timeTrackings,
    DateTime firstDay,
    DateTime lastDay,
    int employeeId,
  ) {
    List<TimeTrackModel> timeTrackingsInRange = timeTrackings
        .where(
          (timeTrack) =>
              timeTrack.registeredDate!.isAfter(
                firstDay.copyWith(hour: 00, minute: 00, second: 00),
              ) &&
              timeTrack.registeredDate!.isBefore(
                lastDay.copyWith(hour: 00, minute: 00, second: 00),
              ),
        )
        .where((timeTrack) => timeTrack.idEmployee == employeeId)
        .toList();

    return _calculateTotalWorkedTime(timeTrackingsInRange);
  }

  static int getNumberOfWeekByDay(DateTime day) {
    int rawNumberOfWeek = day.weekday % 4;

    return rawNumberOfWeek == 0 ? 4 : rawNumberOfWeek;
  }

  static Duration _calculateTotalWorkedTime(List<TimeTrackModel> timeTrackingsInDay) {
    int sumOfTime = 0;
    for (TimeTrackModel timeTrack in timeTrackingsInDay) {
      if (!timeTrack.isTurnOnGoing!) {
        sumOfTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: sumOfTime);
  }
}
