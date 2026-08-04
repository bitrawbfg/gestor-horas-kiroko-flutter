import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:side_panel/side_panel.dart';

import '../presentation/view_models/side_panel_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DateViewModel>(() => DateViewModel());
  locator.registerLazySingleton<EmployeeViewModel>(() => EmployeeViewModel());
  locator.registerLazySingleton<SidePanelViewModel>(() => SidePanelViewModel(locator<TimeTrackViewmodel>()));
  locator.registerLazySingleton<SidePanelController>(() => SidePanelController());

  locator.registerLazySingleton<TimeTrackViewmodel>(
    () => TimeTrackViewmodel(locator<DateViewModel>()),
  );
}
