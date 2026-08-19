// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleModelImpl _$$ScheduleModelImplFromJson(
  Map<String, dynamic> json,
) => _$ScheduleModelImpl(
  id: (json['id'] as num?)?.toInt(),
  isSplitShift: json['is_split_shift'] as bool? ?? false,
  startFirstTurnTime: DateTime.parse(json['start_first_turn_time'] as String),
  finishFirstTurnTime: DateTime.parse(json['finish_first_turn_time'] as String),
  startSecondTurnTime: json['start_second_turn_time'] == null
      ? null
      : DateTime.parse(json['start_second_turn_time'] as String),
  finishSecondTurnTime: json['finish_second_turn_time'] == null
      ? null
      : DateTime.parse(json['finish_second_turn_time'] as String),
);

Map<String, dynamic> _$$ScheduleModelImplToJson(
  _$ScheduleModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'is_split_shift': instance.isSplitShift,
  'start_first_turn_time': instance.startFirstTurnTime.toIso8601String(),
  'finish_first_turn_time': instance.finishFirstTurnTime.toIso8601String(),
  'start_second_turn_time': instance.startSecondTurnTime?.toIso8601String(),
  'finish_second_turn_time': instance.finishSecondTurnTime?.toIso8601String(),
};
