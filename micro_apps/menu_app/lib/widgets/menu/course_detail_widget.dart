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
  const CourseDetailWidget({
    super.key,
    required this.course,
    required this.subCategory,
    required this.approvedRegistrationsCount,
    required this.pendingRegistrationsCount,
    required this.rejectedRegistrationsCount,
  });

  final CourseModel course;
  final String subCategory;
  final int approvedRegistrationsCount;
  final int pendingRegistrationsCount;
  final int rejectedRegistrationsCount;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final Size screenSize = MediaQuery.of(context).size;
    final role = authProvider.currentUser!.role;
    print(authProvider.selectedinstituteCode);
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseDetailCard(subCategory: subCategory, course: course),
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
                  if (course.batchDay.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Days",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumPrimary
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              ...course.batchDay.split('+').map(
                                    (day) => Container(
                                      margin: const EdgeInsets.only(bottom: 7),
                                      child: Text(
                                        day,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  if (course.batchTime != null && course.batchTime!.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Timing : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumPrimary
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              course.batchTime!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
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
            if (role == UserRoleEnum.admin.roleName)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.approvedRegistrations,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumPrimary
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    approvedRegistrationsCount.toString(),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        Strings.pendingRegistrations,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumPrimary
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    pendingRegistrationsCount.toString(),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        Strings.rejectedRegistrations,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumPrimary
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    rejectedRegistrationsCount.toString(),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            const SizedBox(height: 50),
            if (role == UserRoleEnum.admin.roleName)
              Center(
                child: SizedBox(
                  width: screenSize.width * 0.7,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ThemeColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.bodyMediumPrimary,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
