import 'package:flutter/material.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/time_tracking_repository_impl.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';

class TimeTrackViewModel extends ChangeNotifier {
  final TimeTrackingRepositoryImpl _repository = TimeTrackingRepositoryImpl();

  DateViewModel dateViewModel = locator<DateViewModel>();
  EmployeeViewModel employeeViewModel = locator<EmployeeViewModel>();

  List<TimeTrackModel> _timeTrackings = [];
  List<TimeTrackModel> _timeTrackingsFromEmployee = [];

  List<TimeTrackModel> get timeTrackings => _timeTrackings;

  List<TimeTrackModel> get timeTrackingsFromEmployee => _timeTrackingsFromEmployee;

  Future<void> loadTimeTrackings({List<TimeTrackModel>? timeTrackings}) async {
    if (timeTrackings == null) {
      _timeTrackings = await _repository.getAllTimeTrackingFromDateToDate(
        dateViewModel.firstDayOfWeek,
        dateViewModel.lastDayOfWeek,
      );
    } else {
      _timeTrackings = timeTrackings;
    }

    notifyListeners();
  }

  void getTimeTrackingsFromEmployee(int employeeId, int day) {
    List<TimeTrackModel> timeTrackingsThatMatch = timeTrackings
        .where((timeTrack) => employeeId == timeTrack.idEmployee && timeTrack.difference! > 0)
        .where((timeTrack) => timeTrack.registeredDate?.day == day)
        .toList();

    _timeTrackingsFromEmployee = timeTrackingsThatMatch;
    notifyListeners();
  }

  Future<List<TimeTrackModel>> getTimeTrackingsByDateAndEmployee(DateTime dateTime, EmployeeModel employee) async {
    return await _repository.getTimeTracksByDateAndEmployee(dateTime, employee);
  }

  Future<EmployeeModel?> addTimeStart(EmployeeModel employee) async {
    if (employee.currentTimeTrack == null) {
      TimeTrackModel employeeTimeTrack = TimeTrackModel(
        idEmployee: employee.id!,
        startTime: DateTime.now(),
        registeredDate: DateTime.now(),
      );

      int idTimeTrack = await _repository.insertTimeTrack(employeeTimeTrack);

      return employee.copyWith(currentTimeTrack: employeeTimeTrack.copyWith(id: idTimeTrack));
    } else {
      // TODO: Add exception
      return null;
    }
  }

  Future<void> addTimeFinish(EmployeeModel employee) async {
    DateTime finishTime = DateTime.now();
    int differenceBetweenTimes = finishTime
        .difference(employee.currentTimeTrack!.startTime!)
        .inMinutes;

    TimeTrackModel employeeTimeTrack = employee.currentTimeTrack!.copyWith(
      finishTime: finishTime,
      registeredDate: finishTime.copyWith(hour: 23, minute: 59, second: 59),
      difference: differenceBetweenTimes,
    );

    await _repository.updateTimeTrack(employeeTimeTrack);

    loadTimeTrackings();
    getTimeTrackingsFromEmployee(
      employeeTimeTrack.idEmployee,
      employeeTimeTrack.registeredDate!.day,
    );
  }

  Future<void> editTimeTrack(
    TimeTrackModel timeTrack,
    DateTime startTime,
    DateTime finishTime,
  ) async {
    int differenceBetweenTimes = finishTime.difference(startTime).inMinutes;

    TimeTrackModel employeeTimeTrack = timeTrack.copyWith(
      startTime: startTime,
      finishTime: finishTime,
      registeredDate: finishTime,
      difference: differenceBetweenTimes,
    );

    await _repository.updateTimeTrack(employeeTimeTrack);

    await loadTimeTrackings();
    getTimeTrackingsFromEmployee(timeTrack.idEmployee, timeTrack.registeredDate!.day);
  }

  Future<void> deleteTimeTrack(TimeTrackModel timeTrack) async {
    await _repository.deleteTimeTrack(timeTrack);

    await loadTimeTrackings();
    getTimeTrackingsFromEmployee(timeTrack.idEmployee, timeTrack.registeredDate!.day);
  }

  Duration getDailyDurationForEmployee(int weekDateValue, int employeeId) {
    int day = dateViewModel.weekDates[weekDateValue].day;

    List<TimeTrackModel> employeeTimeTrackings = timeTrackings
        .where((timeTrack) => employeeId == timeTrack.idEmployee)
        .toList();

    List<TimeTrackModel> timeTrackingsThatMatchDay = employeeTimeTrackings
        .where((timeTrack) => timeTrack.registeredDate?.day == day)
        .toList();

    int sumOfRegisteredTime = 0;
    for (TimeTrackModel timeTrack in timeTrackingsThatMatchDay) {
      if (!timeTrack.isTurnOnGoing!) {
        sumOfRegisteredTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: sumOfRegisteredTime);
  }

  Future<Duration> getDailyDurationForEmployeeByDay(int employeeId, int weekDateValue) async {
    DateTime firstDayOfMonth = dateViewModel.selectedDate.copyWith(day: 1);
    DateTime lastDayOfMonth = dateViewModel.selectedDate.copyWith(
      day: dateViewModel.getTotalDaysOfMonth(),
    );

    List<TimeTrackModel> employeeTimeTrackings = await _repository
        .getTimeTrackingDateToDateFromEmployee(firstDayOfMonth, lastDayOfMonth, employeeId);

    List<TimeTrackModel> timeTrackingsThatMatchDay = employeeTimeTrackings
        .where((timeTrack) => timeTrack.registeredDate?.day == weekDateValue)
        .toList();

    int sumOfRegisteredTime = 0;
    for (TimeTrackModel timeTrack in timeTrackingsThatMatchDay) {
      if (!timeTrack.isTurnOnGoing!) {
        sumOfRegisteredTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: sumOfRegisteredTime);
  }

  Duration getTimeWorkedInWeekByEmployee(int employeeId) {
    List<TimeTrackModel> timeTrackingsList = timeTrackings
        .where((timeTrack) => timeTrack.idEmployee == employeeId)
        .toList();

    int totalTime = 0;
    for (TimeTrackModel timeTrack in timeTrackingsList) {
      if (!timeTrack.isTurnOnGoing!) {
        totalTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: totalTime);
  }

  Future<Duration> getTimeWorkedInMonthByEmployee(int employeeId) async {
    DateTime firstDayOfMonth = dateViewModel.selectedDate.copyWith(day: 1);
    DateTime lastDayOfMonth = dateViewModel.selectedDate.copyWith(
      day: dateViewModel.getTotalDaysOfMonth(),
    );

    List<TimeTrackModel> timeTrackingsList = await _repository
        .getTimeTrackingDateToDateFromEmployee(firstDayOfMonth, lastDayOfMonth, employeeId);

    int totalTime = 0;
    for (TimeTrackModel timeTrack in timeTrackingsList) {
      if (!timeTrack.isTurnOnGoing!) {
        totalTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: totalTime);
  }
}
