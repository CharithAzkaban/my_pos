import 'package:flutter/material.dart';
import 'package:my_pos/common/methods.dart';
import 'package:my_pos/models/department.dart';
import 'package:my_pos/providers/employee_provider.dart';
import 'package:my_pos/screens/employee_list_screen.dart';
import 'package:my_pos/services/database_activities.dart';
import 'package:my_pos/widgets/tff.dart';
import 'package:my_pos/widgets/vgap.dart';
import 'package:provider/provider.dart';

class AddEmployeeForm extends StatefulWidget {
  final TextEditingController empNameController;
  final TextEditingController empAddressController;
  final GlobalKey<FormState> formKey;
  const AddEmployeeForm({super.key,
    required this.empNameController, 
    required this.empAddressController, 
    required this.formKey,}
  );

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TFF(
            controller: widget.empNameController,
            labelText: 'Employee name',
            validator: (name){
              return (name == null || name.trim().isEmpty) ? 'Employee name required!' : null;
            },
          ),
          const VGap(10.0),
          TFF(
            controller: widget.empAddressController,
            labelText: 'Employee address',
            validator: (address){
              return (address == null || address.trim().isEmpty) ? 'Employee address required!' : null;
            },
          ),
          const VGap(10.0),
          FutureBuilder<List<Department>>(
            future: getDepartments(),
            builder: (context, AsyncSnapshot<List<Department>> snapshot) {
              return DropdownButtonFormField<Department>(
                items: snapshot.hasData && snapshot.data!.isNotEmpty ? snapshot.data!.map((department) => DropdownMenuItem<Department>(
                  value: department,
                  child: Text(department.departmentName),
                )).toList() : null, 
                onChanged: (department){
                  EmployeeListScreen.selectedDepartment = department;
                },
                validator: (dep) => dep == null ? 'Please select department' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: snapshot.connectionState == ConnectionState.waiting ? 'Loading' : (snapshot.hasData && snapshot.data!.isNotEmpty ? 'Select department' : 'No data'),
                ),
              );
            },
          ),
          const VGap(10.0),
          TextButton(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
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