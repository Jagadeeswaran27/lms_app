import 'package:flutter/material.dart';

import 'package:location_app/routes/routes.dart';
import 'package:location_app/themes/themes.dart';

void main() => runApp(const LocationApp());

class LocationApp extends StatelessWidget {
  const LocationApp({super.key});

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
