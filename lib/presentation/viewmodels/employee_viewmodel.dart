import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/data/repositories/employee_time_tracking_repository_impl.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeRepositoryImpl _employeesRepository = EmployeeRepositoryImpl();
  final EmployeeTimeTrackingRepositoryImpl _timeTrackRepository = EmployeeTimeTrackingRepositoryImpl();

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
  
  Future<void> assignTimeTrackToEmployee(int employeeId, EmployeeTimeTrackModel timeTrack) async {
    int employeeToReplace = _employees.indexOf(_employees.firstWhere((employee) => employee.id == employeeId));

    EmployeeModel employeeModel = _employees.firstWhere((employee) => employee.id == employeeId).copyWith(timeTrack: timeTrack);
    _employees[employeeToReplace] = employeeModel;

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

  Future<void> addTimeStart(EmployeeModel employee) async {
    if (employee.timeTrack == null) {
      EmployeeTimeTrackModel employeeTimeTrack = EmployeeTimeTrackModel(
        employee_id: employee.id!,
        start_time: DateTime.now(),
      );

      int idTimeTrack = await _timeTrackRepository.insertEmployeeTimeTrack(employeeTimeTrack);
      int idIndexEmployee = _employees.indexOf(employee);
      _employees[idIndexEmployee] = employee.copyWith(timeTrack: employeeTimeTrack.copyWith(id: idTimeTrack));

      notifyListeners();
    }
  }

  Future<void> addTimeFinish(EmployeeModel employee) async {
    EmployeeTimeTrackModel employeeTimeTrack = employee.timeTrack!.copyWith(finish_time: DateTime.now());

    await _timeTrackRepository.updateEmployeeTimeTrack(employeeTimeTrack);
    int idIndexEmployee = _employees.indexOf(employee);
    _employees[idIndexEmployee] = employee.copyWith(timeTrack: null);

    notifyListeners();
  }
}
