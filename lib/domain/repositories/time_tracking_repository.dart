import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';

abstract class TimeTrackingRepository {
  Future<int> insertTimeTrack(TimeTrackModel timeTrack);
  Future<void> updateTimeTrack(TimeTrackModel timeTrack);
  Future<void> deleteTimeTrack(TimeTrackModel timeTrack);

  Future<TimeTrackModel> getTimeTrackingById(int id); // NOT USED
  Future<List<TimeTrackModel>> getAllTimeTracking();
  Future<List<TimeTrackModel>> getAllTimeTrackingsFromDateToDate(
    DateTime firstDayOfWeek,
    DateTime lastDayOfWeek,
  );
  Future<List<TimeTrackModel>> getTimeTrackingsFromDateToDateByEmployee(
    DateTime firstDayOfMonth,
    DateTime lastDayOfMonth,
    int employeeId
  );
  Future<List<TimeTrackModel>> getTimeTrackingsBySpecificDayAndEmployee(
    DateTime day,
    int employeeId,
  );
}
