import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/admin/item_detail_widget.dart';

class ItemDetailContainer extends StatelessWidget {
  const ItemDetailContainer({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return ItemDetailWidget(course: course);
  }
}
