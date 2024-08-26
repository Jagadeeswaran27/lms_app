import 'package:flutter/material.dart';
import 'package:menu_app/models/courses/course_model.dart';

import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/screens/admin/add_item_screen.dart';
import 'package:menu_app/screens/common/course_detail_screen.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/widgets/admin/add_item_card.dart';
import 'package:menu_app/widgets/common/course_card.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget(
      {super.key, required this.isLoading, required this.courses});

  final bool isLoading;
  final List<CourseModel> courses;

  void navigateToAddItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddItemScreen(),
      ),
    );
  }

  void navigateToCourseDetail(BuildContext context, CourseModel course) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CourseDetailScreen(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          AddItemCard(
            onTap: () => navigateToAddItem(context),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: screenSize.width * 0.55,
              height: 50,
              child: IconTextButton(
                iconHorizontalPadding: 7,
                radius: 20,
                text: Strings.receptionEnquiry,
                onPressed: () {},
                color: ThemeColors.primary,
                buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                svgIcon: icons.Icons.enquiry,
              ),
            ),
          ),
          const SizedBox(height: 50),
          if (isLoading)
            const CircularProgressIndicator()
          else if (courses.isEmpty)
            Text(
              'No courses available',
              style: TextStyle(
                fontSize: 20,
                color: ThemeColors.primary,
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...courses.map(
                      (course) => CourseCard(
                        onPressed: () =>
                            navigateToCourseDetail(context, course),
                        course: course,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
