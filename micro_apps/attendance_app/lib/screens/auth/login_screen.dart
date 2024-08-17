import 'package:flutter/material.dart';

import 'package:attendance_app/resources/images.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/containers/auth/login/login_form_container.dart';
import 'package:attendance_app/screens/auth/strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.loginBackgroundPng),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      Strings.signIn,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Strings.enterSignInDetails,
                      style: Theme.of(context).textTheme.displaySmallSemiBold,
                    ),
                  ],
                ),
                const LoginFormContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
