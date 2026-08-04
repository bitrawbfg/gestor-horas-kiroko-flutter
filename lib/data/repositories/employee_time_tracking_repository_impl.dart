import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/domain/repositories/employee_time_tracking_repository.dart';

class EmployeeTimeTrackingRepositoryImpl
    implements EmployeeTimeTrackingRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String employeeTimeTrackingTable = 'employee_time_tracking';

  @override
  Future<int> insertEmployeeTimeTrack(EmployeeTimeTrackModel employee) async {
    final database = await _databaseHelper.database;

    int id = await database.insert(
      employeeTimeTrackingTable,
      employee.toJson(),
    );
    return id;
  }

  @override
  Future<void> updateEmployeeTimeTrack(EmployeeTimeTrackModel employee) async {
    final database = await _databaseHelper.database;

    await database.update(
      employeeTimeTrackingTable,
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  @override
  Future<void> deleteEmployeeTimeTrack(EmployeeTimeTrackModel employee) async {
    final database = await _databaseHelper.database;

    await database.delete(
      employeeTimeTrackingTable,
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<EmployeeTimeTrackModel?> getLastTimeTrackingByEmployeeId(
    int employeeId,
  ) async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> timeTrackingsMap = await database.rawQuery(
      'SELECT * FROM $employeeTimeTrackingTable WHERE ROWID IN (SELECT max(ROWID) FROM $employeeTimeTrackingTable WHERE employee_id = ? AND finish_time IS NULL AND start_time IS NOT NULL);',
      [employeeId],
    );

    if (timeTrackingsMap.isEmpty) return null;

    return EmployeeTimeTrackModel.fromMap(timeTrackingsMap.first);
  }

  @override
  Future<EmployeeTimeTrackModel> getTimeTrackingById(int id) async {
    await _databaseHelper.database;

    // TODO: implement getEmployeeById
    throw UnimplementedError();
  }

  @override
  Future<List<EmployeeTimeTrackModel>> getAllTimeTracking() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(
      employeeTimeTrackingTable,
    );

    return List.generate(employees.length, (employee) {
      return EmployeeTimeTrackModel.fromMap(employees[employee]);
    });
  }

  Future<List<EmployeeTimeTrackModel>> getAllTimeTrackingFromDateToDate(
    DateTime startDay,
    DateTime finishDay,
  ) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> timeTrackings = await database.query(
      employeeTimeTrackingTable,
      // where: 'registered_date >= ? AND registered_date <= ?',
      // whereArgs: ['$startDay', '$finishDay'],
    );

    List<EmployeeTimeTrackModel> timeTrackingsList = timeTrackings
        .map((timeTrack) => EmployeeTimeTrackModel.fromMap(timeTrack))
        .where(
          (timeTrack) =>
              timeTrack.registeredDate!.isAfter(startDay) &&
              timeTrack.registeredDate!.isBefore(finishDay),
        )
        .toList();

    return timeTrackingsList;
  }

  Future<List<EmployeeTimeTrackModel>> getTimeTrackingDateToDateFromEmployee(
    DateTime startDay,
    DateTime finishDay,
    int employeeId,
  ) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> timeTrackings = await database.query(
      employeeTimeTrackingTable,
      where: 'employee_id = ?',
      whereArgs: [employeeId],
    );

    List<EmployeeTimeTrackModel> timeTrackingsList = timeTrackings
        .map((timeTrack) => EmployeeTimeTrackModel.fromMap(timeTrack))
        .where(
          (timeTrack) =>
              timeTrack.registeredDate!.isAfter(startDay) &&
              timeTrack.registeredDate!.isBefore(finishDay),
        )
        .toList();

    return timeTrackingsList;
  }
}
