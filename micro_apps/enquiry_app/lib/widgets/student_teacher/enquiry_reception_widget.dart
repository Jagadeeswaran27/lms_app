import 'package:flutter/material.dart';

import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/widgets/common/form_input.dart';
import 'package:enquiry_app/widgets/student_teacher/choose_file_button.dart';
import 'package:enquiry_app/widgets/student_teacher/enquiry_reception_title_card.dart';
import 'package:enquiry_app/resources/icons.dart' as icons;
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/widgets/common/icon_text_button.dart';

class EnquiryReceptionWidget extends StatelessWidget {
  const EnquiryReceptionWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        EnquiryReceptionTitleCard(name: name),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        Strings.whatAreYouFacingIssueWith,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumTitleBrownSemiBold,
                      ),
                      Text(
                        Strings.required,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmallTitleBrownSemiBold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const FormInput(text: ""),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.subject,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumTitleBrownSemiBold,
                      ),
                      Text(
                        Strings.required,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmallTitleBrownSemiBold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const FormInput(text: ""),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.describeTheIssue,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumTitleBrownSemiBold,
                      ),
                      Text(
                        Strings.required,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmallTitleBrownSemiBold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 200,
                    child: FormInput(
                      text: "",
                      isDescription: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        Strings.file,
                        style: Theme.of(context).textTheme.bodyLargeTitleBrown,
                      ),
                      const SizedBox(width: 10),
                      ChooseFileButton(onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        Strings.supportedFiles,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: screenSize.width * 0.7,
                      height: 50,
                      child: IconTextButton(
                        iconHorizontalPadding: 7,
                        radius: 20,
                        text: Strings.proceedToCheckout,
                        onPressed: () {},
                        color: ThemeColors.primary,
                        buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                        svgIcon: icons.Icons.ticket,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
