import 'package:flutter/material.dart';
import 'package:menu_app/screens/menu/course_detail_screen.dart';

import 'package:menu_app/widgets/common/course_card.dart';

class MyCoursesWidget extends StatelessWidget {
  const MyCoursesWidget({super.key});

  void navigateToCourseDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CourseDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CourseCard(
          onPressed: () => navigateToCourseDetail(context),
        ),
      ],
    );
  }
}
