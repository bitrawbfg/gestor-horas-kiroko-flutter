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

  Future<void> addSchedule(ScheduleModel schedule, int employeeId) async {
    await _scheduleRepository.insertSchedule(schedule, employeeId);
    await loadSchedules();
  }

  Future<void> updateSchedule(ScheduleModel schedule, int employeeId) async {
    await _scheduleRepository.updateSchedule(schedule, employeeId);
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
