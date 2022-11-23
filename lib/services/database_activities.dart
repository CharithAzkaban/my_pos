import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_pos/common/consts.dart';
import 'package:my_pos/common/methods.dart';
import 'package:my_pos/models/department.dart';
import 'package:my_pos/models/employee.dart';
import 'package:my_pos/providers/employee_provider.dart';
import 'package:provider/provider.dart';

// Add an employee
Future<void> addEmployee(BuildContext context, {required Employee employee}) async {
  final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
  try {
    final response = await Dio().post('$baseUrl/api/v1.0/Employee', 
      data: employee.toJson(),
      options: Options(
        headers: {
          'apiToken': apiKey,
        }
      ),
    );
    if(response.statusCode == 200){
      employeeProvider.addEmployee(employee);
      employeeProvider.setEmpBirthday(DateTime.now());
      toast('An employee added successfully', toastState: TS.success);
    }
  } 
  on Exception catch (e) {
    toast('Something went wrong', toastState: TS.error);
    debugPrint(e.toString());
  }
}

// Delete an existing employee
Future<void> deleteEmployee(BuildContext context, {required String empNo}) async {
  final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
  try {
    final response = await Dio().delete('$baseUrl/api/v1.0/Employee/$empNo',
      options: Options(
        headers: {
          'apiToken': apiKey,
        }
      ),
    );
    if(response.statusCode == 200){
      employeeProvider.deleteEmployee(empNo);
      toast('An employee deleted successfully', toastState: TS.success);
    }
  } 
  on Exception catch (e) {
    toast('Something went wrong', toastState: TS.error);
    debugPrint(e.toString());
  }
}

// Modify an existing employee
Future<void> editEmployee(BuildContext context, {required Employee modifiedEmployee}) async {
  final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
  try {
    final response = await Dio().put('$baseUrl/api/v1.0/Employee',
      data: modifiedEmployee.toJson(),
      options: Options(
        headers: {
          'apiToken': apiKey,
        }
      ),
    );
    if(response.statusCode == 200){
      employeeProvider.editEmployee(modifiedEmployee);
      employeeProvider.setEmpBirthday(DateTime.now());
      toast('An employee modified successfully', toastState: TS.success);
    }
  } 
  on Exception catch (e) {
    toast('Something went wrong', toastState: TS.error);
    debugPrint(e.toString());
  }
}

// Retrieve all departments records
Future<List<Department>> getDepartments() async {
  try {
    final response = await Dio().get('$baseUrl/api/v1.0/Departments', 
      options: Options(
        headers: {
          'apiToken': apiKey,
        }
      ),
    );
    if(response.statusCode == 200){
      List dataList = response.data;
      return dataList.map((data) => Department.fromJson(data)).toList();
    }
    return [];
  } 
  on Exception catch (e) {
    toast('Something went wrong', toastState: TS.error);
    debugPrint(e.toString());
    return [];
  }
}

// Retrieve all employee records
Future<List<Employee>> getEmployees() async {
  try {
    final response = await Dio().get('$baseUrl/api/v1.0/Employees', 
      options: Options(
        headers: {
          'apiToken': apiKey,
        }
      ),
    );
    if(response.statusCode == 200){
      List dataList = response.data;
      return dataList.map((data) => Employee.fromJson(data)).toList();
    }
    return [];
  } 
  on Exception catch (e) {
    debugPrint(e.toString());
    return [];
  }
}
