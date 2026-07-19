import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_time_track_model.freezed.dart';

part 'employee_time_track_model.g.dart';

// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
class EmployeeTimeTrackModel with _$EmployeeTimeTrackModel {
  const factory EmployeeTimeTrackModel({
    int? id,
    required int employee_id,
    DateTime? start_time,
    DateTime? finish_time,
    DateTime? registered_date,
    int? difference,
  }) = _EmployeeTimeTrackModel;

  factory EmployeeTimeTrackModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTimeTrackModelFromJson(json);

  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }*/

  factory EmployeeTimeTrackModel.fromMap(Map<String, dynamic> map) {
    final startTime = map['start_time'] as String?;
    final finishTime = map['finish_time'] as String?;
    final registeredDate = map['registered_date'] as String?;

    return EmployeeTimeTrackModel(
      id: map['id'],
      employee_id: map['employee_id'],
      start_time: startTime == null ? null : DateTime.tryParse(startTime),
      finish_time: finishTime == null ? null : DateTime.tryParse(finishTime),
      registered_date: registeredDate == null ? null : DateTime.tryParse(registeredDate),
      difference: map['difference'],
    );
  }
}
