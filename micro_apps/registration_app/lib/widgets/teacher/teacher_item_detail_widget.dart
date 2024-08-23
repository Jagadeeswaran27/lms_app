import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/batch_card.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/widgets/common/item_detail_card.dart';

class TeacherItemDetailWidget extends StatelessWidget {
  const TeacherItemDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const ItemDetailCard(),
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
            SizedBox(
              width: screenWidth * 0.7,
              height: 50,
              child: IconTextButton(
                iconHorizontalPadding: 7,
                radius: 20,
                text: Strings.proceed,
                onPressed: () {
                  Navigator.of(context).pushNamed(TeacherRoutes.register);
                },
                color: ThemeColors.primary,
                buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                svgIcon: icons.Icons.cartIconSvg,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
