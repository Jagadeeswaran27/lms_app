import 'package:flutter/material.dart';

import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/screens/common/course_detail_screen.dart';
import 'package:menu_app/widgets/common/course_card.dart';

class MyCoursesWidget extends StatelessWidget {
  const MyCoursesWidget({
    super.key,
    required this.courses,
    required this.isLoading,
  });

  final List<CourseModel> courses;
  final bool isLoading;

  void navigateToCourseDetail(BuildContext context, CourseModel course) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CourseDetailScreen(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(
            course: courses[index],
            onPressed: () => navigateToCourseDetail(context, courses[index]),
          );
        },
      ),
    );
  }
}
