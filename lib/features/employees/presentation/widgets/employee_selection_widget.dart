import 'package:flutter/material.dart';
import 'package:gestor_horas/core/injection.dart';
import 'package:gestor_horas/data/models/employee_selection_data.dart';
import 'package:gestor_horas/features/employees/presentation/viewmodels/employee_viewmodel.dart';

import '../../domain/entities/employee_entity.dart';
import '../../../../data/models/weekdays_enum.dart';

class EmployeeSelectionWidget extends StatefulWidget {
  final EmployeeSelectionData employeeSelectionData;
  final VoidCallback? onDelete;

  const EmployeeSelectionWidget({super.key, required this.employeeSelectionData, this.onDelete});

  @override
  State<EmployeeSelectionWidget> createState() => _EmployeeSelectionWidgetState();
}

class _EmployeeSelectionWidgetState extends State<EmployeeSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    final availableEmployees = locator<EmployeeViewModel>().employees;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<EmployeeEntity>(
              hint: const Text('Selecciona a un empleado'),
              isExpanded: true,
              value: widget.employeeSelectionData.selectedEmployee,
              items: availableEmployees.map((EmployeeEntity employee) {
                return DropdownMenuItem<EmployeeEntity>(value: employee, child: Text(employee.name));
              }).toList(),
              onChanged: (EmployeeEntity? employee) {
                setState(() => widget.employeeSelectionData.selectedEmployee = employee);
              },
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            child: DropdownButton<WeekdaysEnum>(
              hint: const Text('Semana asignada'),
              isExpanded: true,
              value: widget.employeeSelectionData.weekdayEnum,
              items: WeekdaysEnum.values.map((WeekdaysEnum weekday) {
                return DropdownMenuItem<WeekdaysEnum>(value: weekday, child: Text(weekday.value));
              }).toList(),
              onChanged: (WeekdaysEnum? weekday) {
                setState(() => widget.employeeSelectionData.weekdayEnum = weekday);
              },
            ),
          ),

          if (widget.onDelete != null) ...[
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Eliminar este empleado',
              onPressed: widget.onDelete,
            ),
          ],
        ],
      ),
    );
  }
}
