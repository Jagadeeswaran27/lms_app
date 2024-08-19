import 'package:flutter/material.dart';

import 'package:attendance_app/constants/enums/button_size.dart';
import 'package:attendance_app/resources/images.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/screens/auth/login_screen.dart';
import 'package:attendance_app/widgets/common/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.welcomeBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Strings.welcomeTo,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'XXXXXXXXX',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          height: 1.4,
                        ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: CustomElevatedButton(
                    text: Strings.getStarted,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const LoginScreen(),
                        ),
                      );
                    },
                    buttonSize: ButtonSize.large,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
