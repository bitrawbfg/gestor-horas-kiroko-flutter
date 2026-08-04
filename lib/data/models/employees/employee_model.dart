import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';

part 'employee_model.freezed.dart';

part 'employee_model.g.dart';

// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    int? id,
    required String name,
    @JsonKey(includeToJson: false, includeFromJson: false)
    TimeTrackModel? currentTimeTrack,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }*/

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(id: map['id'], name: map['name']);
  }
}
