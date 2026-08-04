import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_time_track_model.freezed.dart';

part 'employee_time_track_model.g.dart';

// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
class EmployeeTimeTrackModel with _$EmployeeTimeTrackModel {
  const factory EmployeeTimeTrackModel({
    int? id,
    required int employeeId,
    DateTime? startTime,
    DateTime? finishTime,
    DateTime? registeredDate,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  }) = _EmployeeTimeTrackModel;

  factory EmployeeTimeTrackModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTimeTrackModelFromJson(json);

  factory EmployeeTimeTrackModel.fromMap(Map<String, dynamic> map) {
    final startTime = map['start_time'] as String?;
    final finishTime = map['finish_time'] as String?;
    final registeredDate = map['registered_date'] as String?;

    return EmployeeTimeTrackModel(
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
