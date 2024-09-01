import 'package:attendance_app/screens/attendance/access_code_screen.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/screens/attendance/attendance_screen.dart';
import 'package:attendance_app/screens/attendance/my_courses_screen.dart';

class AttendanceAppRoutes {
  const AttendanceAppRoutes._();

  static const accessCode = 'access-code';
  static const myCourses = '/my-courses';
  static const attendance = '/attendance';

  static Map<String, WidgetBuilder> get buildAttendanceAppRoutes {
    return {
      accessCode: (context) => const AccessCodeScreen(),
      myCourses: (context) => const MyCoursesScreen(),
      attendance: (context) => const AttendanceScreen(),
    };
  }

  static String get initialRoute {
    return AttendanceAppRoutes.accessCode;
  }
}
