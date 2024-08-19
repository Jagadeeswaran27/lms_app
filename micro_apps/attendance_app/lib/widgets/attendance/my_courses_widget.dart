import 'package:attendance_app/screens/attendance/attendance_screen.dart';
import 'package:attendance_app/widgets/common/course_card.dart';
import 'package:flutter/material.dart';

class MyCoursesWidget extends StatelessWidget {
  const MyCoursesWidget({super.key});

  void navigateToAttendance(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AttendanceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CourseCard(
          onTap: () => navigateToAttendance(context),
        ),
      ],
    );
  }
}
