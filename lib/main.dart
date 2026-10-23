import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestor_horas/core/injection.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/features/schedules/presentation/viewmodels/schedule_view_model.dart';
import 'package:gestor_horas/features/time-trackings/presentation/viewmodels/time_track_viewmodel.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<EmployeeViewModel>()..loadEmployees()),
        ChangeNotifierProvider(create: (_) => locator<TimeTrackViewModel>()..getAllTimeTrackings()),
        ChangeNotifierProvider(create: (_) => locator<DateViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ScheduleViewModel>()..loadSchedules()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('es')],
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent)),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MyHomePage()),
    );
  }
}
