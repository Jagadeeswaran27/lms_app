import 'package:flutter/material.dart';

import 'package:location_app/routes/student_routes.dart';
import 'package:location_app/themes/themes.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: StudentRoutes.buildStudentRoutes,
      initialRoute: StudentRoutes.initialStudentRoute,
    );
  }
}
