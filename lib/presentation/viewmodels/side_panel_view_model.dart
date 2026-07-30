import 'package:flutter/material.dart';

import '../../data/models/employee_time_track_model.dart';
import 'employee_time_track_viewmodel.dart';

class SidePanelViewModel extends ChangeNotifier {
  final EmployeeTimeTrackViewmodel _employeeTimeTrackViewmodel;

  SidePanelViewModel(this._employeeTimeTrackViewmodel);

  List<EmployeeTimeTrackModel> _timeTrackings = [];

  List<EmployeeTimeTrackModel> get timeTrackings => _timeTrackings;

  Future<void> loadTimeTrackingsFromEmployee({List<EmployeeTimeTrackModel>? recievedTimeTrackings}) async {
    if (recievedTimeTrackings != null) {
      _timeTrackings = recievedTimeTrackings;
    }

    notifyListeners();
  }

  void getTimeTrackingsFromEmployee(int employeeId, int day) {
    List<EmployeeTimeTrackModel> employeeTimeTrackings = _employeeTimeTrackViewmodel.getTimeTrackingsFromEmployee(employeeId, day);

    _timeTrackings = employeeTimeTrackings;

    loadTimeTrackingsFromEmployee(recievedTimeTrackings: employeeTimeTrackings);
  }
}