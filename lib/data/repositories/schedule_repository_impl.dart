import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  static const String schedulesTable = 'schedules';
  static const String employeeScheduleTable = 'employee_schedules';

  @override
  Future<int> insertSchedule(ScheduleModel schedule, int employeeId) async {
    final database = await _databaseHelper.database;

    int scheduleId = await database.insert(schedulesTable, schedule.toMap());
    await database.rawQuery(
      'INSERT INTO $employeeScheduleTable (id_employee, id_schedule) VALUES (?, ?);',
      [employeeId, scheduleId],
    );

    return scheduleId;
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

    /*
    * TODO: Para obtener todos los datos se puede hacer esto a la inversa más o menos
    *
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
    */

    /*
    * Esto no lo tengo tan claro
    *
    final List<Map<String, dynamic>> employeeScheduleAssignments = [];
    for (EmployeeSelectionData employeeData in employeesData) {
      if (employeeData.weekdayEnum != null && employeeData.selectedEmployee != null) {
        for (String selectedDay in selectedDays) {
          employeeScheduleAssignments.add({
            'id_employee': employeeData.selectedEmployee?.id,
            'weekday': selectedDay,
            'assigned_week': employeeData.weekdayEnum?.value,
          });
        }
      }
    }*/

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
