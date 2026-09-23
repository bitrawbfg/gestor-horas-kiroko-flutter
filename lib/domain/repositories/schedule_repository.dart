import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ScheduleRepository {
  Future<ScheduleModel> getScheduleById(int id);
  Future<List<ScheduleModel>> getAllSchedules();
  Future<List<ScheduleModel>> getAllSchedulesByEmployee(ScheduleModel schedule);

  Future<int> insertSchedule(ScheduleModel schedule, {DatabaseExecutor? executor});
  Future<void> updateSchedule(ScheduleModel schedule, int employeeId);
  Future<void> deleteSchedule(ScheduleModel schedule, int employeeId);
}