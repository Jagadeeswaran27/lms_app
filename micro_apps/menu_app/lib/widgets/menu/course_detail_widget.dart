import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/widgets/menu/batch_card.dart';
import 'package:menu_app/widgets/menu/course_detail_card.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class CourseDetailWidget extends StatelessWidget {
  const CourseDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const CourseDetailCard(),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.aboutDescription,
                  style: Theme.of(context).textTheme.bodyMediumPrimary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              Strings.loremIpsum,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.batchOferred,
                  style: Theme.of(context).textTheme.bodyMediumPrimary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const BatchCard(),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.amountDetails,
                  style: Theme.of(context).textTheme.bodyMediumPrimary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              Strings.loremIpsum,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
