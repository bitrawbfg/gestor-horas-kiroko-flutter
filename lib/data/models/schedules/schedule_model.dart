import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.freezed.dart';

part 'schedule_model.g.dart';

@freezed
class ScheduleModel with _$ScheduleModel {
  const ScheduleModel._();

  const factory ScheduleModel({
    int? id,
    @Default(false) bool isSplitShift,
    required DateTime startFirstTurnTime,
    required DateTime finishFirstTurnTime,
    DateTime? startSecondTurnTime,
    DateTime? finishSecondTurnTime,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    final startFirstTurnTime = map['start_first_turn_time'] as String;
    final finishFirstTurnTime = map['finish_first_turn_time'] as String;
    final startSecondTurnTime = map['start_second_turn_time'] as String?;
    final finishSecondTurnTime = map['finish_second_turn_time'] as String?;

    return ScheduleModel(
      id: map['id'],
      isSplitShift: map['is_split_shift'] == 1 ? true : false,
      startFirstTurnTime: DateTime.parse(startFirstTurnTime),
      finishFirstTurnTime: DateTime.parse(finishFirstTurnTime),
      startSecondTurnTime: startSecondTurnTime == null
          ? null
          : DateTime.tryParse(startSecondTurnTime),
      finishSecondTurnTime: finishSecondTurnTime == null
          ? null
          : DateTime.tryParse(finishSecondTurnTime),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'is_split_shift': isSplitShift ? 1 : 0,
      'start_first_turn_time': startFirstTurnTime.toIso8601String(),
      'finish_first_turn_time': finishFirstTurnTime.toIso8601String(),
      'start_second_turn_time': startSecondTurnTime?.toIso8601String(),
      'finish_second_turn_time': finishSecondTurnTime?.toIso8601String(),
    };
  }
}
