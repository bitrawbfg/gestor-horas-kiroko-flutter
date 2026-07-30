import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/presentation/viewmodels/date_view_model.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/viewmodels/side_panel_view_model.dart';
import 'package:gestor_horas/presentation/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<EmployeeViewModel>()..loadEmployees()),
        ChangeNotifierProvider(
          create: (_) => locator<EmployeeTimeTrackViewmodel>()..loadTimeTrackings(),
        ),
        ChangeNotifierProvider(create: (_) => locator<DateViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<SidePanelViewModel>()),
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
