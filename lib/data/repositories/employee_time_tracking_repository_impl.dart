import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/domain/repositories/employee_repository.dart';
import 'package:gestor_horas/domain/repositories/employee_time_tracking_repository.dart';

class EmployeeTimeTrackingRepositoryImpl
    implements EmployeeTimeTrackingRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String EMPLOYEE_TIME_TRACKING_TABLE = 'employee_time_tracking';

  @override
  Future<int> insertEmployeeTimeTrack(EmployeeTimeTrackModel employee) async {
    final database = await _databaseHelper.database;

    int id = await database.insert(
      EMPLOYEE_TIME_TRACKING_TABLE,
      employee.toJson(),
    );
    return id;
  }

  @override
  Future<void> updateEmployeeTimeTrack(EmployeeTimeTrackModel employee) async {
    final database = await _databaseHelper.database;

    await database.update(
      EMPLOYEE_TIME_TRACKING_TABLE,
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  @override
  Future<void> deleteEmployeeTimeTrack(EmployeeTimeTrackModel employee) async {
    final database = await _databaseHelper.database;

    await database.delete(
      EMPLOYEE_TIME_TRACKING_TABLE,
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  @override
  Future<EmployeeTimeTrackModel> getTimeTrackingById(int id) async {
    final database = await _databaseHelper.database;

    // TODO: implement getEmployeeById
    throw UnimplementedError();
  }

  @override
  Future<List<EmployeeTimeTrackModel>> getAllTimeTracking() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(
      EMPLOYEE_TIME_TRACKING_TABLE,
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
      EMPLOYEE_TIME_TRACKING_TABLE,
      where: 'registered_date >= ? AND registered_date <= ?',
      whereArgs: ['$startDay', '$finishDay'],
    );

    return timeTrackings
        .map((timeTrack) => EmployeeTimeTrackModel.fromMap(timeTrack))
        .toList();
  }
}
