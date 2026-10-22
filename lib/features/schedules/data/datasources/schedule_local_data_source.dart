import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/features/employees/data/models/employee_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ScheduleLocalDataSource {
  static const String employeeTableName = 'employees';
  final DatabaseHelper _databaseHelper;

  ScheduleLocalDataSource({required this._databaseHelper});

  Future<List<EmployeeModel>> getEmployees() async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> employeeQueryResults = await database.rawQuery(
      '''SELECT *, E.id AS id_employee FROM employees as E 
          LEFT JOIN employee_schedules AS ES ON E.id = ES.id_employee 
          LEFT JOIN schedules AS S ON S.id = ES.id_schedule''',
    );

    return employeeQueryResults.map((employee) => EmployeeModel.fromJson(employee)).toList();
  }

  Future<int> insertEmployee(EmployeeModel employee) async {
    try {
      final database = await _databaseHelper.database;

      return await database.transaction(
        (transaction) => transaction.insert(employeeTableName, employee.toJson()),
      );
    } on DatabaseException catch (exception) {
      print(exception);
      return 0;
    }
  }
}
