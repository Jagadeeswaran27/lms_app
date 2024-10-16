import 'package:flutter/material.dart';
import 'package:menu_app/constants/enums/user_role_enum.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/screens/common/welcome_screen.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/common/sentence_case.dart';
import 'package:menu_app/widgets/common/settings_screen_widget.dart';
import 'package:provider/provider.dart';

class SettingsScreenContainer extends StatefulWidget {
  const SettingsScreenContainer({super.key});

  @override
  State<SettingsScreenContainer> createState() =>
      _SettingsScreenContainerState();
}

class _SettingsScreenContainerState extends State<SettingsScreenContainer> {
  bool _isLoading = false;
  bool _isEditing = false;
  bool _isPhoneLoading = false;
  bool _isPhoneEditing = false;
  bool _isEmailLoading = false;
  bool _isEmailEditing = false;

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

  Future<void> saveUserPhone(String phone) async {
    setState(() {
      _isPhoneLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.updateUserPhone(phone);
    if (response) {
      showSnackbar(context, 'Profile updated successfully');
    } else {
      showSnackbar(context, 'Failed to update profile');
    }
    setState(() {
      _isPhoneLoading = false;
      _isPhoneEditing = false;
    });
  }

  Future<void> saveUserEmail(String email, bool isInstitute) async {
    setState(() {
      _isEmailLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.updateUserEmail(email);
    if (response) {
      showSnackbar(context, 'Verification email sent successfully');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false,
      );
    } else {
      showSnackbar(context, 'Error updating email');
    }
    setState(() {
      _isEmailLoading = false;
      _isEmailEditing = false;
    });
  }

  void setEditing(bool editingStatus) {
    setState(() {
      _isEditing = editingStatus;
    });
  }

  void setPhoneEditing(bool editingStatus) {
    setState(() {
      _isPhoneEditing = editingStatus;
    });
  }

  void setEmailEditing(bool editingStatus) {
    setState(() {
      _isEmailEditing = editingStatus;
    });
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
      isPhoneLoading: _isPhoneLoading,
      isPhoneEditing: _isPhoneEditing,
      isEmailLoading: _isEmailLoading,
      isEmailEditing: _isEmailEditing,
      email: authProvider.currentUser!.email,
      name: authProvider.currentUser!.name,
      phone: authProvider.currentUser!.phone,
      changeEmail: authProvider.currentUser!.changeEmail,
      saveInstituteName: saveInstituteName,
      saveUserPhone: saveUserPhone,
      saveUserEmail: saveUserEmail,
      setEditing: setEditing,
      setPhoneEditing: setPhoneEditing,
      setEmailEditing: setEmailEditing,
      logout: () => logout(context),
    );
  }
}
