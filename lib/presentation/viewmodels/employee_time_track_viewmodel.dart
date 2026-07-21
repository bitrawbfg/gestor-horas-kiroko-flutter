import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_time_tracking_repository_impl.dart';

class EmployeeTimeTrackViewmodel extends ChangeNotifier {
  final EmployeeTimeTrackingRepositoryImpl _repository =
      EmployeeTimeTrackingRepositoryImpl();
  List<EmployeeTimeTrackModel> _timeTrackings = [];

  List<EmployeeTimeTrackModel> get timeTrackings => _timeTrackings;

  Future<void> loadTimeTrackings({
    List<EmployeeTimeTrackModel>? timeTrackings,
    DateTime? startDay,
    DateTime? finishDay,
    DateTime? selectedDay,
  }) async {
    DateTime startOfWeek;

    if (selectedDay == null) {
      startOfWeek = DateTime.now().subtract(
        Duration(days: DateTime.now().weekday - 1),
      );
    } else {
      startOfWeek = selectedDay.subtract(
        Duration(days: DateTime.now().weekday - 1),
      );
    }

    List<DateTime> weekDates = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });

    if (timeTrackings == null) {
      if (startDay != null || finishDay != null) {
        _timeTrackings = await _repository.getAllTimeTrackingFromDateToDate(
          startDay!,
          finishDay!,
        );
      } else {
        _timeTrackings = await _repository.getAllTimeTrackingFromDateToDate(
          weekDates[0],
          weekDates[6],
        );
      }
    } else {
      _timeTrackings = timeTrackings;
    }

    notifyListeners();
  }

  Future<EmployeeModel?> addTimeStart(EmployeeModel employee) async {
    if (employee.currentTimeTrack == null) {
      EmployeeTimeTrackModel employeeTimeTrack = EmployeeTimeTrackModel(
        employee_id: employee.id!,
        start_time: DateTime.now(),
      );

      int idTimeTrack = await _repository.insertEmployeeTimeTrack(
        employeeTimeTrack,
      );

      return employee.copyWith(
        currentTimeTrack: employeeTimeTrack.copyWith(id: idTimeTrack),
      );
    } else {
      // TODO: Add exception
      return null;
    }
  }

  Future<void> addTimeFinish(EmployeeModel employee) async {
    EmployeeTimeTrackModel employeeTimeTrack = employee.currentTimeTrack!
        .copyWith(
          finish_time: DateTime.now(),
          registered_date: DateTime.now(),
          difference: DateTime.now()
              .difference(employee.currentTimeTrack!.start_time!)
              .inMinutes,
        );

    await _repository.updateEmployeeTimeTrack(employeeTimeTrack);
    loadTimeTrackings();
  }

  Future<void> getTimeTrackingsBetweenDates(
    DateTime startDay,
    DateTime finishDay,
  ) async {
    List<EmployeeTimeTrackModel> obtainedTimeTrackings = await _repository
        .getAllTimeTrackingFromDateToDate(startDay, finishDay);

    _timeTrackings = obtainedTimeTrackings;
    notifyListeners();
  }

  Widget checkColumnWeekDayWithTimeTrackings(
    int weekDateValue,
    int employeeId,
    List<DateTime> weekDates,
  ) {
    int day = weekDates[weekDateValue].day;
    List<EmployeeTimeTrackModel> employeeTimeTrackings = timeTrackings
        .where((timeTrack) => employeeId == timeTrack.employee_id)
        .toList();

    List<EmployeeTimeTrackModel> timeTrackingsThatMatchDay =
        employeeTimeTrackings
            .where((timeTrack) => timeTrack.registered_date?.day == day)
            .toList();

    int sumOfRegisteredTime = 0;
    for (EmployeeTimeTrackModel timeTrack in timeTrackingsThatMatchDay) {
      sumOfRegisteredTime += timeTrack.difference!;
    }

    int duration = Duration(minutes: sumOfRegisteredTime).inMinutes;

    return Text(duration == 0 ? '-' : '$duration');
  }

  int getTimeWorkedInWeekByEmployee(
    int employeeId,
    DateTime startDay,
    DateTime finishDay,
  ) {
    startDay = startDay.copyWith(hour: 00, minute: 00, second: 00);
    finishDay = finishDay.copyWith(hour: 23, minute: 59, second: 59);

    List<EmployeeTimeTrackModel> timeTrackingsList = timeTrackings
        .where(
          (timeTrack) =>
              timeTrack.employee_id == employeeId &&
              timeTrack.registered_date!.isAfter(startDay) &&
              timeTrack.registered_date!.isBefore(finishDay),
        )
        .toList();

    int totalTime = 0;
    for (EmployeeTimeTrackModel timeTrack in timeTrackingsList) {
      totalTime += timeTrack.difference!;
    }

    return totalTime;
  }
}
