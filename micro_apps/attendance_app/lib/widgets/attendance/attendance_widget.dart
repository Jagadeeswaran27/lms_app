import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/attendance/class_progress_widget.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({
    super.key,
    required this.course,
    required this.totalHours,
    required this.attendedHours,
  });

  final CourseModel course;
  final int totalHours;
  final int attendedHours;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CourseDetailWidget(course: course),
          ClassProgressWidget(
            attenedHours: attendedHours,
            totalHours: totalHours,
          ),
        ],
      ),
    );
  }
}
