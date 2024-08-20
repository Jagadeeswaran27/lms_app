import 'package:flutter/material.dart';

import 'package:menu_app/screens/common/welcome_screen.dart';
import 'package:menu_app/themes/themes.dart';

void main() => runApp(const MenuApp());

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      home: const SafeArea(
        child: Center(
          child: Scaffold(
            body: WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
