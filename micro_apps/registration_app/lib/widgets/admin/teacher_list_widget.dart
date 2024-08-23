import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/utils/widgets/show_success_modal.dart';
import 'package:registration_app/widgets/admin/action_card.dart';

class TeacherListWidget extends StatelessWidget {
  const TeacherListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 5),
      child: ListView(
        children: [
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: true,
            onAccept: () {
              showSuccessModal(
                  context, Strings.acknowledgment, () {}, ["000000000"]);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: true,
            onAccept: () {
              showSuccessModal(
                  context, Strings.acknowledgment, () {}, ["000000000"]);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: true,
            onAccept: () {
              showSuccessModal(
                  context, Strings.acknowledgment, () {}, ["000000000"]);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: true,
            onAccept: () {
              showSuccessModal(
                  context, Strings.acknowledgment, () {}, ["000000000"]);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: false,
            onAccept: () {
              showSuccessModal(
                  context, Strings.acknowledgment, () {}, ["000000000"]);
            },
            onReject: () {},
          ),
        ],
      ),
    );
  }
}
