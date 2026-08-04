import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';

abstract class TimeTrackingRepository {
  Future<TimeTrackModel> getTimeTrackingById(int id);
  Future<List<TimeTrackModel>> getAllTimeTracking();

  Future<void> insertTimeTrack(TimeTrackModel timeTrack);
  Future<void> updateTimeTrack(TimeTrackModel timeTrack);
  Future<void> deleteTimeTrack(TimeTrackModel timeTrack);
}