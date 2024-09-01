import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/providers/auth_provider.dart';

import 'package:menu_app/widgets/menu/my_courses_widget.dart';
import 'package:provider/provider.dart';

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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String instituteId = authProvider.selectedinstituteCode;
    _courseService.getCourses(instituteId).listen((courses) {
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
