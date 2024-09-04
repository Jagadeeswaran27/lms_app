import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/utils/show_snackbar.dart';

import 'package:menu_app/widgets/admin/add_item_widget.dart';
import 'package:provider/provider.dart';

class AddItemContainer extends StatefulWidget {
  const AddItemContainer({super.key, required this.subCategory});

  final String subCategory;

  @override
  State<AddItemContainer> createState() => _AddItemContainerState();
}

class _AddItemContainerState extends State<AddItemContainer> {
  bool _isLoading = false;
  final CourseService _courseService = CourseService();

  Future<void> addItem(Map<String, dynamic> formData, File image) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    final courseId = await _courseService.addItem(
      formData,
      image,
      authProvider.currentUser!.institute[0],
      widget.subCategory,
    );
    setState(() {
      _isLoading = false;
    });
    if (courseId != null) {
      showSnackbar(context, 'Item added successfully');
      Navigator.pop(context);
    } else {
      showSnackbar(context, 'Failed to add item');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddItemWidget(
      isLoading: _isLoading,
      addItem: addItem,
      subCategory: widget.subCategory,
    );
  }
}
