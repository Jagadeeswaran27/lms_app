import 'package:flutter/material.dart';

import 'package:menu_app/containers/menu/course_detail_container.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseModel course =
        ModalRoute.of(context)?.settings.arguments as CourseModel;
    return MenuLayout(
      topBarText: Strings.item,
      child: CourseDetailContainer(course: course),
    );
  }
}
