import 'package:flutter/material.dart';
import 'package:my_pos/common/methods.dart';
import 'package:my_pos/models/department.dart';
import 'package:my_pos/models/employee.dart';
import 'package:my_pos/providers/employee_provider.dart';
import 'package:my_pos/services/database_activities.dart';
import 'package:my_pos/widgets/employee_widget.dart';
import 'package:my_pos/widgets/tff.dart';
import 'package:my_pos/widgets/vgap.dart';
import 'package:provider/provider.dart';

class EditEmployeeForm extends StatelessWidget {
  final Employee employee;
  final TextEditingController empNameController;
  final TextEditingController empAddressController;
  final GlobalKey<FormState> formKey;
  const EditEmployeeForm({super.key,
    required this.employee, 
    required this.empNameController, 
    required this.empAddressController, 
    required this.formKey,}
  );

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TFF(
            controller: empNameController,
            labelText: 'Employee name',
            validator: (name){
              return (name == null || name.trim().isEmpty) ? 'Employee name required!' : null;
            },
          ),
          const VGap(10.0),
          TFF(
            controller: empAddressController,
            labelText: 'Employee address',
            validator: (address){
              return (address == null || address.trim().isEmpty) ? 'Employee address required!' : null;
            },
          ),
          const VGap(10.0),
          FutureBuilder<List<Department>>(
            future: getDepartments(),
            builder: (context, AsyncSnapshot<List<Department>> snapshot) {
              EmployeeWidget.selectedDepartment = snapshot.hasData && snapshot.data!.isNotEmpty ? snapshot.data!.firstWhere((dep) => dep.departmentCode == employee.departmentCode) : null;
              return DropdownButtonFormField<Department>(
                items: snapshot.hasData && snapshot.data!.isNotEmpty ? snapshot.data!.map((department) => DropdownMenuItem<Department>(
                  value: department,
                  child: Text(department.departmentName),
                )).toList() : null, 
                onChanged: (department){
                  EmployeeWidget.selectedDepartment = department;
                },
                validator: (dep) => dep == null ? 'Please select department' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: snapshot.connectionState == ConnectionState.waiting ? 'Loading' : (snapshot.hasData && snapshot.data!.isNotEmpty ? 'Select department' : 'No data'),
                ),
                value: snapshot.hasData && snapshot.data!.isNotEmpty ? snapshot.data!.firstWhere((dep) => dep.departmentCode == employee.departmentCode) : null,
              );
            },
          ),
          const VGap(10.0),
          TextButton(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: employee.dateOfBirth,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (date != null && date != DateTime.now()) {
                employeeProvider.setEmpBirthday(date);
              }
            }, 
            child: Consumer<EmployeeProvider>(
              builder: (context, provider, _) => Text(date(provider.empBirthday, format: 'yyyyMMdd') == date(DateTime.now(), format: 'yyyyMMdd') ? 'Choose DOB' : date(provider.empBirthday, format: 'dd MMM yyyy')),
            )
          ),
        ],
      ),
    );
  }
}