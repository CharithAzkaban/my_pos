import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_pos/common/consts.dart';
import 'package:my_pos/common/methods.dart';
import 'package:my_pos/forms/edit_employee_form.dart';
import 'package:my_pos/models/department.dart';
import 'package:my_pos/models/employee.dart';
import 'package:my_pos/providers/employee_provider.dart';
import 'package:my_pos/services/database_activities.dart';
import 'package:provider/provider.dart';

class EmployeeWidget extends StatelessWidget {
  static Department? selectedDepartment;
  final int index;
  final Employee employee;
  final void Function()? onTap;
  const EmployeeWidget({super.key, required this.index, required this.employee, this.onTap});

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    return Slidable(
      key: ValueKey(index),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => confirm(
              context,
              body: 'Delete ${employee.empName}?',
              onConfirm: () async{
                pop(context);
                waiting(context);
                await deleteEmployee(
                  context, 
                  empNo: employee.empNo,
                ).then((_) => pop(context));
              },
              confirmText: 'Delete'
            ),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete_rounded,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) {
              final empNameController = TextEditingController(text: employee.empName);
              final empAddressController = TextEditingController(text: employee.empAddressLine1);
              final formKey = GlobalKey<FormState>();
              employeeProvider.setEmpBirthday(employee.dateOfBirth);
              confirm(
                context,
                title: 'Edit Employee',
                body: EditEmployeeForm(
                  employee: employee, 
                  empNameController: empNameController, 
                  empAddressController: empAddressController, 
                  formKey: formKey
                ),
                onConfirm: () async{
                  if(formKey.currentState!.validate()){
                    pop(context);
                    waiting(context);
                    await editEmployee(
                      context, 
                      modifiedEmployee: employee.modifiedEmployee(
                        modEmpName: empNameController.text.trim(),
                        modEmpAddressLine1: empAddressController.text.trim(),
                        modDepartmentCode: selectedDepartment!.departmentCode,
                        modDateOfBirth: employeeProvider.empBirthday
                      ),
                    ).then((value) => pop(context));
                  }
                },
                confirmText: 'Edit'
              );
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit_rounded,
            label: 'Edit',
          ),
        ],
      ),
      child: Card(
        elevation: defaultElevation,
        child: ListTile(
          title: Text(employee.empName),
          subtitle: Text(employee.empNo),
          trailing: Icon(
            Icons.circle,
            color: employee.isActive ? Colors.green : Colors.red,
          ),
          onTap: onTap,
          shape: defaultShape,
        ),
      ),
    );
  }
}