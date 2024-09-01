import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/providers/auth_provider.dart';

import 'package:menu_app/widgets/admin/item_list_widget.dart';
import 'package:provider/provider.dart';

class ItemListContainer extends StatefulWidget {
  const ItemListContainer({super.key});

  @override
  State<ItemListContainer> createState() => _ItemListContainerState();
}

class _ItemListContainerState extends State<ItemListContainer> {
  bool _isLoading = true;
  final _courseService = CourseService();
  List<CourseModel> courses = [];

  void fetchItems() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _courseService.getCourses(authProvider.currentUser!.institute[0]).listen(
        (courses) {
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
    return ItemListWidget(isLoading: _isLoading, courses: courses);
  }
}
