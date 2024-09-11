import 'package:flutter/material.dart';

import 'package:attendance_app/screens/attendance/access_code_screen.dart';
import 'package:attendance_app/screens/attendance/student_course_dashboard_screen.dart';
import 'package:attendance_app/screens/attendance/student_detail_view_screen_student.dart';
import 'package:attendance_app/screens/attendance/attendance_screen.dart';
import 'package:attendance_app/screens/attendance/my_courses_screen.dart';

class AttendanceAppRoutes {
  const AttendanceAppRoutes._();

  static const accessCode = 'access-code';
  static const myCourses = '/my-courses';
  static const attendance = '/attendance';
  static const studentCourseDashboard = '/student-course-dashboard';
  static const studentDetailViewStudent = '/student-detail-view-student';

  static Map<String, WidgetBuilder> get buildAttendanceAppRoutes {
    return {
      accessCode: (context) => const AccessCodeScreen(),
      myCourses: (context) => const MyCoursesScreen(),
      attendance: (context) => const AttendanceScreen(),
      studentCourseDashboard: (context) => const StudentCourseDashboardScreen(),
      studentDetailViewStudent: (context) =>
          const StudentDetailViewScreenStudent(),
    };
  }

  static String get initialRoute {
    return AttendanceAppRoutes.accessCode;
  }
}
