import 'package:flutter/material.dart';
import 'package:my_pos/screens/employee_list_screen.dart';
import 'package:provider/provider.dart';

import 'providers/employee_provider.dart';

main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EmployeeProvider()),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My POS',
      debugShowCheckedModeBanner: false,
      initialRoute: EmployeeListScreen.routeId,
      routes: {
        EmployeeListScreen.routeId: (context) => const EmployeeListScreen(),
      },
    );
  }
}
