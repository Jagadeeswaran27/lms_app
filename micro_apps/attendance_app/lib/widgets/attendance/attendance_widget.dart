import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/widgets/attendance/class_progress_widget.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          const CourseDetailWidget(),
          const ClassProgressWidget(),
          SizedBox(
            width: screenWidth * 0.6,
            child: IconTextButton(
              iconHorizontalPadding: 0,
              color: ThemeColors.cardColor,
              text: Strings.enquire,
              onPressed: () {},
              buttonTextStyle: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
