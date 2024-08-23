import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/utils/widgets/show_success_modal.dart';
import 'package:registration_app/widgets/common/batch_offered_card.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/common/radio_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class StudentRegisterWidget extends StatefulWidget {
  const StudentRegisterWidget({super.key});

  @override
  State<StudentRegisterWidget> createState() => _StudentRegisterWidgetState();
}

class _StudentRegisterWidgetState extends State<StudentRegisterWidget> {
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
              const SizedBox(height: 20),
              const BatchOfferedCard(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  RadioButton(
                      selectedOption: selectedOption!,
                      onChange: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                      value: "self"),
                  const SizedBox(width: 10),
                  RadioButton(
                    selectedOption: selectedOption!,
                    onChange: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    value: "For kid",
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.7,
                height: 50,
                child: IconTextButton(
                  iconHorizontalPadding: 7,
                  radius: 20,
                  text: Strings.register,
                  onPressed: () {
                    showSuccessModal(context, Strings.verifiedText2, () {
                      Navigator.of(context).pushNamed(StudentRoutes.enrollment);
                    }, null);
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
