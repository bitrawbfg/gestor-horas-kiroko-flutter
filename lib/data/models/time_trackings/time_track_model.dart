import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_track_model.freezed.dart';

part 'time_track_model.g.dart';

@freezed
abstract class TimeTrackModel with _$TimeTrackModel {
  const factory TimeTrackModel({
    int? id,
    required int idEmployee,
    DateTime? startTime,
    DateTime? finishTime,
    DateTime? registeredDate,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  }) = _TimeTrackModel;

  factory TimeTrackModel.fromJson(Map<String, dynamic> json) =>
      _$TimeTrackModelFromJson(json);

  factory TimeTrackModel.fromMap(Map<String, dynamic> map) {
    final startTime = map['start_time'] as String?;
    final finishTime = map['finish_time'] as String?;
    final registeredDate = map['registered_date'] as String?;

    return TimeTrackModel(
      id: map['id'],
      idEmployee: map['id_employee'],
      startTime: startTime == null ? null : DateTime.tryParse(startTime),
      finishTime: finishTime == null ? null : DateTime.tryParse(finishTime),
      registeredDate: registeredDate == null
          ? null
          : DateTime.tryParse(registeredDate),
      difference: map['difference'],
      isTurnOnGoing:
          startTime != null &&
          startTime.isNotEmpty &&
          (finishTime == null || finishTime.isEmpty),
    );
  }
}
