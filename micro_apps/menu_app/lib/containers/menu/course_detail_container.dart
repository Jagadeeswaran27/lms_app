import 'package:flutter/material.dart';
import 'package:menu_app/models/courses/course_model.dart';

import 'package:menu_app/widgets/menu/course_detail_widget.dart';

class CourseDetailContainer extends StatelessWidget {
  const CourseDetailContainer({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return CourseDetailWidget(course: course);
  }
}
