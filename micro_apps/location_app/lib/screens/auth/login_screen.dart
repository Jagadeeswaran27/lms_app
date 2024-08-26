import 'package:flutter/material.dart';

import 'package:location_app/containers/auth/login/login_form_container.dart';
import 'package:location_app/resources/images.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double safeHeight = screenSize.height - padding.top - padding.bottom;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: safeHeight,
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
                          style:
                              Theme.of(context).textTheme.displayMediumSemiBold,
                        ),
                      ],
                    ),
                    const LoginFormContainer(),
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