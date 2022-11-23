import 'package:flutter/material.dart';
import 'package:my_pos/common/methods.dart';
import 'package:my_pos/models/employee.dart';
import 'package:my_pos/widgets/vgap.dart';

class ViewEmployeeScreen extends StatelessWidget {
  final Employee employee;
  const ViewEmployeeScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final size = deviceSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Employee'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.02),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const VGap(10.0),
                CircleAvatar(
                  radius: size.width * 0.25,
                  backgroundImage: const NetworkImage('https://i.ytimg.com/vi/3tT3vClFAj8/maxresdefault.jpg'),
                ),
                const VGap(10.0),
                Text(
                  employee.empName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.06
                  ),
                ),
                const VGap(10.0),
                Text(
                  employee.empAddressLine1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.05
                  ),
                ),
                const VGap(10.0),
                Text(
                  'All the other details can be diplayed as we wish',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.05
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}