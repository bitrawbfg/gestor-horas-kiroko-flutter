import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String employeesTable = 'employees';

  @override
  Future<void> insertEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.insert(employeesTable, employee.toJson());
  }

  @override
  Future<void> updateEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.update(
      employeesTable,
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  @override
  Future<void> deleteEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.delete(employeesTable, where: 'id = ?', whereArgs: [employee.id]);
  }

  @override
  Future<EmployeeModel> getEmployeeById(int id) async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(employeesTable, where: 'id = ?', whereArgs: [id]);

    return List.generate(employees.length, (employee) {
      return EmployeeModel.fromMap(employees[employee]);
    }).firstWhere((employee) => employee.id == id);
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(employeesTable);

    return List.generate(employees.length, (employee) {
      return EmployeeModel.fromMap(employees[employee]);
    });
  }

  @override
  Future<List<EmployeeModel>> getEmployeesByName(String name) async {
    // TODO: implement getEmployeesByName
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(
      employeesTable,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return employees.map((employee) => EmployeeModel.fromMap(employee)).toList();
  }
}
