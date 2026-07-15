import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_time_track_model.dart';
import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_time_tracking_repository_impl.dart';

class EmployeeTimeTrackViewmodel extends ChangeNotifier {
  final EmployeeTimeTrackingRepositoryImpl _repository =
      EmployeeTimeTrackingRepositoryImpl();

  Future<EmployeeTimeTrackModel?> addTimeStart(EmployeeModel employee) async {
    if (employee.currentTimeTrack == null) {
      EmployeeTimeTrackModel employeeTimeTrack = EmployeeTimeTrackModel(
        employee_id: employee.id!,
        start_time: DateTime.now(),
      );

      int id = await _repository.insertEmployeeTimeTrack(employeeTimeTrack);
      return employeeTimeTrack.copyWith(id: id);
    }

    return null;
  }

  Future<void> addTimeFinish(EmployeeModel employee) async {
    EmployeeTimeTrackModel employeeTimeTrack = employee.currentTimeTrack!.copyWith(finish_time: DateTime.now());

    await _repository.updateEmployeeTimeTrack(employeeTimeTrack);
    notifyListeners();
  }
}
