import 'package:dartz/dartz.dart';
import 'package:gestor_horas/core/error/failure.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';

abstract class TimeTrackingRepository {
  Future<Either<Failure, int>> insertTimeTrack(TimeTrackEntity timeTrack);
  Future<Either<Failure, void>> updateTimeTrack(TimeTrackEntity timeTrack);
  Future<Either<Failure, void>> deleteTimeTrack(TimeTrackEntity timeTrack);

  Future<Either<Failure, void>> startTracking(int employeeId);
  Future<Either<Failure, void>> stopTracking(int employeeId);

  Future<Either<Failure, TimeTrackEntity>> getOpenTracking(int employeeId);
  Future<Either<Failure, List<TimeTrackEntity>>> getOpenTrackings();
  Future<Either<Failure, List<TimeTrackEntity>>> getTimeTrackingsByDateRange(DateTime startAt, DateTime endAt);
}
