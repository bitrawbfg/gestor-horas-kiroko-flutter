import 'package:dartz/dartz.dart';
import 'package:gestor_horas/core/error/exceptions.dart';
import 'package:gestor_horas/core/error/failure.dart';
import 'package:gestor_horas/features/time-trackings/data/datasources/time_tracking_local_data_source.dart';
import 'package:gestor_horas/features/time-trackings/data/models/time_track_model.dart';
import 'package:gestor_horas/features/time-trackings/domain/entities/time_track_entity.dart';
import 'package:gestor_horas/features/time-trackings/domain/repositories/time_tracking_repository.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class TimeTrackingRepositoryImpl implements TimeTrackingRepository {
  final logger = Logger();
  final TimeTrackingLocalDataSource localDataSource;

  TimeTrackingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> startTracking(int employeeId) async {
    try {
      TimeTrackEntity startTimeTrack = TimeTrackEntity(
        idEmployee: employeeId,
        startTime: DateTime.now(),
      );

      await localDataSource.insertTimeTrack(startTimeTrack);

      return Right(null);
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, void>> stopTracking(int employeeId) async {
    try {
      TimeTrackModel openTimeTrack = await localDataSource.getOpenTracking(employeeId);

      await localDataSource.updateTimeTrack(
        openTimeTrack.toEntity().copyWith(finishTime: DateTime.now()),
      );

      return Right(null);
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } on UnexpectedOpenTimeTrackValueException catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        exception.message,
        exception,
        stackTrace,
        failure: (message) => UnexpectedOpenTimeTrackValueFailure(message),
      );
    } on ObjectNotFoundByIdException catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        exception.message,
        exception,
        stackTrace,
        failure: (message) => NoObjectsFoundFailure(message),
      );
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, int>> insertTimeTrack(TimeTrackEntity timeTrack) async {
    try {
      int insertedTimeTrackId = await localDataSource.insertTimeTrack(timeTrack);

      return Right(insertedTimeTrackId);
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateTimeTrack(TimeTrackEntity timeTrack) async {
    try {
      await localDataSource.updateTimeTrack(timeTrack);

      return Right(null);
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } on NoObjectsModifiedException catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        exception.message,
        exception,
        stackTrace,
        failure: (message) => NoObjectsModifiedFailure(message),
      );
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteTimeTrack(TimeTrackEntity timeTrack) async {
    try {
      await localDataSource.updateTimeTrack(timeTrack);

      return Right(null);
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } on NoObjectsModifiedException catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        exception.message,
        exception,
        stackTrace,
        failure: (message) => NoObjectsModifiedFailure(message),
      );
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, List<TimeTrackEntity>>> getTimeTrackingsByDateRange(
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
      List<TimeTrackModel> timeTrackResult = await localDataSource.getTimeTrackingsByDateRange(
        startAt,
        endAt,
      );

      return Right(timeTrackResult.map((timeTrack) => timeTrack.toEntity()).toList());
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, List<TimeTrackEntity>>> getOpenTrackings() async {
    try {
      List<TimeTrackModel> timeTrackResult = await localDataSource.getOpenTrackings();

      return Right(timeTrackResult.map((timeTrack) => timeTrack.toEntity()).toList());
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  @override
  Future<Either<Failure, TimeTrackEntity>> getOpenTracking(int employeeId) async {
    try {
      TimeTrackModel timeTrackResult = await localDataSource.getOpenTracking(employeeId);

      return Right(timeTrackResult.toEntity());
    } on ObjectNotFoundByIdException catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        exception.message,
        exception,
        stackTrace,
        failure: (message) => NoObjectsFoundFailure(message),
      );
    } on UnexpectedOpenTimeTrackValueException catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        exception.message,
        exception,
        stackTrace,
        failure: (message) => UnexpectedOpenTimeTrackValueFailure(message),
      );
    } on DatabaseException catch (exception, stackTrace) {
      return handleDatabaseException(exception, stackTrace);
    } catch (exception, stackTrace) {
      return handleExceptionWithMessage(
        'Ha ocurrido un error inesperado',
        exception,
        stackTrace,
        failure: (message) => UnexpectedFailure(message),
      );
    }
  }

  //#region Exception Handling
  Left<Failure, T> handleExceptionWithMessage<T>(
    String message,
    Object exception,
    StackTrace stackTrace, {
    required Failure Function(String message) failure,
  }) {
    logger.e(message, error: exception, stackTrace: stackTrace);

    return Left<Failure, T>(failure('$message: $exception'));
  }

  Left<Failure, T> handleDatabaseException<T>(DatabaseException exception, StackTrace stackTrace) {
    String errorMessage = '';

    if (exception.getResultCode() == 5) {
      errorMessage = 'La base de datos está bloqueada';
    }

    logger.e(errorMessage, error: exception, stackTrace: stackTrace);

    return Left<Failure, T>(DatabaseLockedFailure(errorMessage));
  }
  //#endregion
}
