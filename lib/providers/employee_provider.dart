import 'package:flutter/material.dart';
import 'package:my_pos/models/employee.dart';
import 'package:my_pos/services/database_activities.dart';

class EmployeeProvider extends ChangeNotifier{
  DateTime _empBirthday = DateTime.now();
  List<Employee> _employeeList = [];
  final List<Employee> _filteredEmployeeList = [];

  DateTime get empBirthday => _empBirthday;
  List<Employee> get employeeList => _employeeList;
  List<Employee> get filteredEmployeeList => _filteredEmployeeList;

  addEmployee(Employee employee){
    _employeeList.add(employee);
    notifyListeners();
  }

  deleteEmployee(String empNo){
    _employeeList.removeWhere((emp) => emp.empNo == empNo);
    notifyListeners();
  }

  editEmployee(Employee modifiedEmployee){
    int position = _employeeList.indexWhere((employee) => employee.empNo == modifiedEmployee.empNo);
    _employeeList[position] = modifiedEmployee;
    notifyListeners();
  }

  Future<void> loadEmployees(String text) async{
    _employeeList.clear();
    await getEmployees().then((employees) {
      _employeeList = employees.where((employee) => employee.empName.toLowerCase().contains(text.toLowerCase())).toList();
    }).then((_) => notifyListeners());
  }

  setEmpBirthday(DateTime birthday){
    _empBirthday = birthday;
    notifyListeners();
  }
}