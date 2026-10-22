import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';

part 'employee_entity.freezed.dart';

// Tutorial para crear modelos con @freezed
// https://medium.com/@CodeCraftMobile/flutter-clean-architecture-implement-local-storage-with-sqlite-freezed-using-sqflite-and-bloc-68b967c604fc
@freezed
abstract class EmployeeEntity with _$EmployeeEntity {
  const EmployeeEntity._();

  const factory EmployeeEntity({
    int? id,
    required String name,
    @Default(false) bool hasContract,
    @Default(0) int hoursInContract,
    @JsonKey(includeToJson: false, includeFromJson: false) TimeTrackModel? currentTimeTrack,
  }) = _EmployeeEntity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
