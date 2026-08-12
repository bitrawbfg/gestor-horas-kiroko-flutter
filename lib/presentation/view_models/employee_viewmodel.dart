import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/data/repositories/time_tracking_repository_impl.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeRepositoryImpl _employeesRepository = EmployeeRepositoryImpl();
  final TimeTrackingRepositoryImpl _timeTrackRepository = TimeTrackingRepositoryImpl();

  List<EmployeeModel> _employees = [];
  List<EmployeeModel> get employees => _employees;

  EmployeeModel? _selectedEmployee;
  EmployeeModel? get selectedEmployee => _selectedEmployee;

  set setSelectedEmployee(EmployeeModel value) {
    _selectedEmployee = value;
  }

  Future<void> loadEmployees({List<EmployeeModel>? employees}) async {
    if (employees == null) {
      _employees = await _employeesRepository.getEmployees();

      for (EmployeeModel employee in _employees) {
        int index = _employees.indexOf(employee);
        TimeTrackModel? timeTrack = await _timeTrackRepository.getLastTimeTrackingByEmployeeId(
          employee.id!,
        );

        if (timeTrack != null) {
          EmployeeModel employeeWithTimeTrack = employee.copyWith(currentTimeTrack: timeTrack);
          _employees[index] = employeeWithTimeTrack;
        }
      }
    } else {
      _employees = employees;
    }

    notifyListeners();
  }

  Future<void> assignTimeTrackToEmployee(int employeeId, TimeTrackModel timeTrack) async {
    int employeeToReplace = _employees.indexOf(
      _employees.firstWhere((employee) => employee.id == employeeId),
    );

    EmployeeModel employeeModel = _employees
        .firstWhere((employee) => employee.id == employeeId)
        .copyWith(currentTimeTrack: timeTrack);
    _employees[employeeToReplace] = employeeModel;

    notifyListeners();
  }

  Future<void> getEmployeesById(int id) async {
    EmployeeModel employee = await _employeesRepository.getEmployeeById(id);

    _selectedEmployee = employee;
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

    EmployeeModel employeeInList = _employees
        .where((employeeFromList) => employeeFromList.id == employee.id)
        .first;
    int indexEmployee = _employees.indexOf(employeeInList);
    _employees[indexEmployee] = employee;

    await loadEmployees();
  }

  Future<void> deleteEmployee(EmployeeModel employee) async {
    await _employeesRepository.deleteEmployee(employee);
    await loadEmployees();
  }
}
