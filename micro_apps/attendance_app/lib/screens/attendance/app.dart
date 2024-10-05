import 'package:attendance_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/routes/attendance_app_routes.dart';
import 'package:attendance_app/themes/themes.dart';
import 'package:provider/provider.dart';

class StudentTeacherAttencanceApp extends StatelessWidget {
  const StudentTeacherAttencanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isStudent = authProvider.currentUser!.roleType == "Student";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: AttendanceAppRoutes.buildAttendanceAppRoutes,
      initialRoute: isStudent
          ? AttendanceAppRoutes.initialRoute
          : AttendanceAppRoutes.accessCode,
    );
  }
}
