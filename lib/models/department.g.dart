// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      departmentCode: json['departmentCode'] as String,
      departmentName: json['departmentName'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'departmentCode': instance.departmentCode,
      'departmentName': instance.departmentName,
      'isActive': instance.isActive,
    };
