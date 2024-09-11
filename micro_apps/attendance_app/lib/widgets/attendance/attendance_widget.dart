import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:attendance_app/routes/attendance_app_routes.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/widgets/common/svg_lodder.dart';
import 'package:attendance_app/resources/icons.dart' as icons;
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({
    super.key,
    required this.course,
    required this.displayFormatDate,
    required this.studentsAttendanceStatus,
    required this.fetchAttendance,
  });

  final CourseModel course;
  final Map<String, bool> studentsAttendanceStatus;
  final void Function(String, String) fetchAttendance;
  final String displayFormatDate;

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  late Map<String, bool> attendanceStatus;
  final String todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
  final String todayDateFormat =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    attendanceStatus = widget.studentsAttendanceStatus;
  }

  @override
  Widget build(BuildContext context) {
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
                const Spacer(),
                InkWell(
                  child: Text(
                    Strings.dashBoard,
                    style:
                        Theme.of(context).textTheme.bodyMediumPrimary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: ThemeColors.brown,
                            ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AttendanceAppRoutes.studentCourseDashboard,
                        arguments: widget.course);
                  },
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
                      Row(
                        children: [
                          InkWell(
                            child: const SVGLoader(
                              image: icons.Icons.prev,
                              width: 20,
                              height: 20,
                            ),
                            onTap: () {
                              DateTime dayBeforeYesterday = DateTime.now()
                                  .subtract(const Duration(days: 2));
                              String dayBeforeYesterdayDate =
                                  DateFormat('ddMMyyyy')
                                      .format(dayBeforeYesterday);
                              String dayBeforeYesterdayDateDisplayFormat =
                                  DateFormat('dd/MM/yyyy')
                                      .format(dayBeforeYesterday);
                              widget.fetchAttendance(
                                dayBeforeYesterdayDate,
                                dayBeforeYesterdayDateDisplayFormat,
                              );
                            },
                          ),
                          InkWell(
                            child: Icon(
                              Icons.navigate_before,
                              color: ThemeColors.primary,
                            ),
                            onTap: () {
                              DateTime yesterday = DateTime.now()
                                  .subtract(const Duration(days: 1));

                              String yesterdayDate =
                                  DateFormat('ddMMyyyy').format(yesterday);
                              String yesterdayDateDisplayFormat =
                                  DateFormat('dd/MM/yyyy').format(yesterday);
                              widget.fetchAttendance(
                                yesterdayDate,
                                yesterdayDateDisplayFormat,
                              );
                            },
                          ),
                          Text(
                            widget.displayFormatDate,
                            style:
                                Theme.of(context).textTheme.bodyMediumPrimary,
                          ),
                          if (widget.displayFormatDate != todayDateFormat)
                            InkWell(
                              child: Icon(
                                Icons.navigate_next,
                                color: ThemeColors.primary,
                              ),
                              onTap: () {
                                widget.fetchAttendance(
                                  todayDate,
                                  todayDateFormat,
                                );
                              },
                            ),
                        ],
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
                                onChanged: (value) {},
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}
