import 'package:flutter/material.dart';

import 'package:menu_app/containers/menu/my_courses_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String subCategory =
        ModalRoute.of(context)?.settings.arguments as String;

    return MenuLayout(
      topBarText: Strings.itemList,
      showBackButton: true,
      child: MyCoursesContainer(subCategory: subCategory),
    );
  }
}
