import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/data/models/employee_selection_data.dart';

part 'schedule_entity.freezed.dart';

@freezed
abstract class ScheduleEntity with _$ScheduleEntity {
  const ScheduleEntity._();

  const factory ScheduleEntity({
    int? id,
    @Default(false) bool isSplitShift,
    required DateTime startFirstTurnTime,
    required DateTime finishFirstTurnTime,
    DateTime? startSecondTurnTime,
    DateTime? finishSecondTurnTime,
    required List<String> weekdays,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<EmployeeSelectionData> employeeWeekAssignments,
    @Default(Color(0xFFFF9000))
    Color color,
  }) = _ScheduleEntity;
}
