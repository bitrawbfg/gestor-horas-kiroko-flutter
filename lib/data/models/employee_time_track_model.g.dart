// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_time_track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeTimeTrackModelImpl _$$EmployeeTimeTrackModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeTimeTrackModelImpl(
  id: (json['id'] as num?)?.toInt(),
  employee_id: (json['employee_id'] as num).toInt(),
  start_time: json['start_time'] == null
      ? null
      : DateTime.parse(json['start_time'] as String),
  finish_time: json['finish_time'] == null
      ? null
      : DateTime.parse(json['finish_time'] as String),
);

Map<String, dynamic> _$$EmployeeTimeTrackModelImplToJson(
  _$EmployeeTimeTrackModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'employee_id': instance.employee_id,
  'start_time': instance.start_time?.toIso8601String(),
  'finish_time': instance.finish_time?.toIso8601String(),
};
