import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:location_app/screens/auth/welcome_screen.dart';
import 'package:location_app/utils/error/show_snackbar.dart';
import 'package:location_app/constants/enums/user_role_enum.dart';
import 'package:location_app/providers/auth_provider.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/settings_screen_widget.dart';

class SettingsScreenContainer extends StatelessWidget {
  const SettingsScreenContainer({super.key});

  void logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.signOut();
    if (response) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      showSnackbar(context, Strings.errorLoggingOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final bool isInstitute =
        authProvider.currentUser!.role == UserRoleEnum.admin.roleName;
    return SettingsScreenWidget(
      isInstitute: isInstitute,
      email: authProvider.currentUser!.email,
      name: authProvider.currentUser!.name,
      phone: authProvider.currentUser!.phone,
      logout: () => logout(context),
    );
  }
}
