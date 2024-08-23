import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/batch_offered_card.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class TeacherRegisterWidget extends StatefulWidget {
  const TeacherRegisterWidget({super.key});

  @override
  State<TeacherRegisterWidget> createState() => _TeacherRegisterWidgetState();
}

class _TeacherRegisterWidgetState extends State<TeacherRegisterWidget> {
  String? selectedOption = 'self';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: screenSize.width * 0.9,
        margin: const EdgeInsets.only(top: 30),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    Strings.emailOfStudent,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const FormInput(text: Strings.email),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.enterUserName,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const FormInput(text: Strings.userName),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.contactInfo,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const FormInput(text: Strings.mobileNumber),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.course,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const FormInput(text: Strings.course1),
              const SizedBox(height: 30),
              const BatchOfferedCard(),
              const SizedBox(height: 30),
              SizedBox(
                width: screenSize.width * 0.7,
                height: 50,
                child: IconTextButton(
                  iconHorizontalPadding: 7,
                  radius: 20,
                  text: Strings.register,
                  onPressed: () {
                    Navigator.of(context).pushNamed(TeacherRoutes.enrollment);
                  },
                  color: ThemeColors.primary,
                  buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                  svgIcon: icons.Icons.bookIcon,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
