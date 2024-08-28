import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/admin_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/admin/action_card.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({
    super.key,
    required this.isLoading,
    required this.registrationList,
  });

  final bool isLoading;
  final List<StudentRegistrationModel> registrationList;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (registrationList.isEmpty) {
      return Center(
        child: Text('No Students registered yet',
            style: TextStyle(
              fontSize: 20,
              color: ThemeColors.primary,
            )),
      );
    }

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: registrationList
            .map((student) => ActionCard(
                  imageUrl: student.imageUrl,
                  name: student.userName,
                  courseName: student.courseName,
                  paymentDone: student.paymentStatus == 'Paid',
                  onAccept: () {
                    Navigator.of(context).pushNamed(AdminRoutes.uploadReceipt);
                  },
                  onReject: () {},
                ))
            .toList(),
      ),
    );
  }
}
