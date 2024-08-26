import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:menu_app/constants/enums/button_size.dart';
import 'package:menu_app/resources/images.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/screens/auth/signup_screen.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/custom_elevated_button.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.isLoading,
    required this.onSignIn,
  });

  final Future<void> Function(String email, String password, bool isGoogle)
      onSignIn;
  final bool isLoading;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  bool isPasswordVisible = true;

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.onSignIn(_userEmail, _userPassword, false);
    }
  }

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
            FormInput(
              text: Strings.enterYourEmailOrPhoneNo,
              onSaved: (value) => {_userEmail = value!},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidEmailOrPhone;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.enterYourPassword,
              onSaved: (value) => {_userPassword = value!},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidPassword;
                }
                return null;
              },
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
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumPrimary
                        .copyWith(fontSize: 14.0),
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
                onPressed: _handleSignIn,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Strings.orLoginWithGoogleAccount,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 15),
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
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 15),
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: Strings.registerNow,
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumBold
                        .copyWith(fontSize: 15),
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
