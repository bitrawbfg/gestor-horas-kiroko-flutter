import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employee_selection_data.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/data/models/weekdays_enum.dart';
import 'package:gestor_horas/domain/repositories/schedule_repository.dart';
import 'package:sqflite/sqflite.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  static const String schedulesTable = 'schedules';
  static const String employeeScheduleTable = 'employee_schedules';

  @override
  Future<int> insertSchedule(ScheduleModel schedule, {DatabaseExecutor? executor}) async {
    final database = executor ?? await _databaseHelper.database;

    return await database.insert(schedulesTable, schedule.toMap());
  }

  Future<void> assignScheduleToEmployee(
    int employeeId,
    int scheduleId,
    String assignedWeek, {
    DatabaseExecutor? executor,
  }) async {
    final database = executor ?? await _databaseHelper.database;

    await database.insert(employeeScheduleTable, {
      'id_employee': employeeId,
      'id_schedule': scheduleId,
      'assigned_week': assignedWeek,
    });
  }

  Future<int> insertScheduleForEmployee(
    ScheduleModel schedule,
    List<EmployeeSelectionData> employeeAssignations,
  ) async {
    final database = await _databaseHelper.database;

    return await database.transaction((transaction) async {
      int scheduleId = await insertSchedule(schedule, executor: transaction);

      for (EmployeeSelectionData assignation in employeeAssignations) {
        // TODO: Gestionar con exceptiones si el empleado o la semana son nulos

        await assignScheduleToEmployee(
          assignation.selectedEmployee!.id!,
          scheduleId,
          assignation.weekdayEnum!.value,
          executor: transaction,
        );
      }

      return scheduleId;
    });
  }

  @override
  Future<void> updateSchedule(ScheduleModel schedule, int employeeId) async {
    final database = await _databaseHelper.database;

    await database.update(
      schedulesTable,
      schedule.toMap(),
      where: 'id = ?',
      whereArgs: [schedule.id],
    );
  }

  @override
  Future<void> deleteSchedule(ScheduleModel schedule, int employeeId) async {
    final database = await _databaseHelper.database;

    await database.delete(schedulesTable, where: 'id = ?', whereArgs: [schedule.id]);
  }

  @override
  Future<ScheduleModel> getScheduleById(int id) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> schedules = await database.query(
      schedulesTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    return List.generate(schedules.length, (schedule) {
      return ScheduleModel.fromMap(schedules[schedule]);
    }).firstWhere((schedule) => schedule.id == id);
  }

  @override
  Future<List<ScheduleModel>> getAllSchedules() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> schedules = await database.query(schedulesTable);

    return List.generate(schedules.length, (schedule) {
      return ScheduleModel.fromMap(schedules[schedule]);
    });
  }

  @override
  Future<List<ScheduleModel>> getAllSchedulesByEmployee(ScheduleModel schedule) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> schedules = await database.query(
      schedulesTable,
      where: 'id = ?',
      whereArgs: [schedule.id],
    );

    return List.generate(schedules.length, (schedule) {
      return ScheduleModel.fromMap(schedules[schedule]);
    });
  }

  Future<void> insertScheduleWithAssignment({
    required ScheduleModel schedule,
    required List<Map<String, dynamic>> assignations,
  }) async {
    final database = await _databaseHelper.database;

    await database.transaction((transaction) async {
      final int scheduleId = await transaction.insert(schedulesTable, schedule.toMap());

      final batch = transaction.batch();

      for (var assignment in assignations) {
        final Map<String, dynamic> rowToInsert = Map.from(assignment);
        rowToInsert['id_schedule'] = scheduleId;

        batch.insert(employeeScheduleTable, rowToInsert);
      }

      await batch.commit(noResult: true);
    });
  }
}
