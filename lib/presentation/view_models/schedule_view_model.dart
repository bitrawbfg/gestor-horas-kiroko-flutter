import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/data/repositories/schedule_repository_impl.dart';

class ScheduleViewModel extends ChangeNotifier {
  final ScheduleRepositoryImpl _scheduleRepository = ScheduleRepositoryImpl();

  List<ScheduleModel> _schedules = [];

  List<ScheduleModel> get schedules => _schedules;

  Future<void> loadSchedules({List<ScheduleModel>? schedules}) async {
    if (schedules == null) {
      _schedules = await _scheduleRepository.getAllSchedules();
    } else {
      _schedules = schedules;
    }

    notifyListeners();
  }

  Future<void> addSchedule(ScheduleModel schedule) async {
    await _scheduleRepository.insertSchedule(schedule);
    await loadSchedules();
  }

  Future<void> assignScheduleToEmployee(int employeeId, int scheduleId, String assignedWeek) async {
    await _scheduleRepository.assignScheduleToEmployee(employeeId, scheduleId, assignedWeek);
    await loadSchedules();
  }

  Future<void> addScheduleForEmployee(ScheduleModel schedule) async {
    await _scheduleRepository.insertScheduleForEmployee(schedule);
    await loadSchedules();
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    await _scheduleRepository.updateSchedule(schedule);
    await loadSchedules();
  }

  Future<void> removeSchedule(ScheduleModel schedule) async {
    await _scheduleRepository.deleteSchedule(schedule);
    await loadSchedules();
  }

  Future<void> addScheduleWithAssignments({
    required ScheduleModel schedule,
    required List<Map<String, dynamic>> assignations,
  }) async {
    await _scheduleRepository.insertScheduleWithAssignment(
      schedule: schedule,
      assignations: assignations,
    );
    await loadSchedules();
  }
}
