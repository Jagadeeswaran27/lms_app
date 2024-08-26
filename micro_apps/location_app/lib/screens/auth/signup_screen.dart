import 'package:flutter/material.dart';

import 'package:location_app/containers/auth/signup/signup_form_container.dart';
import 'package:location_app/resources/images.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/fonts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.signupBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 70, bottom: 50),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          Strings.signUp,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          Strings.registerDetails,
                          style:
                              Theme.of(context).textTheme.displayMediumSemiBold,
                        ),
                      ],
                    ),
                    const SignupFormContainer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}