import 'package:attendance_app/resources/strings.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/attendance/class_progress_widget.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';

class ItemDetailWidget extends StatelessWidget {
  const ItemDetailWidget({
    super.key,
    required this.course,
  });

  final CourseModel course;

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
                  course.noOfRegistrations.toString(),
                  style:
                      Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
                ),
              ],
            ),
          ),
          CourseDetailWidget(course: course),
          if (course.students!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.studentNames,
                        style: Theme.of(context).textTheme.bodyLargePrimaryBold,
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: course.students!.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            course.students![index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumTitleBrownSemiBold,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          const ClassProgressWidget(),
        ],
      ),
    );
  }
}
