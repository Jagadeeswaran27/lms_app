import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/widgets/attendance/attendance_widget.dart';
import 'package:provider/provider.dart';

class AttendanceContainer extends StatefulWidget {
  const AttendanceContainer({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  State<AttendanceContainer> createState() => _AttendanceContainerState();
}

class _AttendanceContainerState extends State<AttendanceContainer> {
  AttendanceService attendanceService = AttendanceService();
  bool isLoading = false;
  int totalHours = 0;
  int attendedHours = 0;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      totalHours = await attendanceService.getTotalHours(
          authProvider.selectedinstituteCode, widget.course.courseId);
      attendedHours = await attendanceService.attendedHours(
          authProvider.currentUser!.uid, widget.course.courseId);
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AttendanceWidget(
            course: widget.course,
            attendedHours: attendedHours,
            totalHours: totalHours,
          );
  }
}
