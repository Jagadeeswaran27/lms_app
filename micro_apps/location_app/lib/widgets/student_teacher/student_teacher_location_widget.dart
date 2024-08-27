import 'package:flutter/material.dart';

import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';
import 'package:location_app/widgets/common/form_input.dart';
import 'package:location_app/widgets/common/icon_text_button.dart';
import 'package:location_app/resources/icons.dart' as icons;
import 'package:location_app/widgets/common/svg_lodder.dart';

class StudentTeacherLocationWidget extends StatelessWidget {
  const StudentTeacherLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.enterYourLocation,
                  style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 50,
              child: IconTextButton(
                text: Strings.useMyLocation,
                onPressed: () {},
                color: ThemeColors.cardColor,
                iconHorizontalPadding: 5,
                buttonTextStyle: Theme.of(context).textTheme.titleSmall,
                svgIcon: icons.Icons.location,
                iconBackgroundColor: ThemeColors.primary,
              ),
            ),
            const SizedBox(height: 30),
            Text(Strings.or,
                style: Theme.of(context).textTheme.titleSmallTitleBrown),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  Strings.searchOnGoogleMaps,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const FormInput(
              text: "",
              suffixIcon: SVGLoader(
                image: icons.Icons.search,
              ),
            ),
            const SizedBox(height: 30),
            Text(Strings.or,
                style: Theme.of(context).textTheme.titleSmallTitleBrown),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  Strings.enterYourLocationOrLink,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const FormInput(
              text: "",
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 50,
              child: IconTextButton(
                iconHorizontalPadding: 7,
                radius: 20,
                text: Strings.fetchInstitutes,
                onPressed: () {
                  // Navigator.of(context).pushNamed(StudentRoutes.register);
                },
                color: ThemeColors.primary,
                buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                svgIcon: icons.Icons.cap,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
