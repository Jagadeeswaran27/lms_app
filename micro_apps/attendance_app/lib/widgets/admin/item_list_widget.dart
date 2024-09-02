import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/routes/admin_routes.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/widgets/common/course_card.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({
    super.key,
    required this.myCourses,
  });

  final List<CourseModel> myCourses;

  void navigateToAttendance(BuildContext context, CourseModel course) {
    Navigator.of(context).pushNamed(
      AdminRoutes.itemDetail,
      arguments: course,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: myCourses.length,
        itemBuilder: (ctx, index) {
          final course = myCourses[index];
          return CourseCard(
            course: course,
            onTap: () => navigateToAttendance(context, course),
          );
        },
      ),
    );
  }
}
