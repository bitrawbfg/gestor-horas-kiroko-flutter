import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  static const String employeesTable = 'employees';

  @override
  Future<void> insertEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.insert(employeesTable, employee.toMap());
  }

  @override
  Future<void> updateEmployee(EmployeeModel employee) async {
    final database = await _databaseHelper.database;

    await database.update(
      employeesTable,
      employee.toMap(),
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
    final List<Map<String, dynamic>> employees = await database.query(
      employeesTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    return List.generate(employees.length, (employee) {
      return EmployeeModel.fromMap(employees[employee]);
    }).firstWhere((employee) => employee.id == id);
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final database = await _databaseHelper.database;
    final List<Map<String, dynamic>> employees = await database.rawQuery(
      '''SELECT *, E.id AS employee_id FROM employees as E 
          LEFT JOIN employee_schedules AS ES ON E.id = ES.id_employee 
          LEFT JOIN schedules AS S ON S.id = ES.id_schedule''',
    );

    final Map<int, Map<String, dynamic>> employeesData = <int, Map<String, dynamic>>{};
    final Map<int, List<ScheduleModel>> schedulesPerEmployee = <int, List<ScheduleModel>>{};

    for (final Map<String, dynamic> employeeRow in employees) {
      int employeeId = employeeRow['employee_id'];

      employeesData[employeeId] = employeeRow;
      if (employeeRow['id_schedule'] != null) {
        final schedules = schedulesPerEmployee[employeeId] ??= <ScheduleModel>[]; // If the value is null, initialize the list
        schedules.add(ScheduleModel.fromMap(employeeRow));
      }
    }

    return employeesData.entries.map((entry) {
      final int employeeId = entry.key;
      final Map<String, dynamic> employeeData = entry.value;

      final List<ScheduleModel> schedules = schedulesPerEmployee[employeeId] ?? [];
      final EmployeeModel employee = EmployeeModel.fromMap(employeeData);

      return employee.copyWith(schedules: schedules);
    }).toList();
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
