import 'package:flutter/material.dart';

import 'package:enquiry_app/screens/student_teacher_app/enquiry_reception_screen.dart';
import 'package:enquiry_app/screens/student_teacher_app/raise_enquiry_screen.dart';

class StudentTeacherRoutes {
  const StudentTeacherRoutes._();

  static const raiseEnquiry = '/raise-enquiry';
  static const enquiryReception = '/enquiry-reception';

  static Map<String, WidgetBuilder> get buildStudentTeacherRoutes {
    return {
      raiseEnquiry: (context) => const RaiseEnquiryScreen(),
      enquiryReception: (context) => const EnquiryReceptionScreen(),
    };
  }

  static String get initialRoute {
    return StudentTeacherRoutes.raiseEnquiry;
  }
}