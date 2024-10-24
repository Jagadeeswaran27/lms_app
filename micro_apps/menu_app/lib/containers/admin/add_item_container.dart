import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/routes/admin_routes.dart';
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

  Future<void> addItem(Map<String, dynamic> formData, List<File> image) async {
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
      Navigator.of(context).pushNamedAndRemoveUntil(
        AdminRoutes.itemList,
        (Route<dynamic> route) => false,
        arguments: {
          'category': widget.subCategory,
          'showBack': false,
        },
      );
    } else {
      showSnackbar(context, 'Failed to add item');
    }
  }

  Future<bool> onAddSuggestion(String name, File image) async {
    final response = await _courseService.addSuggestion(name, image);
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddItemWidget(
      isLoading: _isLoading,
      addItem: addItem,
      subCategory: widget.subCategory,
      onAddSuggestion: onAddSuggestion,
    );
  }
}
