import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gestor_horas/features/employees/domain/entities/employee_entity.dart';

part 'employee_model.freezed.dart';

@freezed
abstract class EmployeeModel with _$EmployeeModel {
  const EmployeeModel._();

  const factory EmployeeModel({
    int? id,
    required String name,
    required bool hasContract,
    required int hoursInContract,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id_employee'] ?? map['id'],
      name: map['name'],
      hasContract: map['has_contract'] == 1 ? true : false,
      hoursInContract: map['hours_in_contract'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'has_contract': hoursInContract > 0 ? 1 : 0,
      'hours_in_contract': hoursInContract,
    };
  }

  EmployeeEntity toEntity() => EmployeeEntity(
    id: id,
    name: name,
    hasContract: hasContract,
    hoursInContract: hoursInContract,
  );

  factory EmployeeModel.fromEntity(EmployeeEntity employeeEntity) => EmployeeModel(
    id: employeeEntity.id,
    name: employeeEntity.name,
    hasContract: employeeEntity.hasContract,
    hoursInContract: employeeEntity.hoursInContract,
  );
}
