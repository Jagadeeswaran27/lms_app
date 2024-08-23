import 'package:flutter/material.dart';

import 'package:registration_app/widgets/teacher/teacher_enrollment_widget.dart';

class TeacherEnrollmentContainer extends StatelessWidget {
  const TeacherEnrollmentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeacherEnrollmentWidget(isApproved: true, isReady: false);
  }
}
