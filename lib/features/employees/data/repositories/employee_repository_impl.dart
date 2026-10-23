import 'package:dartz/dartz.dart';
import 'package:gestor_horas/core/error/failure.dart';
import 'package:gestor_horas/features/employees/data/datasources/employee_local_data_source.dart';
import 'package:gestor_horas/features/employees/data/models/employee_model.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';
import 'package:gestor_horas/features/employees/domain/repositories/employee_repository.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final logger = Logger();
  final EmployeeLocalDataSource localDataSource;

  EmployeeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, int>> insertEmployee(EmployeeEntity employee) async {
    try {
      int insertedEmployeeId = await localDataSource.insertEmployee(
        EmployeeModel.fromEntity(employee),
      );

      return Right(insertedEmployeeId);
    } on DatabaseException catch (exception, stackTrace) {
      String errorMessage = '';

      if (exception.getResultCode() == 5) {
        errorMessage = 'La base de datos está bloqueada';
      }

      logger.e(errorMessage, error: exception, stackTrace: stackTrace);

      return Left(DatabaseLockedFailure(errorMessage));
    } catch (exception, stackTrace) {
      logger.e('Ha ocurrido un error inesperado. ', error: exception, stackTrace: stackTrace);

      return Left(UnexpectedFailure('Ha ocurrido un error inesperado: $exception'));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployee(EmployeeEntity employee) async {
    try {
      await localDataSource.updateEmployee(EmployeeModel.fromEntity(employee));

      return Right(null);
    } catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployee(EmployeeEntity employee) async {
    try {
      await localDataSource.deleteEmployee(EmployeeModel.fromEntity(employee));

      return Right(null);
    } catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees() async {
    try {
      final List<EmployeeModel> models = await localDataSource.getEmployees();

      final List<EmployeeEntity> entities = models.map((model) => model.toEntity()).toList();

      return Right(entities);
    } catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getEmployeeById(int id) async {
    try {
      EmployeeModel model = await localDataSource.getEmployeeById(id);

      return Right(model.toEntity());
    } catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployeesByName(String name) async {
    try {
      final List<EmployeeModel> models = await localDataSource.getEmployeesByName(name);

      final List<EmployeeEntity> entities = models.map((model) => model.toEntity()).toList();

      return Right(entities);
    } catch (exception) {
      return Left(UnexpectedFailure(exception.toString()));
    }
  }
}
