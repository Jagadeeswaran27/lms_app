import 'package:flutter/material.dart';

import 'package:registration_app/containers/teacher/teacher_enrollment_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherEnrollmentScreen extends StatelessWidget {
  const TeacherEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.enrollmentInitiated,
      child: TeacherEnrollmentContainer(),
    );
  }
}
