import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:registration_app/constants/enums/user_role_enum.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/screens/auth/role_type_selection_screen.dart';
import 'package:registration_app/screens/auth/welcome_screen.dart';
import 'package:registration_app/utils/sentence_case.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/settings_screen_widget.dart';

class SettingsScreenContainer extends StatefulWidget {
  const SettingsScreenContainer({super.key});

  @override
  State<SettingsScreenContainer> createState() =>
      _SettingsScreenContainerState();
}

class _SettingsScreenContainerState extends State<SettingsScreenContainer> {
  bool _isLoading = false;
  bool _isEditing = false;

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

  Future<void> saveInstituteName(String name, bool isInstitute) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final accessCode = isInstitute
        ? authProvider.currentUser?.institute.first
        : authProvider.selectedinstituteCode;
    final instituteName = sentenceCase(name);
    final response = await authProvider.updateUserName(
      accessCode!,
      instituteName,
      isInstitute,
    );
    if (response) {
      showSnackbar(context, 'Profile updated successfully');
    } else {
      showSnackbar(context, 'Failed to update profile');
    }
    setState(() {
      _isLoading = false;
      _isEditing = false;
    });
  }

  void setEditing(bool editingStatus) {
    setState(() {
      _isEditing = editingStatus;
    });
  }

  void changeRole(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const RoleTypeSelectionScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isInstitute =
        authProvider.currentUser!.role == UserRoleEnum.admin.roleName;

    return SettingsScreenWidget(
      isInstitute: isInstitute,
      isLoading: _isLoading,
      isEditing: _isEditing,
      email: authProvider.currentUser!.email,
      name: authProvider.currentUser!.name,
      phone: authProvider.currentUser!.phone,
      saveInstituteName: saveInstituteName,
      setEditing: setEditing,
      logout: () => logout(context),
      changeRole: () => changeRole(context),
    );
  }
}
