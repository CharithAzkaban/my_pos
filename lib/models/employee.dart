// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  final String empNo;
  String empName;
  String empAddressLine1;
  final String empAddressLine2;
  final String empAddressLine3;
  String departmentCode;
  final DateTime dateOfJoin;
  DateTime dateOfBirth;
  final double basicSalary;
  final bool isActive;

  Employee({
    required this.empNo, 
    required this.empName,
    required this.empAddressLine1, 
    required this.empAddressLine2,
    required this.empAddressLine3, 
    required this.departmentCode, 
    required this.dateOfJoin, 
    required this.dateOfBirth,
    required this.basicSalary, 
    required this.isActive,
  });

  Employee modifiedEmployee({
    String? modEmpName,
    String? modEmpAddressLine1,
    String? modDepartmentCode,
    DateTime? modDateOfBirth,
  }){
    empName = modEmpName ?? empName;
    empAddressLine1 = modEmpAddressLine1 ?? empAddressLine1;
    departmentCode = modDepartmentCode ?? departmentCode;
    dateOfBirth = modDateOfBirth ?? dateOfBirth;
    return this;
  }

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
