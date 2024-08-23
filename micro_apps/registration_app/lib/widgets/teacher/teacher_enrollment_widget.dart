import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/student/cart_card.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/widgets/teacher/status_progress_indicator.dart';

class TeacherEnrollmentWidget extends StatelessWidget {
  final bool isApproved;
  final bool isReady;

  const TeacherEnrollmentWidget({
    super.key,
    required this.isApproved,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 100,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ThemeColors.cardBorderColor,
                width: 0.2,
              ),
              top: BorderSide(
                color: ThemeColors.cardBorderColor,
                width: 0.2,
              ),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: ThemeColors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
              )
            ],
            color: ThemeColors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                Strings.registrationNo,
                style: Theme.of(context).textTheme.bodyMediumTitleBrown,
              ),
              Text(
                "000000000000",
                style: Theme.of(context).textTheme.bodyMediumPrimary,
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: ListView(
              shrinkWrap: true,
              children: [
                const CartCard(
                  imageUrl: Strings.url,
                  title: "XXXXX",
                  amount: "10000",
                  description: Strings.loremIpsum,
                  discount: 10,
                ),
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
                Text(Strings.status,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: FormInput(
                            text: "",
                            hintText: isApproved
                                ? Strings.approved
                                : Strings.toBeApproved,
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          child: FormInput(
                            text: "",
                            hintText: isReady
                                ? Strings.readyForClass
                                : Strings.preparingClasses,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    StatusProgressIndicator(
                      isApproved: isApproved,
                      isReady: isReady,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenSize.width * 0.7,
                    height: 50,
                    child: IconTextButton(
                      iconHorizontalPadding: 7,
                      radius: 20,
                      text: Strings.continueText,
                      onPressed: () {},
                      color: ThemeColors.primary,
                      buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                      svgIcon: icons.Icons.cap,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
