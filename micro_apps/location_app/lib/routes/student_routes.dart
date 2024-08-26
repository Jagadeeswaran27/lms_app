import 'package:flutter/material.dart';

import 'package:location_app/screens/student/student_location_screen.dart';

class StudentRoutes {
  const StudentRoutes._();

  static const String location = '/location';

  static Map<String, WidgetBuilder> get buildStudentRoutes {
    return {
      location: (context) => const StudentLocationScreen(),
    };
  }

  static String get initialStudentRoute {
    return StudentRoutes.location;
  }
}
