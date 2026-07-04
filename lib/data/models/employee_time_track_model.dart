import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_time_track_model.freezed.dart';
part 'employee_time_track_model.g.dart';


// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
class EmployeeTimeTrackModel with _$EmployeeTimeTrackModel {
  const factory EmployeeTimeTrackModel({int? id, required int employeeId, required DateTime? startTime, DateTime? finishTime}) = _EmployeeTimeTrackModel;

  factory EmployeeTimeTrackModel.fromJson(Map<String, dynamic> json) => _$EmployeeTimeTrackModelFromJson(json);

  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }*/

  factory EmployeeTimeTrackModel.fromMap(Map<String, dynamic> map) {
    return EmployeeTimeTrackModel(id: map['id'], employeeId: map['employee_id'], startTime: map['start_time'], finishTime: map['finish_time']);
  }
}
