import 'package:flutter/material.dart';

import 'package:attendance_app/widgets/attendance/student_dashboard_card_widget.dart';
import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/models/courses/course_model.dart';

class StudentCourseDashboardWidget extends StatelessWidget {
  const StudentCourseDashboardWidget({
    super.key,
    required this.course,
  });

  final CourseModel course;

  Future<int> getAttendedHours(String studentId) async {
    AttendanceService attendanceService = AttendanceService();
    int attendedHours =
        await attendanceService.attendedHours(studentId, course.courseId);
    return attendedHours;
  }

  Future<String> getStudentName(String studentId) async {
    AttendanceService attendanceService = AttendanceService();
    return await attendanceService.getStudentName(studentId);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: course.students!.length,
        itemBuilder: (ctx, index) {
          final student = course.students![index];
          final studentId = student.keys.first;

          return FutureBuilder<String>(
            future: getStudentName(studentId),
            builder: (context, nameSnapshot) {
              if (nameSnapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              } else if (nameSnapshot.hasError) {
                return Text('Error: ${nameSnapshot.error}');
              } else if (nameSnapshot.hasData) {
                final studentName = nameSnapshot.data!;

                return FutureBuilder<int>(
                  future: getAttendedHours(studentId),
                  builder: (context, hoursSnapshot) {
                    if (hoursSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Text("Loading...");
                    } else if (hoursSnapshot.hasError) {
                      return Text('Error: ${hoursSnapshot.error}');
                    } else if (hoursSnapshot.hasData) {
                      final attendedHours = hoursSnapshot.data!;

                      return StudentDashboardCardWidget(
                        course: course,
                        attendedHours: attendedHours,
                        name: studentName,
                        studentId: studentId,
                      );
                    } else {
                      return const Text('No data available');
                    }
                  },
                );
              } else {
                return const Text('No data available');
              }
            },
          );
        },
      ),
    );
  }
}
