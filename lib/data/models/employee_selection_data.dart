import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';
import 'package:gestor_horas/data/models/weekdays_enum.dart';

class EmployeeSelectionData {
  EmployeeEntity? selectedEmployee;
  WeekdaysEnum? weekdayEnum;

  EmployeeSelectionData({
    this.selectedEmployee,
    this.weekdayEnum,
  });
}
