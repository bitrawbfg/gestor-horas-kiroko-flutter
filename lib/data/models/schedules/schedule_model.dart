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
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    final startFirstTurnTime = map['start_time'] as String;
    final finishFirstTurnTime = map['finish_time'] as String;

    return ScheduleModel(
      id: map['id'],
      //isSplitShift: map['is_split_shift'] == 1 ? true : false,
      startFirstTurnTime: DateTime.parse(startFirstTurnTime),
      finishFirstTurnTime: DateTime.parse(finishFirstTurnTime),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      //'is_split_shift': isSplitShift ? 1 : 0,
      'start_time': startFirstTurnTime.toIso8601String(),
      'finish_time': finishFirstTurnTime.toIso8601String(),
    };
  }
}
