import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/utils/widgets/show_success_modal.dart';
import 'package:registration_app/widgets/admin/student_upload_card.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class UploadStudentReceiptWidget extends StatelessWidget {
  const UploadStudentReceiptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                StudentUploadCard(
                  name: "XXXXXX",
                  courseName: "XXXXXXXX",
                  paymentDone: true,
                ),
                StudentUploadCard(
                  name: "XXXXXX",
                  courseName: "XXXXXXXX",
                  paymentDone: true,
                ),
                StudentUploadCard(
                  name: "XXXXXX",
                  courseName: "XXXXXXXX",
                  paymentDone: true,
                ),
                StudentUploadCard(
                  name: "XXXXXX",
                  courseName: "XXXXXXXX",
                  paymentDone: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenSize.width * 0.7,
            height: 50,
            child: IconTextButton(
              iconHorizontalPadding: 7,
              radius: 20,
              text: Strings.confirm,
              onPressed: () {
                showSuccessModal(
                  context,
                  Strings.acknowledgment,
                  () {},
                  [
                    "0000000000",
                    "0000000000",
                    "0000000000",
                    "0000000000",
                    "0000000000"
                  ],
                );
              },
              color: ThemeColors.primary,
              buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              svgIcon: icons.Icons.cap,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
