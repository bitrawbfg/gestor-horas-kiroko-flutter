// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_time_track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeTimeTrackModelImpl _$$EmployeeTimeTrackModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeTimeTrackModelImpl(
  id: (json['id'] as num?)?.toInt(),
  employeeId: (json['employeeId'] as num).toInt(),
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  finishTime: json['finishTime'] == null
      ? null
      : DateTime.parse(json['finishTime'] as String),
);

Map<String, dynamic> _$$EmployeeTimeTrackModelImplToJson(
  _$EmployeeTimeTrackModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'startTime': instance.startTime?.toIso8601String(),
  'finishTime': instance.finishTime?.toIso8601String(),
};
