import 'package:flutter/material.dart';
import 'package:registration_app/core/services/courses/course_service.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/widgets/teacher/teacher_item_list_widget.dart';

class TeacherItemListContainer extends StatefulWidget {
  const TeacherItemListContainer({super.key});

  @override
  State<TeacherItemListContainer> createState() =>
      _TeacherItemListContainerState();
}

class _TeacherItemListContainerState extends State<TeacherItemListContainer> {
  bool _isLoading = true;
  final _courseService = CourseService();
  List<CourseModel> courses = [];

  void fetchItems() {
    _courseService.getCourses().listen((courses) {
      setState(() {
        _isLoading = false;
        this.courses = courses;
      });
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching courses: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherItemListWidget(isLoading: _isLoading, courses: courses);
  }
}
