import 'package:flutter/material.dart';

import 'package:attendance_app/routes/routes.dart';
import 'package:attendance_app/themes/themes.dart';

void main() => runApp(const AttendanceApp());

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: Routes.buildRoutes,
      initialRoute: Routes.initialRoute,
    );
  }
}
