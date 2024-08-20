import 'package:flutter/material.dart';

import 'package:attendance_app/screens/common/welcome_screen.dart';
import 'package:attendance_app/themes/themes.dart';

void main() => runApp(const AttendanceApp());

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      home: const SafeArea(
        child: Center(
          child: Scaffold(
            body: WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
