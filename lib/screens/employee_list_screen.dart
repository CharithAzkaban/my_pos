import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_pos/common/consts.dart';
import 'package:my_pos/common/methods.dart';
import 'package:my_pos/forms/add_employee_form.dart';
import 'package:my_pos/models/department.dart';
import 'package:my_pos/models/employee.dart';
import 'package:my_pos/providers/employee_provider.dart';
import 'package:my_pos/screens/view_employee_screen.dart';
import 'package:my_pos/services/database_activities.dart';
import 'package:my_pos/widgets/employee_widget.dart';
import 'package:my_pos/widgets/no_data.dart';
import 'package:my_pos/widgets/progress.dart';
import 'package:my_pos/widgets/tff.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  static const routeId = 'EMPLOYEE_LIST';
  static Department? selectedDepartment;
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    final searchController = TextEditingController();
    final size = deviceSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Employees',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TFF(
              controller: searchController,
              showBorder: false,
              width: size.width * 0.6,
              radius: 50.0,
              prefixIcon: const Icon(Icons.search_rounded),
              hintText: 'Search...',
              suffixIcon: IconButton(
                onPressed: ()async{
                  await employeeProvider.loadEmployees('');
                  searchController.clear();
                }, 
                icon: const Icon(Icons.clear_rounded, color: Colors.red,),
                splashRadius: 20.0,
              ),
              onChanged: (text)async{
                await employeeProvider.loadEmployees(text);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final empNameController = TextEditingController();
          final empAddressController = TextEditingController();
          final formKey = GlobalKey<FormState>();
          confirm(
            context, 
            title: 'Add Employee',
            body: AddEmployeeForm(
              empNameController: empNameController,
              empAddressController: empAddressController,
              formKey: formKey,
            ), 
            onConfirm: () async{
              if(formKey.currentState!.validate()){
                await addEmployee(
                  context,
                  employee: Employee(
                    empNo: date(DateTime.now(), format: 'hhmmss'), 
                    empName: empNameController.text.trim(), 
                    empAddressLine1: empAddressController.text.trim(), 
                    empAddressLine2: 'Address 2', 
                    empAddressLine3: 'Address 3', 
                    departmentCode: selectedDepartment!.departmentCode, 
                    dateOfJoin: DateTime.now(), 
                    dateOfBirth: employeeProvider.empBirthday, 
                    basicSalary: 0, 
                    isActive: true
                  )
                ).then((_) => pop(context));
              }
            },
            confirmText: 'Add',
          );
        }, 
        child: const Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: FutureBuilder<void>(
          future: employeeProvider.loadEmployees(searchController.text),
          builder: (context, AsyncSnapshot<void> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Progress();
            }
            else if(snapshot.connectionState == ConnectionState.done){
              return Consumer<EmployeeProvider>(
                builder: (context, provider, _) => Padding(
                  padding: EdgeInsets.all(deviceSize(context).width * 0.02),
                  child: provider.employeeList.isNotEmpty ? ListView.builder(
                    itemBuilder: (context, index) {
                      final employee = provider.employeeList[index];
                      return EmployeeWidget(
                        index: index,
                        employee: employee,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewEmployeeScreen(employee: employee))),
                      );
                    },
                    itemCount: provider.employeeList.length,
                  ) : const NoData(noDataMessage: 'No employees available'),
                ),
              );
            }
            return const NoData(
              noDataMessage: 'No employees available',
            );
          },
        ),
      ),
    );
  }
}