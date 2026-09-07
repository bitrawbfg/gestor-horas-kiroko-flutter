import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_track_model.freezed.dart';

// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
abstract class TimeTrackModel with _$TimeTrackModel {
  const factory TimeTrackModel({
    int? id,
    required int employeeId,
    DateTime? startTime,
    DateTime? finishTime,
    DateTime? registeredDate,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  }) = _TimeTrackModel;

  factory TimeTrackModel.fromMap(Map<String, dynamic> map) {
    final startTime = map['start_time'] as String?;
    final finishTime = map['finish_time'] as String?;
    final registeredDate = map['registered_date'] as String?;

    return TimeTrackModel(
      id: map['id'],
      employeeId: map['employee_id'],
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
