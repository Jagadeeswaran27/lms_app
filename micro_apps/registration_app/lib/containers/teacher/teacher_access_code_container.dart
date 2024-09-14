import 'package:flutter/material.dart';

import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/teacher/teacher_access_code_widget.dart';
import 'package:provider/provider.dart';

class TeacherAccessCodeContainer extends StatefulWidget {
  const TeacherAccessCodeContainer({super.key});

  @override
  State<TeacherAccessCodeContainer> createState() =>
      _TeacherAccessCodeContainerState();
}

class _TeacherAccessCodeContainerState
    extends State<TeacherAccessCodeContainer> {
  bool _isLoading = false;

  void navigateToHomeNavigation() {
    Navigator.of(context).pushNamed(TeacherRoutes.itemList);
  }

  void onInstituteSelection(String instituteCode) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
    final response =
        await authProvider.checkExistingInstituteCode(instituteCode.trim());
    setState(() {
      _isLoading = false;
    });
    if (response) {
      navigateToHomeNavigation();
    } else {
      showSnackbar(context, "Fetching failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TeacherAccessCodeWidget(
      isLoading: _isLoading,
      onInstituteSelection: onInstituteSelection,
    );
  }
}
