import 'package:flutter/material.dart';
import 'package:menu_app/screens/auth/access_code_screen.dart';
import 'package:menu_app/screens/common/course_detail_screen.dart';
import 'package:menu_app/screens/menu/my_courses_screen.dart';

class StudentTeacherRoutes {
  const StudentTeacherRoutes._();

  static const String accessCode = '/access-code';
  static const String myCourses = '/my-courses';
  static const String courseDetail = '/course-detail';

  static Map<String, WidgetBuilder> get buildStudentTeacherRoutes {
    return {
      accessCode: (context) => const AccessCodeScreen(),
      myCourses: (contex) => const MyCoursesScreen(),
      courseDetail: (contex) => const CourseDetailScreen(),
    };
  }

  static String get initialStudentTeacherRoute {
    return StudentTeacherRoutes.accessCode;
  }
}
