import 'dart:io';

import 'package:excel_plus/excel_plus.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:gestor_horas/core/injection.dart';
import 'package:gestor_horas/core/usecases/excel_exporter.dart';
import 'package:gestor_horas/core/usecases/work_time_calculator.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';
import 'package:gestor_horas/presentation/view_models/base_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';

import '../../domain/repositories/time_tracking_repository.dart';

class TimeTrackViewModel extends BaseViewModel {
  final TimeTrackingRepository _timeTrackingRepository;

  TimeTrackViewModel(this._timeTrackingRepository);

  DateViewModel dateViewModel = locator<DateViewModel>();

  List<TimeTrackModel> _timeTrackings = [];
  List<TimeTrackModel> _timeTrackingsFromEmployee = [];

  List<TimeTrackModel> get timeTrackings => _timeTrackings;

  List<TimeTrackModel> get timeTrackingsFromEmployee => _timeTrackingsFromEmployee;

  Future<void> getAllTimeTrackings({List<TimeTrackModel>? timeTrackings}) async {
    setLoading(true);

    if (timeTrackings == null) {
      _timeTrackings = await _timeTrackingRepository.getAllTimeTrackingsFromDateToDate(
        dateViewModel.firstDayOfWeek,
        dateViewModel.lastDayOfWeek,
      );
    } else {
      _timeTrackings = timeTrackings;
    }

    setLoading(false);
    notifyListeners();
  }

  Future<void> getTimeTrackingsBySpecificDayAndEmployee(int employeeId, DateTime date) async {
    List<TimeTrackModel> foundTimeTrackings = await _timeTrackingRepository
        .getTimeTrackingsBySpecificDayAndEmployee(date, employeeId);

    _timeTrackingsFromEmployee = foundTimeTrackings;
    notifyListeners();
  }

  Future<EmployeeEntity?> addStartTimeTrackToEmployee(EmployeeEntity employee) async {
    if (employee.currentTimeTrack == null) {
      TimeTrackModel employeeTimeTrack = TimeTrackModel(
        idEmployee: employee.id!,
        startTime: DateTime.now(),
        registeredDate: DateTime.now(),
      );

      int idTimeTrack = await _timeTrackingRepository.insertTimeTrack(employeeTimeTrack);

      return employee.copyWith(currentTimeTrack: employeeTimeTrack.copyWith(id: idTimeTrack));
    } else {
      // TODO: Add exception
      return null;
    }
  }

  Future<void> addTimeFinish(EmployeeEntity employee) async {
    DateTime startTime = employee.currentTimeTrack!.startTime!;
    DateTime finishTime = DateTime.now();

    if ((DateUtils.isSameDay(employee.currentTimeTrack!.startTime!, finishTime))) {
      int differenceBetweenTimes = finishTime.difference(startTime).inMinutes;

      TimeTrackModel employeeTimeTrack = employee.currentTimeTrack!.copyWith(
        finishTime: finishTime,
        registeredDate: finishTime.copyWith(hour: 23, minute: 59, second: 59),
        difference: differenceBetweenTimes,
      );

      await _timeTrackingRepository.updateTimeTrack(employeeTimeTrack);
    } else {
      // Finish the current day at 23:59:59
      DateTime finishFirstDay = finishTime.copyWith(
        day: startTime.day,
        month: startTime.month,
        year: startTime.year,
        hour: 23,
        minute: 59,
        second: 59,
      );
      int firstDifferenceBetweenTimes = finishFirstDay.difference(startTime).inMinutes;
      TimeTrackModel employeeTimeTrack = employee.currentTimeTrack!.copyWith(
        finishTime: startTime.copyWith(hour: 23, minute: 59, second: 59),
        registeredDate: finishFirstDay,
        difference: firstDifferenceBetweenTimes,
      );
      await _timeTrackingRepository.updateTimeTrack(employeeTimeTrack);

      // Add a new entry for the next day starting at 00:00:00
      DateTime startSecondDay = DateUtils.addDaysToDate(
        startTime.copyWith(hour: 00, minute: 00, second: 00),
        1,
      );
      DateTime finishSecondDay = startSecondDay.copyWith(
        hour: finishTime.hour,
        minute: finishTime.minute,
        second: finishTime.second,
      );
      int secondDifferenceBetweenTimes = finishSecondDay.difference(startSecondDay).inMinutes;

      if (secondDifferenceBetweenTimes > 0) {
        TimeTrackModel secondTimeTrackStart = employee.currentTimeTrack!.copyWith(
          id: null,
          startTime: startSecondDay,
          finishTime: finishSecondDay,
          registeredDate: startSecondDay.copyWith(hour: 23, minute: 59, second: 59),
          difference: secondDifferenceBetweenTimes,
        );
        await _timeTrackingRepository.insertTimeTrack(secondTimeTrackStart);
      }
    }

    await getAllTimeTrackings();
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

    await _timeTrackingRepository.updateTimeTrack(employeeTimeTrack);

    await getAllTimeTrackings();
    await getTimeTrackingsBySpecificDayAndEmployee(
      employeeTimeTrack.idEmployee,
      employeeTimeTrack.registeredDate!,
    );
  }

  Future<void> deleteTimeTrack(TimeTrackModel timeTrack) async {
    await _timeTrackingRepository.deleteTimeTrack(timeTrack);

    await getAllTimeTrackings();
  }

  Duration getDailyTimeWorkedByEmployee(int employeeId, DateTime dayToFilter) {
    return WorkTimeCalculator.getTimeWorkedInDayByEmployee(timeTrackings, dayToFilter, employeeId);
  }

  Duration getTimeWorkedInWeekByEmployee(int employeeId, DateTime firstDay, DateTime lastDay) {
    return WorkTimeCalculator.getTimeWorkedInRangeByEmployee(
      timeTrackings,
      firstDay,
      lastDay,
      employeeId,
    );
  }

  Future<void> exportDataToExcel() async {
    ExcelExporter exporter = ExcelExporter(
      locator<EmployeeViewModel>().employees,
      await _timeTrackingRepository.getAllTimeTrackingsFromDateToDate(
        dateViewModel.firstDayOfMonth,
        dateViewModel.lastDayOfMonth,
      ),
      dateViewModel.firstDayOfMonth,
      dateViewModel.lastDayOfMonth,
    );
    Excel excel = await exporter.createExcelFile();

    final picker = SaveFilePicker()
      ..filterSpecification = {'Documento Excel (*.xlsx)': '*.xlsx'}
      ..defaultExtension = 'xlsx'
      ..fileName =
          'Hoja de Horas Mensual - Restaurante KIROKO - ${dateViewModel.getFileNameSelectedDate()}';

    final file = picker.getFile();
    if (file != null) {
      File(file.path).writeAsBytesSync(excel.save()!);
      print('Selected file: ${file.path}');
    } else {
      print('No file selected.');
    }
  }
}
