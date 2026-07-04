import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employee_model.dart';
import 'package:gestor_horas/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String EMPLOYEES_TABLE = 'employees';

  @override
  Future<void> insertEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.insert(EMPLOYEES_TABLE, employee.toJson());
  }

  @override
  Future<void> updateEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.update(
      EMPLOYEES_TABLE,
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  @override
  Future<void> deleteEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.delete(
      EMPLOYEES_TABLE,
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  @override
  Future<EmployeeModel> getEmployeeById(int id) async {
    final database = await _databaseHelper.database;

    // TODO: implement getEmployeeById
    throw UnimplementedError();
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(
      EMPLOYEES_TABLE,
    );

    return List.generate(employees.length, (employee) {
      return EmployeeModel.fromMap(employees[employee]);
    });
  }

  @override
  Future<List<EmployeeModel>> getEmployeesByName(String name) async {
    // TODO: implement getEmployeesByName
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.query(
      EMPLOYEES_TABLE,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return employees
        .map((employee) => EmployeeModel.fromMap(employee))
        .toList();
  }
}
