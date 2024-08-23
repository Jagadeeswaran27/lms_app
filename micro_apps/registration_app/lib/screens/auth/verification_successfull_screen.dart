import 'package:flutter/material.dart';

import 'package:registration_app/resources/images.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/screens/auth/login_screen.dart';
import 'package:registration_app/screens/student/success_card.dart';

class VerificationSuccessfullScreen extends StatelessWidget {
  const VerificationSuccessfullScreen({super.key});

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
            child: SuccessCard(
              text: Strings.verifiedText,
              onPress: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
