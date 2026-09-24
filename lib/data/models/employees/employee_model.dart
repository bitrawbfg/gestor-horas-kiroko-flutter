import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/data/models/schedules/schedule_model.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';

part 'employee_model.freezed.dart';

// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
abstract class EmployeeModel with _$EmployeeModel {
  const EmployeeModel._();

  const factory EmployeeModel({
    int? id,
    required String name,
    @Default(false) bool hasContract,
    @Default(0) int hoursInContract,
    List<ScheduleModel>? schedules,
    @JsonKey(includeToJson: false, includeFromJson: false) TimeTrackModel? currentTimeTrack,
  }) = _EmployeeModel;

  factory EmployeeModel.fromMap(
    Map<String, dynamic> map, {
    List<ScheduleModel> schedules = const [],
  }) {
    return EmployeeModel(
      id: map['id_employee'] ?? map['id'],
      name: map['name'],
      hasContract: map['has_contract'] == 1 ? true : false,
      hoursInContract: map['hours_in_contract'],
      schedules: schedules,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'has_contract': hoursInContract > 0 ? 1 : 0,
      'hours_in_contract': hoursInContract,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
