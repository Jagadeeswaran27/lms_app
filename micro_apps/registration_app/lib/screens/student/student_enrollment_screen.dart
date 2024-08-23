import 'package:flutter/material.dart';

import 'package:registration_app/containers/student/student_enrollment_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class StudentEnrollmentScreen extends StatelessWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.enrollmentInitiated,
      child: StudentEnrollmentContainer(),
    );
  }
}
