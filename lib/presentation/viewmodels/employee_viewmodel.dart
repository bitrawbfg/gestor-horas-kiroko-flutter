import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/data/repositories/employee_time_tracking_repository_impl.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeRepositoryImpl _employeesRepository = EmployeeRepositoryImpl();
  final EmployeeTimeTrackingRepositoryImpl _timeTrackRepository =
      EmployeeTimeTrackingRepositoryImpl();

  final firstDate = DateTime(2000);
  final lastDate = DateTime(2100);

  DateTime selectedDate = DateTime.now();
  bool open = false;

  void toggle() {
    open = !open;
    notifyListeners();
  }

  void close() {
    if (!open) return;
    open = false;
    notifyListeners();
  }

  void setDate(DateTime d) {
    selectedDate = d;
    open = false; // optional: close after selecting
    notifyListeners();
  }

  List<EmployeeModel> _employees = [];

  List<EmployeeModel> get employees => _employees;

  Future<void> loadEmployees({List<EmployeeModel>? employees}) async {
    if (employees == null) {
      _employees = await _employeesRepository.getEmployees();

      for (EmployeeModel employee in _employees) {
        int index = _employees.indexOf(employee);
        EmployeeTimeTrackModel? timeTrack = await _timeTrackRepository.getLastTimeTrackingByEmployeeId(employee.id!);

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

  Future<void> assignTimeTrackToEmployee(
    int employeeId,
    EmployeeTimeTrackModel timeTrack,
  ) async {
    int employeeToReplace = _employees.indexOf(
      _employees.firstWhere((employee) => employee.id == employeeId),
    );

    EmployeeModel employeeModel = _employees
        .firstWhere((employee) => employee.id == employeeId)
        .copyWith(currentTimeTrack: timeTrack);
    _employees[employeeToReplace] = employeeModel;

    notifyListeners();
  }

  Future<void> getEmployeesByName(String name) async {
    List<EmployeeModel> employees = await _employeesRepository
        .getEmployeesByName(name);
    await loadEmployees(employees: employees);
  }

  Future<void> addEmployee(String name) async {
    await _employeesRepository.insertEmployee(EmployeeModel(name: name));
    await loadEmployees();
  }

  Future<void> updateEmployee(EmployeeModel employee) async {
    await _employeesRepository.updateEmployee(employee);

    EmployeeModel employeeInList = _employees.where((employeeFromList) => employeeFromList.id == employee.id).first;
    int indexEmployee = _employees.indexOf(employeeInList);
    _employees[indexEmployee] = employee;

    await loadEmployees();
  }

  Future<void> deleteEmployee(EmployeeModel employee) async {
    await _employeesRepository.deleteEmployee(employee);
    await loadEmployees();
  }
}
