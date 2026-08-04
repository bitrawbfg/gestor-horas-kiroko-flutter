// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_time_track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeTimeTrackModelImpl _$$EmployeeTimeTrackModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeTimeTrackModelImpl(
  id: (json['id'] as num?)?.toInt(),
  employeeId: (json['employee_id'] as num).toInt(),
  startTime: json['start_time'] == null
      ? null
      : DateTime.parse(json['start_time'] as String),
  finishTime: json['finish_time'] == null
      ? null
      : DateTime.parse(json['finish_time'] as String),
  registeredDate: json['registered_date'] == null
      ? null
      : DateTime.parse(json['registered_date'] as String),
  difference: (json['difference'] as num?)?.toInt(),
);

Map<String, dynamic> _$$EmployeeTimeTrackModelImplToJson(
  _$EmployeeTimeTrackModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'employee_id': instance.employeeId,
  'start_time': instance.startTime?.toIso8601String(),
  'finish_time': instance.finishTime?.toIso8601String(),
  'registered_date': instance.registeredDate?.toIso8601String(),
  'difference': instance.difference,
};
