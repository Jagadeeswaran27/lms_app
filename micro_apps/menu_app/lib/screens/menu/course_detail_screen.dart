import 'package:flutter/material.dart';
import 'package:menu_app/containers/menu/course_detail_container.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      topBarText: "Item",
      child: CourseDetailContainer(),
    );
  }
}
