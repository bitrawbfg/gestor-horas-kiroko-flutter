import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:gestor_horas/views/employees_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const EmployeesPage(),
    const Text('Prueba 2'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: const Text('Kiroko'),
        leading: const Icon(Icons.house_rounded, size: 40),
        actions: [ElevatedButton(onPressed: () {}, child: Icon(Icons.person))],
      ),
      body: Row(
        children: [
          SideMenu(
            builder: (data) => SideMenuData(
              items: [
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {
                    _onItemTapped(0);
                  },
                  title: 'Hoja de Horas',
                  icon: const Icon(Icons.hourglass_bottom),
                ),
                SideMenuItemDataTile(
                  isSelected: false,
                  onTap: () {
                    _onItemTapped(1);
                  },
                  title: 'Empleados',
                  icon: const Icon(Icons.people),
                ),
              ],
            ),
          ),
          Expanded(child: _widgetOptions[_selectedIndex]),
        ],
      ),
    );
  }
}
