import 'package:gestor_horas/core/database/database_helper.dart';
import 'package:gestor_horas/features/employees/data/datasources/employee_local_data_source.dart';
import 'package:gestor_horas/features/employees/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/features/time-trackings/data/repositories/time_tracking_repository_impl.dart';
import 'package:gestor_horas/features/employees/domain/repositories/employee_repository.dart';
import 'package:gestor_horas/features/time-trackings/domain/repositories/time_tracking_repository.dart';
import 'package:gestor_horas/features/schedules/presentation/viewmodels/schedule_view_model.dart';
import 'package:gestor_horas/features/time-trackings/presentation/viewmodels/time_track_viewmodel.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:side_panel/side_panel.dart';

final locator = GetIt.instance;

void setupLocator() {
  TimeTrackingRepository timeTrackingRepository = TimeTrackingRepositoryImpl();
  EmployeeRepository employeeRepository = EmployeeRepositoryImpl(
    localDataSource: EmployeeLocalDataSource(databaseHelper: DatabaseHelper()),
  );

  locator.registerLazySingleton<DateViewModel>(() => DateViewModel());
  locator.registerLazySingleton<EmployeeViewModel>(
    () => EmployeeViewModel(
      employeesRepository: employeeRepository,
      timeTrackRepository: timeTrackingRepository,
    ),
  );
  locator.registerLazySingleton<SidePanelController>(() => SidePanelController());
  locator.registerLazySingleton<ScheduleViewModel>(() => ScheduleViewModel());
  locator.registerLazySingleton<TimeTrackViewModel>(
    () => TimeTrackViewModel(timeTrackingRepository),
  );
}
