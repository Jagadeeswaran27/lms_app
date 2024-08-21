import 'package:flutter/material.dart';

import 'package:menu_app/screens/auth/options_screen.dart';
import 'package:menu_app/screens/common/welcome_screen.dart';

class Routes {
  const Routes._();

  static const String welcomeScreen = '/';
  static const String optionsScreen = '/options';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      welcomeScreen: (ctx) => const WelcomeScreen(),
      optionsScreen: (ctx) => const OptionsScreen()
    };
  }

  static String get initialRoute {
    return Routes.welcomeScreen;
  }

  static Widget get initialScreen {
    return const WelcomeScreen();
  }
}
