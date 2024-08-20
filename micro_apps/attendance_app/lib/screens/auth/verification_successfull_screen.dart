import 'package:flutter/material.dart';

import 'package:attendance_app/screens/attendance/my_courses_screen.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';
import 'package:attendance_app/resources/icons.dart' as icons;
import 'package:attendance_app/resources/images.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/svg_lodder.dart';

class VerificationSuccessfullScreen extends StatelessWidget {
  const VerificationSuccessfullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double safeHeight = screenSize.height - padding.top - padding.bottom;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: safeHeight,
            width: screenSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.optionBackgroundNew),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width * 0.95,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.primaryShadow,
                        blurRadius: 10.0,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        Strings.successfully,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.bodyLargeTitleBrownBold,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        Strings.verifiedText,
                        style: Theme.of(context).textTheme.titleSmallTitleBrown,
                      ),
                      const SizedBox(height: 20.0),
                      const SVGLoader(
                        image: icons.Icons.successIcon,
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 40,
                        width: screenSize.width * 0.4,
                        child: IconTextButton(
                          text: Strings.ok,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const MyCoursesScreen(),
                              ),
                            );
                          },
                          color: ThemeColors.cardColor,
                          iconHorizontalPadding: 0,
                          buttonTextStyle:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}