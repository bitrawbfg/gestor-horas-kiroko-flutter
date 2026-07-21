import 'package:gestor_horas/presentation/viewmodels/employee_time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:gestor_horas/presentation/viewmodels/date_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DateViewModel>(() => DateViewModel());
  locator.registerLazySingleton<EmployeeViewModel>(() => EmployeeViewModel());

  locator.registerLazySingleton<EmployeeTimeTrackViewmodel>(
    () => EmployeeTimeTrackViewmodel(locator<DateViewModel>()),
  );
}
