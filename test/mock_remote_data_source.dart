import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/features/employees/data/datasources/employee_local_data_source.dart';
import 'package:gestor_horas/features/employees/data/models/employee_model.dart';
import 'package:gestor_horas/features/employees/data/repositories/employee_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock implements EmployeeLocalDataSource {}

void main() {
  late EmployeeRepositoryImpl repository;
  late MockLocalDataSource mockLocal;

  setUp(() {
    mockLocal = MockLocalDataSource();

    repository = EmployeeRepositoryImpl(localDataSource: mockLocal);
  });

  test('should return id of inserted employee', () async {
    final model = const EmployeeModel(id: 1, name: 'Employee', hasContract: true, hoursInContract: 40);

    when(() => mockLocal.getEmployeeById(any())).thenAnswer((_) async => model);

    final result = await repository.getEmployeeById(1);

    expect(result.isRight(), true);
    verify(() => mockLocal.getEmployeeById(1)).called(1);
  });
}
