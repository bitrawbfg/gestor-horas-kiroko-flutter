import 'package:dartz/dartz.dart';
import 'package:gestor_horas/core/error/failure.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, EmployeeEntity>> getEmployeeById(int id);
  Future<Either<Failure, List<EmployeeEntity>>> getEmployeesByName(String name);
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees();

  Future<Either<Failure, int>> insertEmployee(EmployeeEntity employee);
  Future<Either<Failure, void>> updateEmployee(EmployeeEntity employee);
  Future<Either<Failure, void>> deleteEmployee(EmployeeEntity employee);
}