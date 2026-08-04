import 'package:gestor_horas/data/models/employee_time_track_model.dart';

abstract class EmployeeTimeTrackingRepository {
  Future<EmployeeTimeTrackModel> getTimeTrackingById(int id);
  Future<List<EmployeeTimeTrackModel>> getAllTimeTracking();

  Future<void> insertEmployeeTimeTrack(EmployeeTimeTrackModel employee);
  Future<void> updateEmployeeTimeTrack(EmployeeTimeTrackModel employee);
  Future<void> deleteEmployeeTimeTrack(EmployeeTimeTrackModel employee);
}