import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/admin_routes.dart';
import 'package:registration_app/widgets/admin/action_card.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({super.key});

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
              Navigator.of(context).pushNamed(AdminRoutes.uploadReceipt);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: false,
            onAccept: () {
              Navigator.of(context).pushNamed(AdminRoutes.uploadReceipt);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: false,
            onAccept: () {
              Navigator.of(context).pushNamed(AdminRoutes.uploadReceipt);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: false,
            onAccept: () {
              Navigator.of(context).pushNamed(AdminRoutes.uploadReceipt);
            },
            onReject: () {},
          ),
          ActionCard(
            imageUrl: Strings.url,
            name: "XXXXX",
            courseName: "XXXXXX",
            paymentDone: false,
            onAccept: () {
              Navigator.of(context).pushNamed(AdminRoutes.uploadReceipt);
            },
            onReject: () {},
          ),
        ],
      ),
    );
  }
}
