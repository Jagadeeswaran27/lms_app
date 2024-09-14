import 'package:flutter/material.dart';

import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/student/student_access_code_widget.dart';
import 'package:provider/provider.dart';

class StudentAccessCodeContainer extends StatefulWidget {
  const StudentAccessCodeContainer({super.key});

  @override
  State<StudentAccessCodeContainer> createState() =>
      _StudentAccessCodeContainerState();
}

class _StudentAccessCodeContainerState
    extends State<StudentAccessCodeContainer> {
  bool _isLoading = false;

  void navigateToHomeNavigation() {
    Navigator.of(context).pushNamed(StudentRoutes.itemList);
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
    return StudentAccessCodeWidget(
      isLoading: _isLoading,
      onInstituteSelection: onInstituteSelection,
    );
  }
}
