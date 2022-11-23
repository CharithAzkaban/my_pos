// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department {
  final String departmentCode;
  final String departmentName;
  final bool isActive;

  Department({
    required this.departmentCode, 
    required this.departmentName,
    required this.isActive,
  });

    factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

    Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
