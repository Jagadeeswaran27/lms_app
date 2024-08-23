import 'package:flutter/material.dart';

import 'package:enquiry_app/routes/routes.dart';
import 'package:enquiry_app/themes/themes.dart';

void main() => runApp(const EnquiryApp());

class EnquiryApp extends StatelessWidget {
  const EnquiryApp({super.key});

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
