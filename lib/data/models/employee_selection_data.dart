import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/models/weekdays_enum.dart';

class EmployeeSelectionData {
  EmployeeModel? selectedEmployee;
  WeekdaysEnum? weekdayEnum;

  EmployeeSelectionData({
    this.selectedEmployee,
    this.weekdayEnum,
  });
}
