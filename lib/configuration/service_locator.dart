import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/data/repositories/time_tracking_repository_impl.dart';
import 'package:gestor_horas/domain/repositories/employee_repository.dart';
import 'package:gestor_horas/domain/repositories/time_tracking_repository.dart';
import 'package:gestor_horas/presentation/view_models/schedule_view_model.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:side_panel/side_panel.dart';

import '../presentation/view_models/side_panel_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  TimeTrackingRepository timeTrackingRepository = TimeTrackingRepositoryImpl();
  EmployeeRepository employeeRepository = EmployeeRepositoryImpl();

  locator.registerLazySingleton<DateViewModel>(() => DateViewModel());
  locator.registerLazySingleton<EmployeeViewModel>(() => EmployeeViewModel());
  locator.registerLazySingleton<SidePanelViewModel>(() => SidePanelViewModel());
  locator.registerLazySingleton<SidePanelController>(() => SidePanelController());
  locator.registerLazySingleton<ScheduleViewModel>(() => ScheduleViewModel());
  locator.registerLazySingleton<TimeTrackViewModel>(() => TimeTrackViewModel(timeTrackingRepository, employeeRepository));
}
