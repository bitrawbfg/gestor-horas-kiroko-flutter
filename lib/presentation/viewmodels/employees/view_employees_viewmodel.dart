import 'package:gestor_horas/data/models/employees/employee_model.dart';
import 'package:gestor_horas/data/repositories/employee_repository_impl.dart';
import 'package:gestor_horas/presentation/viewmodels/base_viewmodel.dart';

class ViewEmployeesViewmodel extends BaseViewmodel {
  final EmployeeRepositoryImpl _repository;

  ViewEmployeesViewmodel(this._repository);

  List<EmployeeModel>? _employees;
  List<EmployeeModel>? get employees => _employees;

  void getAllEmployees() async {
    setLoading(true);
    clearError();

    final request = await _repository.getEmployees();
    _employees = request;
    setLoading(false);

    notifyListeners();
  }
}