import 'package:flutter/material.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/time_tracking_repository_impl.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/side_panel_view_model.dart';
import 'package:side_panel/side_panel.dart';

class TimeTrackViewmodel extends ChangeNotifier {
  final DateViewModel _dateViewModel;
  final TimeTrackingRepositoryImpl _repository = TimeTrackingRepositoryImpl();

  TimeTrackViewmodel(this._dateViewModel);

  List<TimeTrackModel> _timeTrackings = [];

  List<TimeTrackModel> get timeTrackings => _timeTrackings;

  Future<void> loadTimeTrackings({List<TimeTrackModel>? timeTrackings}) async {
    if (timeTrackings == null) {
      _timeTrackings = await _repository.getAllTimeTrackingFromDateToDate(
        _dateViewModel.firstDayOfWeek,
        _dateViewModel.lastDayOfWeek,
      );
    } else {
      _timeTrackings = timeTrackings;
    }

    notifyListeners();
  }

  Future<EmployeeModel?> addTimeStart(EmployeeModel employee) async {
    if (employee.currentTimeTrack == null) {
      TimeTrackModel employeeTimeTrack = TimeTrackModel(
        employeeId: employee.id!,
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
    TimeTrackModel employeeTimeTrack = employee.currentTimeTrack!.copyWith(
      finishTime: DateTime.now(),
      registeredDate: DateTime.now(),
      difference: DateTime
          .now()
          .difference(employee.currentTimeTrack!.startTime!)
          .inMinutes,
    );

    await _repository.updateTimeTrack(employeeTimeTrack);

    locator<SidePanelViewModel>().getTimeTrackingsFromEmployee(employee.id!, employee.currentTimeTrack!.registeredDate!.day);
    loadTimeTrackings();
  }

  Future<void> getTimeTrackingsBetweenDates() async {
    List<TimeTrackModel> obtainedTimeTrackings = await _repository
        .getAllTimeTrackingFromDateToDate(
      _dateViewModel.firstDayOfWeek,
      _dateViewModel.lastDayOfWeek,
    );

    _timeTrackings = obtainedTimeTrackings;
    notifyListeners();
  }

  DataCell checkColumnWeekDayWithTimeTrackings(int weekDateValue,
      int employeeId,
      BuildContext context,) {
    int day = _dateViewModel.weekDates[weekDateValue].day;
    List<TimeTrackModel> employeeTimeTrackings = timeTrackings
        .where((timeTrack) => employeeId == timeTrack.employeeId)
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

    Duration duration = Duration(minutes: sumOfRegisteredTime);

    return DataCell(
      GestureDetector(
        onDoubleTap: () {
          locator<SidePanelController>().showRightPanel();

          locator<SidePanelViewModel>().getTimeTrackingsFromEmployee(employeeId, day);
        },
        child: Center(
          child: Text(
            duration.inMinutes == 0
                ? '-'
                : '${duration.inHours.remainder(24)}h ${duration.inMinutes.remainder(60)}m',
          ),
        ),
      ),
    );
  }

  List<TimeTrackModel> getTimeTrackingsFromEmployee(int employeeId, int day) {
    List<TimeTrackModel> employeeTimeTrackings = timeTrackings
        .where((timeTrack) => employeeId == timeTrack.employeeId && timeTrack.difference != 0)
        .toList();

    List<TimeTrackModel> timeTrackingsThatMatchDay = employeeTimeTrackings
        .where((timeTrack) => timeTrack.registeredDate?.day == day)
        .toList();

    return timeTrackingsThatMatchDay;
  }

  Duration getTimeWorkedInWeekByEmployee(int employeeId) {
    List<TimeTrackModel> timeTrackingsList = timeTrackings
        .where(
          (timeTrack) =>
      timeTrack.employeeId == employeeId &&
          timeTrack.registeredDate!.isAfter(_dateViewModel.firstDayOfWeek) &&
          timeTrack.registeredDate!.isBefore(_dateViewModel.lastDayOfWeek),
    )
        .toList();

    int totalTime = 0;
    for (TimeTrackModel timeTrack in timeTrackingsList) {
      if (!timeTrack.isTurnOnGoing!) {
        totalTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: totalTime);
  }
}
