import 'package:dartz/dartz.dart';
import 'package:gestor_horas/core/error/failure.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';
import 'package:gestor_horas/features/employees/domain/repositories/employee_repository.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';
import 'package:gestor_horas/features/time-trackings/domain/repositories/time_tracking_repository.dart';
import 'package:gestor_horas/presentation/view_models/base_viewmodel.dart';

class EmployeeViewModel extends BaseViewModel {
  final EmployeeRepository _employeesRepository;
  final TimeTrackingRepository _timeTrackRepository;

  EmployeeViewModel({required this._employeesRepository, required this._timeTrackRepository});

  List<EmployeeEntity> _employees = [];

  List<EmployeeEntity> get employees => _employees;

  EmployeeEntity? _selectedEmployee;

  EmployeeEntity? get selectedEmployee => _selectedEmployee;

  set setSelectedEmployee(EmployeeEntity value) {
    _selectedEmployee = value;

    notifyListeners();
  }

  Future<void> loadEmployees({List<EmployeeEntity>? employees}) async {
    if (employees == null) {
      Either<Failure, List<EmployeeEntity>> employees = await _employeesRepository.getEmployees();

      employees.fold((failure) => print(failure.message), (employees) => _employees = employees);

      for (EmployeeEntity employee in _employees) {
        int index = _employees.indexOf(employee);
        TimeTrackModel? timeTrack = await _timeTrackRepository.getLastTimeTrackingByEmployeeId(
          employee.id!,
        );

        if (timeTrack != null) {
          EmployeeEntity employeeWithTimeTrack = employee.copyWith(currentTimeTrack: timeTrack);
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

    EmployeeEntity employeeModel = _employees
        .firstWhere((employee) => employee.id == employeeId)
        .copyWith(currentTimeTrack: timeTrack);
    _employees[employeeToReplace] = employeeModel;

    notifyListeners();
  }

  Future<void> getEmployeesById(int id) async {
    Either<Failure, EmployeeEntity> result = await _employeesRepository.getEmployeeById(id);

    result.fold(
      (failure) => super.setError(failure.message),
      (employee) => _selectedEmployee = employee,
    );
    notifyListeners();
  }

  Future<void> getEmployeesByName(String name) async {
    Either<Failure, List<EmployeeEntity>> result = await _employeesRepository.getEmployeesByName(
      name,
    );

    result.fold(
      (failure) => super.setError(failure.message),
      (employees) async => await loadEmployees(employees: employees),
    );
  }

  Future<void> addEmployee(EmployeeEntity employee) async {
    await _employeesRepository.insertEmployee(employee);
    await loadEmployees();
  }

  Future<void> updateEmployee(EmployeeEntity employee) async {
    await _employeesRepository.updateEmployee(employee);

    EmployeeEntity employeeInList = _employees
        .where((employeeFromList) => employeeFromList.id == employee.id)
        .first;
    int indexEmployee = _employees.indexOf(employeeInList);
    _employees[indexEmployee] = employee;

    await loadEmployees();
  }

  Future<void> deleteEmployee(EmployeeEntity employee) async {
    await _employeesRepository.deleteEmployee(employee);
    await loadEmployees();
  }
}
