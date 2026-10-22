import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_track_entity.freezed.dart';

@freezed
abstract class TimeTrackEntity with _$TimeTrackEntity {
  const TimeTrackEntity._();

  const factory TimeTrackEntity({
    int? id,
    required int idEmployee,
    DateTime? startTime,
    DateTime? finishTime,
    DateTime? registeredDate,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  }) = _TimeTrackEntity;
}
