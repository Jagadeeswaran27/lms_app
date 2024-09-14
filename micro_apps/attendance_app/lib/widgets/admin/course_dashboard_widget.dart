import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/admin/dashboard_card_widget.dart';
import 'package:flutter/material.dart';

class CourseDashboardWidget extends StatefulWidget {
  const CourseDashboardWidget({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  _CourseDashboardWidgetState createState() => _CourseDashboardWidgetState();
}

class _CourseDashboardWidgetState extends State<CourseDashboardWidget> {
  bool _isAscending = true;
  List<Map<String, dynamic>>? _studentsData; // Cache for students data
  bool _isLoading = true;

  Future<void> fetchStudentsData() async {
    List<Map<String, dynamic>> studentsData = await Future.wait(
      widget.course.students!.map((student) async {
        final studentId = student.keys.first;
        final studentName = await getStudentName(studentId);
        final attendedHours = await getAttendedHours(studentId);
        return {
          'studentId': studentId,
          'studentName': studentName,
          'attendedHours': attendedHours,
        };
      }).toList(),
    );

    setState(() {
      _studentsData = studentsData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudentsData();
  }

  Future<int> getAttendedHours(String studentId) async {
    AttendanceService attendanceService = AttendanceService();
    return await attendanceService.attendedHours(
        studentId, widget.course.courseId);
  }

  Future<String> getStudentName(String studentId) async {
    AttendanceService attendanceService = AttendanceService();
    return await attendanceService.getStudentName(studentId);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_studentsData == null || _studentsData!.isEmpty) {
      return Center(
        child: Text(
          "No Data Found",
          style: Theme.of(context).textTheme.bodyMediumTitleBrown,
        ),
      );
    }

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Sort By",
                style: Theme.of(context).textTheme.bodyMediumTitleBrown,
              ),
              const SizedBox(width: 15),
              DropdownButton<String>(
                value: _isAscending ? "Ascending" : "Descending",
                icon: const Icon(
                  Icons.arrow_drop_down,
                ),
                padding: const EdgeInsets.all(0),
                style:
                    Theme.of(context).textTheme.displayMediumTitleBrownSemiBold,
                items: const [
                  DropdownMenuItem(
                    value: "Ascending",
                    child: Text(
                      'Ascending',
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Descending",
                    child: Text(
                      'Descending',
                    ),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _isAscending = (newValue == "Ascending");
                  });
                },
              ),
            ],
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _studentsData!.length,
                  itemBuilder: (ctx, index) {
                    List<Map<String, dynamic>> sortedStudentsData =
                        List.from(_studentsData!);

                    sortedStudentsData.sort((a, b) {
                      return _isAscending
                          ? a['attendedHours'].compareTo(b['attendedHours'])
                          : b['attendedHours'].compareTo(a['attendedHours']);
                    });

                    final studentData = sortedStudentsData[index];
                    return DashboardCardWidget(
                      course: widget.course,
                      attendedHours: studentData['attendedHours'],
                      name: studentData['studentName'],
                      studentId: studentData['studentId'],
                    );
                  },
                ),
        ],
      ),
    );
  }
}
