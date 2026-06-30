import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/presentation/viewmodels/employees/view_employees_viewmodel.dart';
import 'package:gestor_horas/presentation/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  EmployeeRepositoryImpl employeeRepositoryImpl = EmployeeRepositoryImpl();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ViewEmployeesViewmodel(employeeRepositoryImpl),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    EmployeeRepositoryImpl repo = EmployeeRepositoryImpl();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: SafeArea(child: MyHomePage()),
    );
  }
}
