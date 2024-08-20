import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:attendance_app/screens/attendance/my_courses_screen.dart';
import 'package:attendance_app/screens/auth/signup_screen.dart';
import 'package:attendance_app/constants/enums/button_size.dart';
import 'package:attendance_app/resources/images.dart';
import 'package:attendance_app/widgets/common/custom_elevated_button.dart';
import 'package:attendance_app/widgets/common/svg_lodder.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/form_input.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  void _revealPassword() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: ThemeColors.white),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 120),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FormInput(text: Strings.enterYourEmailOrPhoneNo),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.enterYourPassword,
              suffixIcon: InkWell(
                onTap: _revealPassword,
                child: isPasswordVisible
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.remove_red_eye_outlined),
              ),
              obscureText: isPasswordVisible,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    Strings.forgetYourPassword,
                    style: Theme.of(context).textTheme.displayMediumPrimary,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.login,
                buttonSize: ButtonSize.large,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const MyCoursesScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Strings.orLoginWithGoogleAccount,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const SVGLoader(
                image: Images.google,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.haveAnAccount,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: Strings.registerNow,
                    style: Theme.of(context).textTheme.displayMediumBold,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const SignupScreen(),
                          ),
                        );
                      },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
