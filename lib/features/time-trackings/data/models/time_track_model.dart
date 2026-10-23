import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';

part 'time_track_model.freezed.dart';

@freezed
abstract class TimeTrackModel with _$TimeTrackModel {
  const TimeTrackModel._();

  const factory TimeTrackModel({
    int? id,
    required int idEmployee,
    DateTime? startTime,
    DateTime? finishTime,
    DateTime? registeredDate,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  }) = _TimeTrackModel;

  factory TimeTrackModel.fromJson(Map<String, dynamic> map) {
    final startTime = map['start_time'] as String?;
    final finishTime = map['finish_time'] as String?;
    final registeredDate = map['registered_date'] as String?;

    return TimeTrackModel(
      id: map['id'],
      idEmployee: map['id_employee'],
      startTime: startTime == null ? null : DateTime.tryParse(startTime),
      finishTime: finishTime == null ? null : DateTime.tryParse(finishTime),
      registeredDate: registeredDate == null ? null : DateTime.tryParse(registeredDate),
      difference: map['difference'],
      isTurnOnGoing:
          startTime != null && startTime.isNotEmpty && (finishTime == null || finishTime.isEmpty),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_employee': idEmployee,
      'start_time': startTime?.toIso8601String(),
      'finish_time': finishTime?.toIso8601String(),
      'registered_date': registeredDate?.toIso8601String(),
      'difference': difference,
    };
  }

  TimeTrackEntity toEntity() => TimeTrackEntity(
    id: id,
    idEmployee: idEmployee,
    startTime: startTime,
    finishTime: finishTime,
    registeredDate: registeredDate,
    difference: difference,
    isTurnOnGoing: isTurnOnGoing,
  );

  factory TimeTrackModel.fromEntity(TimeTrackEntity timeTrackEntity) => TimeTrackModel(
    id: timeTrackEntity.id,
    idEmployee: timeTrackEntity.idEmployee,
    startTime: timeTrackEntity.startTime,
    finishTime: timeTrackEntity.finishTime,
    registeredDate: timeTrackEntity.registeredDate,
    difference: timeTrackEntity.difference,
    isTurnOnGoing: timeTrackEntity.isTurnOnGoing,
  );
}
