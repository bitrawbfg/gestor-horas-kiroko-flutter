import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_horas/core/database/database_memory.dart';
import 'package:gestor_horas/core/error/exceptions.dart';
import 'package:gestor_horas/features/time-trackings/data/datasources/time_tracking_local_data_source.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DatabaseMemory databaseMemory;
  late TimeTrackingLocalDataSource dataSource;

  setUp(() {
    databaseMemory = DatabaseMemory();
    dataSource = TimeTrackingLocalDataSource(databaseProvider: databaseMemory);
  });

  group('Open Trackings', () {
    test('gets all the open time trackings registered', () async {
      List<TimeTrackModel> timeTrackings = await dataSource.getOpenTrackings();

      expect(timeTrackings.length, 3);
    });

    test('gets an open time track for the employee with ID 2', () async {
      TimeTrackModel timeTrack = await dataSource.getOpenTracking(2);

      expect(timeTrack.id, 29);
    });

    test('throw ObjectNotFoundByIdException getting a non existent open track', () async {
      int employeeId = 1;

      expect(
        () async => await dataSource.getOpenTracking(employeeId),
        throwsA(
          isA<ObjectNotFoundByIdException>().having(
            (exception) => exception.message,
            'message',
            contains('id $employeeId'),
          ),
        ),
      );
    });

    test('throw UnexpectedOpenTimeTrackValueException getting more than 1 open track', () async {
      int employeeId = 3;

      expect(
        () async => await dataSource.getOpenTracking(employeeId),
        throwsA(
          isA<UnexpectedOpenTimeTrackValueException>().having(
            (exception) => exception.message,
            'message',
            contains('id $employeeId tiene más de una jornada abierta.'),
          ),
        ),
      );
    });
  });

  group('Trackings By Date', () {
    test('Get all trackings from range dates', () async {
      DateTime startDate = DateTime(2026, 11, 2);
      DateTime endDate = DateTime(2026, 11, 9);

      List<TimeTrackModel> timeTrackings = await dataSource.getTimeTrackingsByDateRange(
        startDate,
        endDate,
      );

      expect(timeTrackings.length, 20);
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

  test('Insert new time track', () async {
    TimeTrackEntity timeTrackToInsert = TimeTrackEntity(
      startTime: DateTime.now(),
      finishTime: DateTime.now(),
      idEmployee: 1,
    );

    int id = await dataSource.insertTimeTrack(timeTrackToInsert);

    expect(id, 32);
  });

  group('Update Time Track', () {
    test('Update time track with employee ID 2', () async {
      TimeTrackModel timeTrack = await dataSource.getOpenTracking(2);

      dataSource.updateTimeTrack(timeTrack.toEntity().copyWith(idEmployee: 1));

      TimeTrackModel updatedTimeTrack = await dataSource.getOpenTracking(1);

      expect(updatedTimeTrack.idEmployee, 1);
    });

    test('Update time track with invalid ID', () async {
      TimeTrackEntity timeTrack = TimeTrackEntity(id: 50, idEmployee: 1, startTime: DateTime.now());

      expect(
        () async => await dataSource.updateTimeTrack(timeTrack),
        throwsA(
          isA<NoObjectsModifiedException>().having(
            (exception) => exception.message,
            'message',
            contains('El registro de tiempo no se ha podido modificar.'),
          ),
        ),
      );
    });
  });

  group('Delete Time Track', () {
    test('Delete time track with employee ID 2', () async {
      int employeeId = 2;

      TimeTrackModel timeTrack = await dataSource.getOpenTracking(employeeId);

      dataSource.deleteTimeTrack(timeTrack.toEntity());

      expect(
        () async => await dataSource.getOpenTracking(2),
        throwsA(
          isA<ObjectNotFoundByIdException>().having(
            (exception) => exception.message,
            'message',
            contains('id $employeeId'),
          ),
        ),
      );
    });
  });

  test('Delete time track with invalid ID', () async {
    TimeTrackEntity timeTrack = TimeTrackEntity(id: 50, idEmployee: 1, startTime: DateTime.now());

    expect(
      () async => await dataSource.deleteTimeTrack(timeTrack),
      throwsA(
        isA<NoObjectsModifiedException>().having(
          (exception) => exception.message,
          'message',
          contains('El registro de tiempo no se ha podido eliminar.'),
        ),
      ),
    );
  });

  tearDown(() {
    databaseMemory.closeDatabase();
  });
}
