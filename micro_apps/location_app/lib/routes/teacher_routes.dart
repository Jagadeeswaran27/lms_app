import 'package:flutter/material.dart';

import 'package:location_app/screens/teacher/teacher_location_screen.dart';

class TeacherRoutes {
  const TeacherRoutes._();

  static const String location = '/location';

  static Map<String, WidgetBuilder> get buildTeacherRoutes {
    return {
      location: (context) => const TeacherLocationScreen(),
    };
  }

  static String get initialTeacherRoute {
    return TeacherRoutes.location;
  }
}
