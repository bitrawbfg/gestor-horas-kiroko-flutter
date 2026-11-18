import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_horas/core/database/database_memory.dart';
import 'package:gestor_horas/core/error/exceptions.dart';
import 'package:gestor_horas/features/time-trackings/data/datasources/time_tracking_local_data_source.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  late DatabaseMemory databaseMemory;
  late TimeTrackingLocalDataSource dataSource;

  setUp(() async {
    databaseMemory = DatabaseMemory();
    await databaseMemory.database;
    dataSource = TimeTrackingLocalDataSource(databaseProvider: databaseMemory);
  });

  group('Open Trackings', () {
    test('gets all the open time trackings registered', () async {
      List<TimeTrackModel> timeTrackings = await dataSource.getOpenTrackings();

      expect(timeTrackings.length, 3);
      expect(timeTrackings.every((timeTrack) => timeTrack.finishTime == null), isTrue);
    });

    test('gets an open time track for the employee with ID 2', () async {
      TimeTrackModel timeTrack = await dataSource.getOpenTracking(2);

      expect(timeTrack.id, 29);
      expect(timeTrack.finishTime, isNull);
    });

    test('throw ObjectNotFoundByIdException getting a non existent open track', () async {
      int employeeId = 1;

      expect(
        () async => await dataSource.getOpenTracking(employeeId),
        throwsA(isA<ObjectNotFoundByIdException>()),
      );
    });

    test('throw UnexpectedOpenTimeTrackValueException getting more than 1 open track', () async {
      int employeeId = 3;

      expect(
        () async => await dataSource.getOpenTracking(employeeId),
        throwsA(isA<UnexpectedOpenTimeTrackValueException>()),
      );
    });
  });

  group('Trackings By Date', () {
    test('Get all trackings from range dates', () async {
      DateTime startDate = DateTime(2026, 11, 3);
      DateTime endDate = DateTime(2026, 11, 9);

      List<TimeTrackModel> timeTrackings = await dataSource.getTimeTrackingsByDateRange(
        startDate,
        endDate,
      );

      List<TimeTrackModel> timeTrackingsContainsStartDate = checkIsDatePresentInList(
        timeTrackings,
        startDate,
      );
      List<TimeTrackModel> timeTrackingsContainsEndDate = checkIsDatePresentInList(
        timeTrackings,
        endDate,
      );
      List<TimeTrackModel> timeTrackingsNotContainsStartDate = checkIsDatePresentInList(
        timeTrackings,
        DateUtils.addDaysToDate(startDate, -1),
      );
      List<TimeTrackModel> timeTrackingsNotContainsEndDate = checkIsDatePresentInList(
        timeTrackings,
        DateUtils.addDaysToDate(endDate, 1),
      );

      expect(timeTrackings.length, 16);
      expect(timeTrackingsContainsStartDate, isNotEmpty);
      expect(timeTrackingsContainsEndDate, isNotEmpty);
      expect(timeTrackingsNotContainsStartDate, isEmpty);
      expect(timeTrackingsNotContainsEndDate, isEmpty);
    });

    test('Not found trackings from range dates', () async {
      DateTime startDate = DateTime(2026, 10, 1);
      DateTime endDate = DateTime(2026, 10, 9);

      List<TimeTrackModel> timeTrackings = await dataSource.getTimeTrackingsByDateRange(
        startDate,
        endDate,
      );

      expect(timeTrackings.length, 0);
    });
  });

  group('Insert Time Track', () {
    test('Insert new time track', () async {
      TimeTrackEntity timeTrackToInsert = TimeTrackEntity(
        startTime: DateTime.now(),
        finishTime: DateTime.now(),
        idEmployee: 1,
      );

      int id = await dataSource.insertTimeTrack(timeTrackToInsert);

      expect(id, greaterThan(0));
    });

    test('Insert time track with duplicated ID', () async {
      TimeTrackEntity timeTrack = TimeTrackEntity(id: 1, idEmployee: 1, startTime: DateTime.now());

      expect(
        () async => await dataSource.insertTimeTrack(timeTrack),
        throwsA(isA<DatabaseException>()),
      );
    });
  });

  group('Update Time Track', () {
    test('Update time track with employee ID 2', () async {
      TimeTrackModel timeTrack = await dataSource.getOpenTracking(2);

      await dataSource.updateTimeTrack(timeTrack.toEntity().copyWith(idEmployee: 1));

      TimeTrackModel updatedTimeTrack = await dataSource.getOpenTracking(1);

      expect(updatedTimeTrack.idEmployee, 1);
      expect(updatedTimeTrack.id, timeTrack.id);
    });

    test('Update time track with invalid ID', () async {
      TimeTrackEntity timeTrack = TimeTrackEntity(id: 50, idEmployee: 1, startTime: DateTime.now());

      expect(
        () async => await dataSource.updateTimeTrack(timeTrack),
        throwsA(isA<NoObjectsModifiedException>()),
      );
    });
  });

  group('Delete Time Track', () {
    test('Delete time track with employee ID 2', () async {
      int employeeId = 2;

      TimeTrackModel timeTrack = await dataSource.getOpenTracking(employeeId);

      await dataSource.deleteTimeTrack(timeTrack.toEntity());

      expect(
        () async => await dataSource.getOpenTracking(employeeId),
        throwsA(isA<ObjectNotFoundByIdException>()),
      );
    });

    test('Delete time track with invalid ID', () async {
      TimeTrackEntity timeTrack = TimeTrackEntity(id: 50, idEmployee: 1, startTime: DateTime.now());

      expect(
        () async => await dataSource.deleteTimeTrack(timeTrack),
        throwsA(isA<NoObjectsModifiedException>()),
      );
    });
  });

  group('Stop Time Track', () {
    test('Update and insert a separated timeTrack', () async {
      TimeTrackModel openTimeTrack = await dataSource.getOpenTracking(2);
      DateTime finishFirstTime = DateUtils.addDaysToDate(
        DateUtils.dateOnly(openTimeTrack.startTime),
        1,
      );
      DateTime finishSecondTime = finishFirstTime.copyWith(hour: 01, minute: 00, second: 00);

      TimeTrackModel firstTimeTrack = openTimeTrack.copyWith(finishTime: finishFirstTime);
      TimeTrackModel secondTimeTrack = TimeTrackModel(
        idEmployee: openTimeTrack.idEmployee,
        startTime: finishFirstTime,
        finishTime: finishSecondTime,
      );

      int insertedId = await dataSource.stopTimeTrack(
        firstTimeTrack.toEntity(),
        secondTimeTrack.toEntity(),
      );

      expect(insertedId, greaterThan(0));
      expect(
        () async => await dataSource.getOpenTracking(2),
        throwsA(isA<ObjectNotFoundByIdException>()),
      );
    });

    test('Stopping a time track without id', () async {
      TimeTrackEntity firstTimeTrack = TimeTrackEntity(idEmployee: 1, startTime: DateTime.now());
      TimeTrackEntity secondTimeTrack = TimeTrackEntity(idEmployee: 1, startTime: DateTime.now());

      expect(
        () async => await dataSource.stopTimeTrack(firstTimeTrack, secondTimeTrack),
        throwsA(isA<ObjectNotFoundByIdException>()),
      );
    });

    test('Stop a time track with a different employeeId', () async {
      TimeTrackModel openTimeTrack = await dataSource.getOpenTracking(2);
      TimeTrackEntity timeTrack = openTimeTrack.toEntity().copyWith(idEmployee: 0);

      expect(
        () async => await dataSource.stopTimeTrack(timeTrack, timeTrack),
        throwsA(isA<NoObjectsModifiedException>()),
      );

      TimeTrackModel noChangesTimeTrack = await dataSource.getOpenTracking(2);
      expect(noChangesTimeTrack.finishTime, isNull);
      expect(noChangesTimeTrack.id, openTimeTrack.id);
    });

    test('Stop a time track with an invalid second time track', () async {
      TimeTrackModel openTimeTrack = await dataSource.getOpenTracking(2);
      DateTime finishFirstTime = DateUtils.addDaysToDate(
        DateUtils.dateOnly(openTimeTrack.startTime),
        1,
      );
      DateTime finishSecondTime = finishFirstTime.copyWith(hour: 01, minute: 00, second: 00);

      TimeTrackModel firstTimeTrack = openTimeTrack.copyWith(finishTime: finishFirstTime);
      TimeTrackModel secondTimeTrack = TimeTrackModel(
        id: openTimeTrack.id,
        idEmployee: openTimeTrack.idEmployee,
        startTime: finishFirstTime,
        finishTime: finishSecondTime,
      );

      expect(
        () async =>
            await dataSource.stopTimeTrack(firstTimeTrack.toEntity(), secondTimeTrack.toEntity()),
        throwsA(isA<DatabaseException>()),
      );

      TimeTrackModel noChangesTimeTrack = await dataSource.getOpenTracking(2);
      expect(noChangesTimeTrack.finishTime, isNull);
      expect(noChangesTimeTrack.id, openTimeTrack.id);
    });
  });

  tearDown(() async {
    await databaseMemory.closeDatabase();
  });
}

List<TimeTrackModel> checkIsDatePresentInList(
  List<TimeTrackModel> timeTrackings,
  DateTime endDate,
) {
  return timeTrackings
      .where((timeTrack) => DateUtils.isSameDay(timeTrack.startTime, endDate))
      .toList();
}
