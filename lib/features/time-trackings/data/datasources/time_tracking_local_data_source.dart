import 'package:gestor_horas/core/database/database_provider.dart';
import 'package:gestor_horas/core/error/exceptions.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';
import 'package:intl/intl.dart';

class TimeTrackingLocalDataSource {
  static const String timeTrackTableName = 'time_trackings';
  final DatabaseProvider _databaseProvider;

  TimeTrackingLocalDataSource({required this._databaseProvider});

  Future<List<TimeTrackModel>> getTimeTrackingsByDateRange(DateTime startAt, DateTime endAt) async {
    final database = await _databaseProvider.database;

    final List<Map<String, dynamic>> queryResults = await database.query(
      timeTrackTableName,
      where: 'date(start_time) >= ? AND date(start_time) <= ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(startAt), DateFormat('yyyy-MM-dd').format(endAt)],
    );

    return queryResults.map((timeTrack) => TimeTrackModel.fromJson(timeTrack)).toList();
  }

  Future<List<TimeTrackModel>> getOpenTrackings() async {
    final database = await _databaseProvider.database;

    final List<Map<String, dynamic>> queryResults = await database.query(
      timeTrackTableName,
      where: 'finish_time ISNULL',
    );

    return queryResults.map((timeTrack) => TimeTrackModel.fromJson(timeTrack)).toList();
  }

  Future<TimeTrackModel> getOpenTracking(int employeeId) async {
    final database = await _databaseProvider.database;

    final List<Map<String, dynamic>> queryResults = await database.query(
      timeTrackTableName,
      where: 'id_employee = ? AND finish_time ISNULL',
      whereArgs: [employeeId],
    );

    if (queryResults.isEmpty) {
      throw ObjectNotFoundByIdException(
        'No se ha encontrado un registro de tiempo abierto para el empleado con id $employeeId',
      );
    }

    if (queryResults.length > 1) {
      throw UnexpectedOpenTimeTrackValueException(
        'El empleado con id $employeeId tiene más de una jornada abierta.',
      );
    }

    return TimeTrackModel.fromJson(queryResults.single);
  }

  Future<int> stopTimeTrack(TimeTrackEntity firstTimeTrack, TimeTrackEntity secondTimeTrack) async {
    final database = await _databaseProvider.database;

    return await database.transaction((transaction) async {
      if (firstTimeTrack.id == null) {
        throw ObjectNotFoundByIdException('El registro de tiempo no existe');
      }

      int changesMade = await transaction.update(
        timeTrackTableName,
        TimeTrackModel.fromEntity(firstTimeTrack).toJson(),
        where: 'id = ? AND id_employee = ?',
        whereArgs: [firstTimeTrack.id, firstTimeTrack.idEmployee],
      );

      if (changesMade != 1) {
        throw NoObjectsModifiedException('El registro de tiempo no se ha podido modificar.');
      }

      return await transaction.insert(
        timeTrackTableName,
        TimeTrackModel.fromEntity(secondTimeTrack).toJson(),
      );
    });
  }

  Future<int> insertTimeTrack(TimeTrackEntity timeTrack) async {
    final database = await _databaseProvider.database;

    return await database.transaction(
      (transaction) =>
          transaction.insert(timeTrackTableName, TimeTrackModel.fromEntity(timeTrack).toJson()),
    );
  }

  Future<void> updateTimeTrack(TimeTrackEntity timeTrack) async {
    final database = await _databaseProvider.database;

    int changesMade = await database.transaction(
      (transaction) => transaction.update(
        timeTrackTableName,
        TimeTrackModel.fromEntity(timeTrack).toJson(),
        where: 'id = ?',
        whereArgs: [timeTrack.id],
      ),
    );

    if (changesMade != 1) {
      throw NoObjectsModifiedException('El registro de tiempo no se ha podido modificar.');
    }
  }

  Future<void> deleteTimeTrack(TimeTrackEntity timeTrack) async {
    final database = await _databaseProvider.database;

    int changesMade = await database.transaction(
      (transaction) =>
          transaction.delete(timeTrackTableName, where: 'id = ?', whereArgs: [timeTrack.id]),
    );

    if (changesMade != 1) {
      throw NoObjectsModifiedException('El registro de tiempo no se ha podido eliminar.');
    }
  }
}
