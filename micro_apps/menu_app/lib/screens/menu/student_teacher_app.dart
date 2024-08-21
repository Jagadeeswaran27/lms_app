import 'package:flutter/material.dart';

import 'package:menu_app/screens/menu/my_courses_screen.dart';
import 'package:menu_app/themes/themes.dart';

class StudentTeacherApp extends StatelessWidget {
  const StudentTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      home: const SafeArea(
        child: Center(
          child: Scaffold(
            body: MyCoursesScreen(),
          ),
        ),
      ),
    );
  }
}
