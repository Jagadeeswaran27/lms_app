import 'package:attendance_app/models/courses/course_model.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/widgets/attendance/attendance_widget.dart';

class AttendanceContainer extends StatelessWidget {
  const AttendanceContainer({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return AttendanceWidget(course: course);
  }
}
