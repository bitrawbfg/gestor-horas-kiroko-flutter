import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/domain/repositories/time_tracking_repository.dart';

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
      'SELECT * FROM $timeTrackingTable WHERE ROWID IN (SELECT max(ROWID) FROM $timeTrackingTable WHERE employee_id = ? AND finish_time IS NULL AND start_time IS NOT NULL);',
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

  Future<List<TimeTrackModel>> getAllTimeTrackingFromDateToDate(
    DateTime startDay,
    DateTime finishDay,
  ) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> timeTrackings = await database.rawQuery(
      'SELECT * FROM $timeTrackingTable WHERE DATE(registered_date) >= ? AND DATE(registered_date) <= ?',
      ['$startDay', '$finishDay'],
    );

    List<TimeTrackModel> timeTrackingsList = timeTrackings
        .map((timeTrack) => TimeTrackModel.fromMap(timeTrack))
        .toList();

    return timeTrackingsList;
  }

  Future<List<TimeTrackModel>> getTimeTrackingDateToDateFromEmployee(
    DateTime startDay,
    DateTime finishDay,
    int employeeId,
  ) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> timeTrackings = await database.rawQuery(
      'SELECT * FROM $timeTrackingTable WHERE DATE(registered_date) >= ? AND DATE(registered_date) <= ? AND employee_id = ?',
      ['$startDay', '$finishDay', employeeId],
    );

    List<TimeTrackModel> timeTrackingsList = timeTrackings
        .map((timeTrack) => TimeTrackModel.fromMap(timeTrack))
        .toList();

    return timeTrackingsList;
  }
}
