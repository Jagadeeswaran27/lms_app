import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/widgets/student/student_enrollment_widget.dart';

class StudentEnrollmentContainer extends StatelessWidget {
  const StudentEnrollmentContainer({
    super.key,
    required this.registrationIds,
    required this.courses,
  });

  final List<String> registrationIds;
  final List<CourseModel> courses;

  @override
  Widget build(BuildContext context) {
    return StudentEnrollmentWidget(
      registrationIds: registrationIds,
      courses: courses,
    );
  }
}
