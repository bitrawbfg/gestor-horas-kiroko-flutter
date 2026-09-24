import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/data/models/employee_selection_data.dart';

part 'schedule_model.freezed.dart';

@freezed
abstract class ScheduleModel with _$ScheduleModel {
  const ScheduleModel._();

  const factory ScheduleModel({
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
  }) = _ScheduleModel;

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    final startFirstTurnTime = map['start_time'] as String;
    final finishFirstTurnTime = map['finish_time'] as String;

    final startSecondTurnTime = map['start_second_time'] as String?;
    final finishSecondTurnTime = map['finish_second_time'] as String?;

    final int? color = map['color'] as int?;

    final List<String> weekdaysList = map['weekdays'].split(',');

    return ScheduleModel(
      id: map['id_schedule'] ?? map['id'],
      isSplitShift: map['is_split_shift'] == 1,
      startFirstTurnTime: DateTime.parse(startFirstTurnTime),
      finishFirstTurnTime: DateTime.parse(finishFirstTurnTime),
      startSecondTurnTime: startSecondTurnTime != null ? DateTime.parse(startSecondTurnTime) : null,
      finishSecondTurnTime: finishSecondTurnTime != null
          ? DateTime.parse(finishSecondTurnTime)
          : null,
      weekdays: weekdaysList,
      employeeWeekAssignments: [],
      color: Color(color ?? Colors.blue.toARGB32()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'is_split_shift': isSplitShift ? 1 : 0,
      'start_time': startFirstTurnTime.toIso8601String(),
      'finish_time': finishFirstTurnTime.toIso8601String(),
      'start_second_time': startSecondTurnTime?.toIso8601String(),
      'finish_second_time': finishSecondTurnTime?.toIso8601String(),
      'weekdays': weekdays.join(','),
      'color': color.toARGB32(),
    };
  }
}
