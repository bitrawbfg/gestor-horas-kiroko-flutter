import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_time_track_viewmodel.dart';
import 'package:gestor_horas/presentation/viewmodels/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  DateTime startOfWeek = DateTime.now().subtract(
    Duration(days: DateTime.now().weekday - 1),
  );

  List<DateTime> weekDates = List.generate(7, (index) {
    return startOfWeek.add(Duration(days: index));
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeViewModel()..loadEmployees(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeTimeTrackViewmodel()
            ..loadTimeTrackings(
              startDay: weekDates[0],
              finishDay: weekDates[6],
            ),
        ),
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MyHomePage()),
    );
  }
}
