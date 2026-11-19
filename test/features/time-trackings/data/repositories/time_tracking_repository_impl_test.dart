import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_horas/features/time-trackings/data/datasources/time_tracking_local_data_source.dart';
import 'package:gestor_horas/features/time-trackings/data/repositories/time_tracking_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockTimeTrackingLocalDataSource extends Mock implements TimeTrackingLocalDataSource {}

void main() {
  late MockTimeTrackingLocalDataSource mockDataSource;
  late TimeTrackingRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockTimeTrackingLocalDataSource();
    repository = TimeTrackingRepositoryImpl(localDataSource: mockDataSource);
  });
}
