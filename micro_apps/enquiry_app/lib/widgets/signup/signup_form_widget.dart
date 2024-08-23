import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/config/auth/user_role.dart';
import 'package:enquiry_app/constants/enums/button_size.dart';
import 'package:enquiry_app/resources/images.dart';
import 'package:enquiry_app/resources/regex.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/screens/auth/login_screen.dart';
import 'package:enquiry_app/screens/auth/verification_successfull_screen.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/widgets/common/custom_elevated_button.dart';
import 'package:enquiry_app/widgets/common/form_input.dart';
import 'package:enquiry_app/widgets/common/svg_lodder.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _role;
  String? _roleError;
  bool isPasswordVisible = true;
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  bool _isTermsAccepted = false;
  String _userName = '';
  String _userEmail = '';
  String? _isTermsAcceptedError;
  String _userPassword = '';
  String _phone = '';

  final _passwordController = TextEditingController();

  void _handleRoleChange(String? value) {
    setState(() {
      _role = value;
      _roleError = null;
    });
  }

  void revealPassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void revealConfirmPassword() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _handleCheckBox(bool? value) {
    setState(() {
      _isTermsAccepted = value!;
      _isTermsAcceptedError = null;
    });
  }

  void _handleSignup() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const VerificationSuccessfullScreen(),
      ),
    );
    // if (_formKey.currentState!.validate() &&
    //     _role != null &&
    //     _isTermsAccepted) {
    //   _formKey.currentState?.save();
    //   // widget.onSignup(
    //   //   context: context,
    //   //   userName: _userName,
    //   //   email: _userEmail,
    //   //   phone: _phone,
    //   //   password: _userPassword,
    //   //   role: _role!,
    //   // );
    // } else if (_role == null) {
    //   setState(() {
    //     _roleError = Strings.pleaseSelectRole;
    //   });
    // } else if (!_isTermsAccepted) {
    //   setState(() {
    //     _isTermsAcceptedError = "Please read the terms and agree!";
    //   });
    // }
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
              text: Strings.fullName,
              keyboardType: TextInputType.name,
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
              text: Strings.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => {_userEmail = value!},
              validator: (value) {
                final emailPattern = RegExp(Regex.emailRegEx);
                if (value == null ||
                    value.isEmpty ||
                    !emailPattern.hasMatch(value)) {
                  return Strings.invalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.mobileNumber,
              keyboardType: TextInputType.phone,
              onSaved: (value) => {_phone = value!},
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return Strings.invalidMobileNumber;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    Strings.registerAs,
                    style:
                        Theme.of(context).textTheme.displayMediumBrownSemiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: userRoles.map((role) {
                return Expanded(
                  child: RadioListTile(
                    title: Text(
                      role.roleName,
                      style: Theme.of(context).textTheme.displayMediumBoldBrown,
                    ),
                    value: role.roleConstant,
                    groupValue: _role,
                    contentPadding: EdgeInsets.zero,
                    dense: false,
                    visualDensity: const VisualDensity(horizontal: -4),
                    activeColor: ThemeColors.black,
                    onChanged: _handleRoleChange,
                  ),
                );
              }).toList(),
            ),
            if (_roleError != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  _roleError!,
                  style: TextStyle(color: ThemeColors.errorColor, fontSize: 12),
                ),
              ),
            FormInput(
              text: Strings.password,
              keyboardType: TextInputType.text,
              onSaved: (value) => {_userPassword = value!},
              suffixIcon: InkWell(
                onTap: revealPassword,
                child: _isPasswordVisible
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.remove_red_eye_outlined),
              ),
              obscureText: _isPasswordVisible,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return Strings.passwordValidationString;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.confirmPassword,
              keyboardType: TextInputType.text,
              suffixIcon: InkWell(
                onTap: revealConfirmPassword,
                child: _isConfirmPasswordVisible
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.remove_red_eye_outlined),
              ),
              obscureText: _isConfirmPasswordVisible,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passwordController.text) {
                  return Strings.passwordsShouldMatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  activeColor: ThemeColors.black,
                  onChanged: _handleCheckBox,
                ),
                Flexible(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Strings.iAgreeWithThe,
                          style: Theme.of(context).textTheme.displayMediumBlack,
                        ),
                        TextSpan(
                          text: Strings.termsAndConditions,
                          style:
                              Theme.of(context).textTheme.displayMediumPrimary,
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (_isTermsAcceptedError != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  _isTermsAcceptedError!,
                  style: TextStyle(color: ThemeColors.errorColor, fontSize: 12),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.register,
                buttonSize: ButtonSize.large,
                onPressed: _handleSignup,
              ),
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
                    text: Strings.alreadyHaveAnAccount,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: Strings.loginNow,
                    style: Theme.of(context).textTheme.displayMediumBold,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const LoginScreen(),
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