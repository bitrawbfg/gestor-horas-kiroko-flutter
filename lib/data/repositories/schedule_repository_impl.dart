import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employee_selection_data.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
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

  Future<int> insertScheduleForEmployee(ScheduleModel schedule) async {
    final database = await _databaseHelper.database;

    List<EmployeeSelectionData> employeeAssignations = schedule.employeeWeekAssignments;

    return await database.transaction((transaction) async {
      int scheduleId = await insertSchedule(schedule, executor: transaction);

      for (EmployeeSelectionData assignation in employeeAssignations) {
        if (assignation.selectedEmployee != null && assignation.weekdayEnum != null) {
          await assignScheduleToEmployee(
            assignation.selectedEmployee!.id!,
            scheduleId,
            assignation.weekdayEnum!.value,
            executor: transaction,
          );
        }
      }

      return scheduleId;
    });
  }

  @override
  Future<void> updateSchedule(ScheduleModel schedule) async {
    final database = await _databaseHelper.database;

    List<EmployeeSelectionData> employeeWeekAssignments = schedule.employeeWeekAssignments;

    await database.transaction((transaction) async {
      await transaction.update(
        schedulesTable,
        schedule.toMap(),
        where: 'id = ?',
        whereArgs: [schedule.id],
      );

      await transaction.delete(
        'employee_schedules',
        where: 'id_schedule = ?',
        whereArgs: [schedule.id],
      );

      for (EmployeeSelectionData employeeWeekAssignment in employeeWeekAssignments) {
        if (employeeWeekAssignment.selectedEmployee != null &&
            employeeWeekAssignment.weekdayEnum != null) {
          assignScheduleToEmployee(
            employeeWeekAssignment.selectedEmployee!.id!,
            schedule.id!,
            employeeWeekAssignment.weekdayEnum!.value,
            executor: transaction,
          );
        }
      }
    });
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
    final List<Map<String, dynamic>> schedulesRaw = await database.rawQuery('''
    SELECT 
      E.id AS id_employee,
      E.name,
      E.has_contract,
      E.hours_in_contract,
      S.id AS id_schedule,
      S.start_time,
      S.finish_time,
      S.start_second_time,
      S.finish_second_time,
      S.is_split_shift,
      S.weekdays,
      S.color,
      ES.assigned_week
    FROM employees AS E 
    RIGHT JOIN employee_schedules AS ES ON ES.id_employee = E.id
    RIGHT JOIN schedules AS S ON ES.id_schedule = S.id
    ''');

    Map<String, ScheduleModel> schedules = {};

    for (var row in schedulesRaw) {
      String scheduleId = row['id_schedule'].toString();
      EmployeeModel? employee = row['id_employee'] != null ? EmployeeModel.fromMap(row) : null;
      String weekAssigned = row['assigned_week'] ?? '';

      if (!schedules.containsKey(scheduleId)) {
        schedules[scheduleId] = ScheduleModel.fromMap(row);
      }

      if (employee != null) {
        ScheduleModel currentSchedules = schedules[scheduleId]!;

        schedules[scheduleId] = currentSchedules.copyWith(
          employeeWeekAssignments: [
            ...currentSchedules.employeeWeekAssignments,
            EmployeeSelectionData(
              selectedEmployee: employee,
              weekdayEnum: WeekdaysEnumExtension.fromValue(weekAssigned),
            ),
          ],
        );
      }
    }

    return schedules.values.toList();
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
