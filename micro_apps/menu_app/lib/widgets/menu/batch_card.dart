import 'package:flutter/material.dart';

import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/widgets/common/drop_down_row.dart';

class BatchCard extends StatelessWidget {
  const BatchCard({super.key, required this.role, required this.course});

  final String role;
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: ThemeColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 140.0,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ThemeColors.cardBorderColor,
                    width: 0.3,
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropDownRow(
                      label: Strings.days,
                      value: "Weekend",
                      options: const ["Weekend", "Weekday"],
                      onChanged: (String? newValue) {},
                      isDropdown: false,
                    ),
                    const SizedBox(height: 20),
                    DropDownRow(
                      label: Strings.time,
                      value: "Morning",
                      options: const ["Morning", "Evening"],
                      onChanged: (String? newValue) {},
                      isDropdown: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
