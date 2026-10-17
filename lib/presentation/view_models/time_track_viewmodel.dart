import 'dart:io';

import 'package:excel_plus/excel_plus.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/core/work_time_calculator.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/domain/repositories/employee_repository.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';

import '../../configuration/excel_exporter.dart';
import '../../domain/repositories/time_tracking_repository.dart';

class TimeTrackViewModel extends ChangeNotifier {
  final TimeTrackingRepository _timeTrackingRepository;
  final EmployeeRepository _employeeRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  TimeTrackViewModel(this._timeTrackingRepository, this._employeeRepository);

  DateViewModel dateViewModel = locator<DateViewModel>();

  List<TimeTrackModel> _timeTrackings = [];
  List<TimeTrackModel> _timeTrackingsFromEmployee = [];

  List<TimeTrackModel> get timeTrackings => _timeTrackings;

  List<TimeTrackModel> get timeTrackingsFromEmployee => _timeTrackingsFromEmployee;

  Future<void> getAllTimeTrackings({List<TimeTrackModel>? timeTrackings}) async {
    _isLoading = true;

    if (timeTrackings == null) {
      _timeTrackings = await _timeTrackingRepository.getAllTimeTrackingsFromDateToDate(
        dateViewModel.firstDayOfWeek,
        dateViewModel.lastDayOfWeek,
      );
    } else {
      _timeTrackings = timeTrackings;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getTimeTrackingsBySpecificDayAndEmployee(int employeeId, DateTime date) async {
    List<TimeTrackModel> foundTimeTrackings = await _timeTrackingRepository
        .getTimeTrackingsBySpecificDayAndEmployee(date, employeeId);

    _timeTrackingsFromEmployee = foundTimeTrackings;
    notifyListeners();
  }

  Future<EmployeeModel?> addStartTimeTrackToEmployee(EmployeeModel employee) async {
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

    await _timeTrackingRepository.updateTimeTrack(employeeTimeTrack);

    await getAllTimeTrackings();
    await getTimeTrackingsBySpecificDayAndEmployee(
      employeeTimeTrack.idEmployee,
      employeeTimeTrack.registeredDate!,
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

    await _timeTrackingRepository.updateTimeTrack(employeeTimeTrack);

    await getAllTimeTrackings();
    await getTimeTrackingsBySpecificDayAndEmployee(employeeTimeTrack.idEmployee, employeeTimeTrack.registeredDate!);
  }

  Future<void> deleteTimeTrack(TimeTrackModel timeTrack) async {
    await _timeTrackingRepository.deleteTimeTrack(timeTrack);

    await getAllTimeTrackings();
    await getTimeTrackingsBySpecificDayAndEmployee(timeTrack.idEmployee, timeTrack.registeredDate!);
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
      await _employeeRepository.getEmployees(),
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
