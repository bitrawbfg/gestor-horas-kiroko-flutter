import 'package:flutter/material.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final List<Text> _employees = List.of([
    Text("value1"),
    Text("value2"),
    Text("value3"),
    Text("value4"),
    Text("value5"),
    Text("value6"),
    Text("value7"),
    Text("value8"),
    Text("value1"),
    Text("value2"),
    Text("value3"),
    Text("value4"),
    Text("value5"),
    Text("value6"),
    Text("value7"),
    Text("value8"),
  ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              Row(
                spacing: 20,
                children: [
                  SearchBar(
                    leading: Icon(Icons.search),
                    hintText: 'Buscar empleados...',
                  ),
                  DropdownButton(
                    hint: Text('Selecciona un rol'),
                    items: [],
                    onChanged: null,
                  ),
                ],
              ),
            ],
          ),
        ),
        _employees.isEmpty
            ? Expanded(
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Añade un nuevo empleado'),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all<Size>(Size(200, 60)),
                      ),
                      child: Text('Añadir'),
                    ),
                  ],
                ),
              )
            : Expanded(
              child: ListView.builder(
                  itemCount: _employees.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text("A")),
                        title: _employees[index],
                        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      ),
                    );
                  },
                ),
            ),
      ],
    );
  }
}
