// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeTrackModel _$TimeTrackModelFromJson(Map<String, dynamic> json) =>
    _TimeTrackModel(
      id: (json['id'] as num?)?.toInt(),
      idEmployee: (json['id_employee'] as num).toInt(),
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

Map<String, dynamic> _$TimeTrackModelToJson(_TimeTrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_employee': instance.idEmployee,
      'start_time': instance.startTime?.toIso8601String(),
      'finish_time': instance.finishTime?.toIso8601String(),
      'registered_date': instance.registeredDate?.toIso8601String(),
      'difference': instance.difference,
    };
