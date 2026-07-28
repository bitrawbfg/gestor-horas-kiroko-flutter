import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_time_tracking_repository_impl.dart';
import 'package:gestor_horas/presentation/viewmodels/date_view_model.dart';

class EmployeeTimeTrackViewmodel extends ChangeNotifier {
  final DateViewModel _dateViewModel;
  final EmployeeTimeTrackingRepositoryImpl _repository = EmployeeTimeTrackingRepositoryImpl();

  EmployeeTimeTrackViewmodel(this._dateViewModel);

  List<EmployeeTimeTrackModel> _timeTrackings = [];

  List<EmployeeTimeTrackModel> get timeTrackings => _timeTrackings;

  Future<void> loadTimeTrackings({List<EmployeeTimeTrackModel>? timeTrackings}) async {
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
      EmployeeTimeTrackModel employeeTimeTrack = EmployeeTimeTrackModel(
        employee_id: employee.id!,
        start_time: DateTime.now(),
        registered_date: DateTime.now(),
      );

      int idTimeTrack = await _repository.insertEmployeeTimeTrack(employeeTimeTrack);

      return employee.copyWith(currentTimeTrack: employeeTimeTrack.copyWith(id: idTimeTrack));
    } else {
      // TODO: Add exception
      return null;
    }
  }

  Future<void> addTimeFinish(EmployeeModel employee) async {
    EmployeeTimeTrackModel employeeTimeTrack = employee.currentTimeTrack!.copyWith(
      finish_time: DateTime.now(),
      registered_date: DateTime.now(),
      difference: DateTime.now().difference(employee.currentTimeTrack!.start_time!).inMinutes,
    );

    await _repository.updateEmployeeTimeTrack(employeeTimeTrack);
    loadTimeTrackings();
  }

  Future<void> getTimeTrackingsBetweenDates() async {
    List<EmployeeTimeTrackModel> obtainedTimeTrackings = await _repository
        .getAllTimeTrackingFromDateToDate(
          _dateViewModel.firstDayOfWeek,
          _dateViewModel.lastDayOfWeek,
        );

    _timeTrackings = obtainedTimeTrackings;
    notifyListeners();
  }

  DataCell checkColumnWeekDayWithTimeTrackings(
    int weekDateValue,
    int employeeId,
    BuildContext context,
  ) {
    int day = _dateViewModel.weekDates[weekDateValue].day;
    List<EmployeeTimeTrackModel> employeeTimeTrackings = timeTrackings
        .where((timeTrack) => employeeId == timeTrack.employee_id)
        .toList();

    List<EmployeeTimeTrackModel> timeTrackingsThatMatchDay = employeeTimeTrackings
        .where((timeTrack) => timeTrack.registered_date?.day == day)
        .toList();

    int sumOfRegisteredTime = 0;
    for (EmployeeTimeTrackModel timeTrack in timeTrackingsThatMatchDay) {
      if (!timeTrack.isTurnOnGoing!) {
        sumOfRegisteredTime += timeTrack.difference!;
      }
    }

    Duration duration = Duration(minutes: sumOfRegisteredTime);

    return DataCell(
      GestureDetector(
        onDoubleTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => const Dialog(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Column(children: [Text('Modificar hora')]),
            ),
          ),
        ),
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

  Duration getTimeWorkedInWeekByEmployee(int employeeId) {
    List<EmployeeTimeTrackModel> timeTrackingsList = timeTrackings
        .where(
          (timeTrack) =>
              timeTrack.employee_id == employeeId &&
              timeTrack.registered_date!.isAfter(_dateViewModel.firstDayOfWeek) &&
              timeTrack.registered_date!.isBefore(_dateViewModel.lastDayOfWeek),
        )
        .toList();

    int totalTime = 0;
    for (EmployeeTimeTrackModel timeTrack in timeTrackingsList) {
      if (!timeTrack.isTurnOnGoing!) {
        totalTime += timeTrack.difference!;
      }
    }

    return Duration(minutes: totalTime);
  }
}
