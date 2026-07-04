import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeRepositoryImpl _employeesRepository = EmployeeRepositoryImpl();

  List<EmployeeModel> _employees = [];

  List<EmployeeModel> get employees => _employees;

  Future<void> loadEmployees({List<EmployeeModel>? employees}) async {
    if (employees == null) {
      _employees = await _employeesRepository.getEmployees();
    } else {
      _employees = employees;
    }

    notifyListeners();
  }

  Future<void> getEmployeesByName(String name) async {
    List<EmployeeModel> employees = await _employeesRepository.getEmployeesByName(name);
    await loadEmployees(employees: employees);
  }

  Future<void> addEmployee(String name) async {
    await _employeesRepository.insertEmployee(EmployeeModel(name: name));
    await loadEmployees();
  }

  Future<void> updateEmployee(EmployeeModel employee) async {
    await _employeesRepository.updateEmployee(employee);
    await loadEmployees();
  }

  Future<void> deleteEmployee(EmployeeModel employee) async {
    await _employeesRepository.deleteEmployee(employee);
    await loadEmployees();
  }
}
