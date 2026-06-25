import 'package:gestor_horas/data/models/employee_model.dart';

abstract class EmployeeRepository {
  Future<EmployeeModel> getEmployeeById(int id);
  Future<List<EmployeeModel>> getEmployeesByName(String name);
  Future<List<EmployeeModel>> getEmployees();

  Future<void> insertEmployee(EmployeeModel employee);
  Future<void> updateEmployee(EmployeeModel employee);
  Future<void> deleteEmployee(EmployeeModel employee);
}