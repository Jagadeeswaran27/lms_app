import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/course_model.dart';

import 'package:menu_app/widgets/menu/my_courses_widget.dart';

class MyCoursesContainer extends StatefulWidget {
  const MyCoursesContainer({super.key});

  @override
  State<MyCoursesContainer> createState() => _MyCoursesContainerState();
}

class _MyCoursesContainerState extends State<MyCoursesContainer> {
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
    return MyCoursesWidget(isLoading: _isLoading, courses: courses);
  }
}
