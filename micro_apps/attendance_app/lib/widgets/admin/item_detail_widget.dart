import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/utils/error/show_snackbar.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/attendance/class_progress_widget.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';
import 'package:intl/intl.dart';

class ItemDetailWidget extends StatefulWidget {
  const ItemDetailWidget({
    super.key,
    required this.course,
    required this.onMarkAttendance,
    required this.studentsAttendanceStatus,
  });

  final CourseModel course;
  final Future<bool> Function(Map<String, bool>) onMarkAttendance;
  final Map<String, bool> studentsAttendanceStatus;

  @override
  State<ItemDetailWidget> createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  late Map<String, bool> attendanceStatus;
  late String todayDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    attendanceStatus = widget.studentsAttendanceStatus;
    todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  void onSubmit() async {
    setState(() {
      isLoading = true;
    });
    final bool response = await widget.onMarkAttendance(attendanceStatus);
    if (response) {
      showSnackbar(context, "Attendance updated successfully");
    } else {
      showSnackbar(context, "Failed to update Attendance");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.studentsAttendanceStatus);
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Row(
              children: [
                Text(
                  Strings.totalRegistration,
                  style: Theme.of(context).textTheme.bodyLargePrimaryBold,
                ),
                Text(
                  widget.course.noOfRegistrations.toString(),
                  style:
                      Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
                ),
              ],
            ),
          ),
          CourseDetailWidget(course: widget.course),
          if (widget.course.noOfRegistrations! > 0)
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.studentNames,
                        style: Theme.of(context).textTheme.bodyLargePrimaryBold,
                      ),
                      Text(
                        todayDate, // Display today's date
                        style: Theme.of(context).textTheme.bodyMediumPrimary,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.course.students!.length,
                      itemBuilder: (ctx, index) {
                        final student = widget.course.students![index];
                        final studentId = student.keys.first;
                        final studentName = student.values.first;
                        final isPresent = attendanceStatus[studentId] ?? false;

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                studentName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrownSemiBold,
                              ),
                              Switch(
                                value: isPresent,
                                onChanged: (value) {
                                  setState(() {
                                    attendanceStatus[studentId] = value;
                                  });
                                },
                                activeColor: Colors.green,
                                inactiveThumbColor:
                                    const Color.fromARGB(255, 117, 0, 0),
                                inactiveTrackColor: Colors.red,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.5,
                    height: 50,
                    child: IconTextButton(
                      iconHorizontalPadding: 5,
                      radius: 20,
                      text: "Submit",
                      onPressed: onSubmit,
                      color: ThemeColors.primary,
                      buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                      isLoading: isLoading,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
