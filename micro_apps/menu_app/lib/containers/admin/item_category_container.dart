import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/widgets/admin/item_category_widget.dart';
import 'package:provider/provider.dart';

class ItemCategoryContainer extends StatefulWidget {
  const ItemCategoryContainer({super.key});

  @override
  State<ItemCategoryContainer> createState() => _ItemCategoryContainerState();
}

class _ItemCategoryContainerState extends State<ItemCategoryContainer> {
  CourseService courseService = CourseService();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    checkCategory();
  }

  void checkCategory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? selectedCategory = await courseService
        .hasSelectedCategory(authProvider.currentUser!.institute[0]);
    if (selectedCategory != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AdminRoutes.itemList,
        (Route<dynamic> route) => false,
        arguments: selectedCategory,
      );
    } else {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? const ItemCategoryWidget()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
