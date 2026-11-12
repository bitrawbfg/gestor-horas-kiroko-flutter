import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_track_entity.freezed.dart';

@freezed
abstract class TimeTrackEntity with _$TimeTrackEntity {
  const TimeTrackEntity._();

  const factory TimeTrackEntity({
    int? id,
    required int idEmployee,
    required DateTime startTime,
    DateTime? finishTime,
  }) = _TimeTrackEntity;
}
