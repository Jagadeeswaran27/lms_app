import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/themes/colors.dart';
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
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _userName = '';
  String _mobileNumber = '';
  String? selectedOption = 'Self';

  void _handleRegister() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
    }
    // showSuccessModal(context, Strings.verifiedText2, () {
    //   Navigator.of(context).pushNamed(StudentRoutes.enrollment);
    // }, null);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courses = authProvider.cart;

    return SingleChildScrollView(
      child: Container(
        width: screenSize.width * 0.9,
        margin: const EdgeInsets.only(top: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FormInput(
                text: Strings.email,
                onSaved: (value) => {_email = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidEmailOrPhone;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FormInput(
                text: Strings.userName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidFullName;
                  }
                  return null;
                },
                onSaved: (value) => {_userName = value!},
              ),
              const SizedBox(height: 20),
              FormInput(
                text: Strings.mobileNumber,
                onSaved: (value) => {_mobileNumber = value!},
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return Strings.invalidMobileNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ...courses.map(
                (course) => Column(
                  children: [
                    FormInput(
                      text: 'Course ${courses.indexOf(course) + 1}',
                      initialValue: course.courseTitle,
                      hintText: course.courseTitle,
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              BatchOfferedCard(
                selectedBatchDay: 'Weekend',
                selectedBatchTime: 'Morning',
                onBatchDayChanged: (value) {},
                onBatchTimeChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RadioButton(
                    selectedOption: selectedOption!,
                    onChange: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    value: "Self",
                  ),
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
                  onPressed: _handleRegister,
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
