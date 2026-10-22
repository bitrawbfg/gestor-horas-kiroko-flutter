import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/features/employees/data/models/employee_model.dart';

class EmployeeLocalDataSource {
  static const String employeeTableName = 'employees';
  final DatabaseHelper _databaseHelper;

  EmployeeLocalDataSource({required this._databaseHelper});

  Future<List<EmployeeModel>> getEmployees() async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> employeeQueryResults = await database.rawQuery(
      '''SELECT *, E.id AS id_employee FROM employees as E 
          LEFT JOIN employee_schedules AS ES ON E.id = ES.id_employee 
          LEFT JOIN schedules AS S ON S.id = ES.id_schedule''',
    );

    return employeeQueryResults.map((employee) => EmployeeModel.fromJson(employee)).toList();
  }

  Future<EmployeeModel> getEmployeeById(int id) async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> employeeQueryResults = await database.query(
      employeeTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return List.generate(
      employeeQueryResults.length,
      (employee) => EmployeeModel.fromJson(employeeQueryResults[employee]),
    ).first;
  }

  Future<List<EmployeeModel>> getEmployeesByName(String name) async {
    final database = await _databaseHelper.database;

    final List<Map<String, dynamic>> employeeQueryResults = await database.query(
      employeeTableName,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return employeeQueryResults.map((employee) => EmployeeModel.fromJson(employee)).toList();
  }

  Future<int> insertEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    return await database.transaction(
      (transaction) => transaction.insert(employeeTableName, employee.toJson()),
    );
  }

  Future<int> updateEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    return await database.transaction(
      (transaction) => transaction.update(
        employeeTableName,
        employee.toJson(),
        where: 'id = ?',
        whereArgs: [employee.id],
      ),
    );
  }

  Future<int> deleteEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    return await database.transaction(
      (transaction) =>
          transaction.delete(employeeTableName, where: 'id = ?', whereArgs: [employee.id]),
    );
  }
}
