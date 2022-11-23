// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      empNo: json['empNo'] as String,
      empName: json['empName'] as String,
      empAddressLine1: json['empAddressLine1'] as String,
      empAddressLine2: json['empAddressLine2'] as String,
      empAddressLine3: json['empAddressLine3'] as String,
      departmentCode: json['departmentCode'] as String,
      dateOfJoin: DateTime.parse(json['dateOfJoin'] as String),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      basicSalary: (json['basicSalary'] as num).toDouble(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'empNo': instance.empNo,
      'empName': instance.empName,
      'empAddressLine1': instance.empAddressLine1,
      'empAddressLine2': instance.empAddressLine2,
      'empAddressLine3': instance.empAddressLine3,
      'departmentCode': instance.departmentCode,
      'dateOfJoin': instance.dateOfJoin.toIso8601String(),
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'basicSalary': instance.basicSalary,
      'isActive': instance.isActive,
    };
