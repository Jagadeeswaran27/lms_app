import 'package:flutter/material.dart';
import 'package:menu_app/constants/enums/user_role_enum.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/providers/auth_provider.dart';

import 'package:provider/provider.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/widgets/menu/batch_card.dart';
import 'package:menu_app/widgets/menu/course_detail_card.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class CourseDetailWidget extends StatelessWidget {
  const CourseDetailWidget(
      {super.key, required this.course, required this.subCategory});

  final CourseModel course;
  final String subCategory;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final role = authProvider.currentUser!.role;

    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseDetailCard(course: course),
            const SizedBox(height: 20),
            Text(
              Strings.aboutDescription,
              style: Theme.of(context)
                  .textTheme
                  .bodyMediumPrimary
                  .copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              course.aboutDescription,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              Strings.shortDescription,
              style: Theme.of(context)
                  .textTheme
                  .bodyMediumPrimary
                  .copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              course.shortDescription,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            if (subCategory == 'courses')
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.batchOferred,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumPrimary
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BatchCard(role: role, course: course),
                  const SizedBox(height: 20),
                ],
              ),
            Row(
              children: [
                Text(
                  Strings.amountDetails,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumPrimary
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              course.amount.toString(),
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 20),
            if (role != UserRoleEnum.admin.roleName)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.7,
                    height: 50,
                    child: IconTextButton(
                      iconHorizontalPadding: 7,
                      radius: 20,
                      text: Strings.register,
                      onPressed: () {},
                      color: ThemeColors.primary,
                      buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                      svgIcon: icons.Icons.bookIcon,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
