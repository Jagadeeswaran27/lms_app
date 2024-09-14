import 'package:enquiry_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/routes/routes.dart';
import 'package:enquiry_app/themes/themes.dart';
import 'package:provider/provider.dart';

class EnquiryApp extends StatelessWidget {
  const EnquiryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) {
        return AuthProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.buildLightTheme(context),
        routes: Routes.buildRoutes,
        initialRoute: Routes.initialRoute,
      ),
    );
  }
}
