import 'package:flutter/material.dart';

import 'package:location_app/routes/teacher_routes.dart';
import 'package:location_app/themes/themes.dart';

class TeacherApp extends StatelessWidget {
  const TeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: TeacherRoutes.buildTeacherRoutes,
      initialRoute: TeacherRoutes.initialTeacherRoute,
    );
  }
}