import 'package:flutter/material.dart';

import 'package:registration_app/routes/routes.dart';
import 'package:registration_app/themes/themes.dart';

//change the app in login_widget.dart file to see the admin,student and teacher app

void main() => runApp(const RegistrationApp());

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: Routes.buildRoutes,
      initialRoute: Routes.initialRoute,
    );
  }
}
