import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/admin/item_detail_widget.dart';
import 'package:intl/intl.dart';

class ItemDetailContainer extends StatefulWidget {
  const ItemDetailContainer({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  State<ItemDetailContainer> createState() => _ItemDetailContainerState();
}

class _ItemDetailContainerState extends State<ItemDetailContainer> {
  late String todayDate;
  AttendanceService attendanceService = AttendanceService();
  Map<String, bool> studentsAttendanceStatus = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
    fetchAttendance();
  }

  void fetchAttendance() async {
    setState(() {
      isLoading = true;
    });
    Map<String, bool> attendanceStatus = {
      for (var student in widget.course.students!) student.keys.first: false,
    };
    studentsAttendanceStatus = await attendanceService.getAttendance(
      widget.course.courseId,
      todayDate,
      attendanceStatus,
    );
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> onMarkAttendance(Map<String, bool> attendanceStatus) async {
    try {
      final bool response = await attendanceService.markAttendance(
          attendanceStatus, widget.course.courseId, todayDate);
      if (response) {
        setState(() {
          studentsAttendanceStatus = attendanceStatus;
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ItemDetailWidget(
            course: widget.course,
            onMarkAttendance: onMarkAttendance,
            studentsAttendanceStatus: studentsAttendanceStatus,
          );
  }
}
