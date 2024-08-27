import 'package:flutter/material.dart';

import 'package:location_app/screens/student_teacher/student_teacher_location_screen.dart';

class StudentTeacherRoutes {
  const StudentTeacherRoutes._();

  static const String location = '/location';

  static Map<String, WidgetBuilder> get buildStudentTeacherRoutes {
    return {
      location: (context) => const StudentTeacherLocationScreen(),
    };
  }

  static String get initialStudentRoute {
    return StudentTeacherRoutes.location;
  }
}
