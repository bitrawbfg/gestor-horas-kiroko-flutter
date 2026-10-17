import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/domain/repositories/time_tracking_repository.dart';
import 'package:intl/intl.dart';

class TimeTrackingRepositoryImpl implements TimeTrackingRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String timeTrackingTable = 'employee_time_tracking';
  static const String registeredDateField = 'registered_date';

  @override
  Future<int> insertTimeTrack(TimeTrackModel timeTrack) async {
    final database = await _databaseHelper.database;

    int id = await database.insert(timeTrackingTable, timeTrack.toJson());
    return id;
  }

  @override
  Future<void> updateTimeTrack(TimeTrackModel timeTrack) async {
    final database = await _databaseHelper.database;

    await database.update(
      timeTrackingTable,
      timeTrack.toJson(),
      where: 'id = ?',
      whereArgs: [timeTrack.id],
    );
  }

  @override
  Future<void> deleteTimeTrack(TimeTrackModel timeTrack) async {
    final database = await _databaseHelper.database;

    await database.delete(timeTrackingTable, where: 'id = ?', whereArgs: [timeTrack.id]);
  }

  Future<TimeTrackModel?> getLastTimeTrackingByEmployeeId(int employeeId) async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> timeTrackingsMap = await database.rawQuery(
      'SELECT * FROM $timeTrackingTable WHERE ROWID IN (SELECT max(ROWID) FROM $timeTrackingTable WHERE id_employee = ? AND finish_time IS NULL AND start_time IS NOT NULL);',
      [employeeId],
    );

    if (timeTrackingsMap.isEmpty) return null;

    return TimeTrackModel.fromMap(timeTrackingsMap.first);
  }

  @override
  Future<TimeTrackModel> getTimeTrackingById(int id) async {
    await _databaseHelper.database;

    // TODO: implement getEmployeeById
    throw UnimplementedError();
  }

  @override
  Future<List<TimeTrackModel>> getAllTimeTracking() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(timeTrackingTable);

    return List.generate(employees.length, (employee) {
      return TimeTrackModel.fromMap(employees[employee]);
    });
  }

  @override
  Future<List<TimeTrackModel>> getTimeTrackingsBySpecificDayAndEmployee(
    DateTime day,
    int employeeId,
  ) async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> foundTimeTrackings = await database.rawQuery(
      'SELECT * FROM $timeTrackingTable WHERE registered_date LIKE ? AND id_employee = ?',
      ['${DateFormat('yyyy-MM-dd').format(day)}%', employeeId],
    );
    List<TimeTrackModel> timeTrackings = foundTimeTrackings
        .map((timeTrack) => TimeTrackModel.fromMap(timeTrack))
        .toList();

    return timeTrackings;
  }

  @override
  Future<List<TimeTrackModel>> getAllTimeTrackingsFromDateToDate(
    DateTime startDay,
    DateTime finishDay,
  ) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> timeTrackings = await database.rawQuery(
      'SELECT * FROM $timeTrackingTable WHERE DATE(registered_date) >= ? AND DATE(registered_date) <= ?',
      [
        (startDay.toString().split(' ')[0].toString()),
        (finishDay.toString().split(' ')[0].toString()),
      ],
    );

    List<TimeTrackModel> timeTrackingsList = timeTrackings
        .map((timeTrack) => TimeTrackModel.fromMap(timeTrack))
        .toList();

    return timeTrackingsList;
  }

  @override
  Future<List<TimeTrackModel>> getTimeTrackingsFromDateToDateByEmployee(
    DateTime startDay,
    DateTime finishDay,
    int employeeId,
  ) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> timeTrackings = await database.rawQuery(
      'SELECT * FROM $timeTrackingTable WHERE DATE(registered_date) >= ? AND DATE(registered_date) <= ? AND id_employee = ?',
      [
        (startDay.toString().split(' ')[0].toString()),
        (finishDay.toString().split(' ')[0].toString()),
        employeeId,
      ],
    );

    List<TimeTrackModel> timeTrackingsList = timeTrackings
        .map((timeTrack) => TimeTrackModel.fromMap(timeTrack))
        .toList();

    return timeTrackingsList;
  }
}
