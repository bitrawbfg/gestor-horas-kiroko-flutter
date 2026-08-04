import 'package:flutter/material.dart';

import '../../data/models/time_trackings/time_track_model.dart';
import 'time_track_viewmodel.dart';

class SidePanelViewModel extends ChangeNotifier {
  final TimeTrackViewmodel _employeeTimeTrackViewmodel;

  SidePanelViewModel(this._employeeTimeTrackViewmodel);

  List<TimeTrackModel> _timeTrackings = [];

  List<TimeTrackModel> get timeTrackings => _timeTrackings;

  Future<void> loadTimeTrackingsFromEmployee({List<TimeTrackModel>? recievedTimeTrackings}) async {
    if (recievedTimeTrackings != null) {
      _timeTrackings = recievedTimeTrackings;
    }

    notifyListeners();
  }

  void getTimeTrackingsFromEmployee(int employeeId, int day) {
    List<TimeTrackModel> employeeTimeTrackings = _employeeTimeTrackViewmodel.getTimeTrackingsFromEmployee(employeeId, day);

    _timeTrackings = employeeTimeTrackings;

    loadTimeTrackingsFromEmployee(recievedTimeTrackings: employeeTimeTrackings);
  }
}