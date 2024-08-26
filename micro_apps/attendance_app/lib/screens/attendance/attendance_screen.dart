import 'package:flutter/material.dart';

import 'package:attendance_app/containers/attendance/attendance_container.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      bottomText: "Course",
      topBarText: "Attendance",
      child: AttendanceContainer(),
    );
  }
}
