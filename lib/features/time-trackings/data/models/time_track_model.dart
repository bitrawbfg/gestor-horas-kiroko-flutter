import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';

part 'time_track_model.freezed.dart';

@freezed
abstract class TimeTrackModel with _$TimeTrackModel {
  const TimeTrackModel._();

  const factory TimeTrackModel({
    int? id,
    required int idEmployee,
    required DateTime startTime,
    DateTime? finishTime,
  }) = _TimeTrackModel;

  factory TimeTrackModel.fromJson(Map<String, dynamic> map) {
    final startTime = map['start_time'] as String;
    final finishTime = map['finish_time'] as String?;

    return TimeTrackModel(
      id: map['id'],
      idEmployee: map['id_employee'],
      startTime: DateTime.parse(startTime),
      finishTime: finishTime == null ? null : DateTime.tryParse(finishTime),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_employee': idEmployee,
      'start_time': startTime.toIso8601String(),
      'finish_time': finishTime?.toIso8601String(),
    };
  }

  TimeTrackEntity toEntity() => TimeTrackEntity(
    id: id,
    idEmployee: idEmployee,
    startTime: startTime,
    finishTime: finishTime,
  );

  factory TimeTrackModel.fromEntity(TimeTrackEntity timeTrackEntity) => TimeTrackModel(
    id: timeTrackEntity.id,
    idEmployee: timeTrackEntity.idEmployee,
    startTime: timeTrackEntity.startTime,
    finishTime: timeTrackEntity.finishTime,
  );
}
