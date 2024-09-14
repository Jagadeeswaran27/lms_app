import 'package:flutter/material.dart';

import 'package:location_app/providers/auth_provider.dart';
import 'package:location_app/routes/student_teacher_routes.dart';
import 'package:location_app/utils/error/show_snackbar.dart';
import 'package:location_app/widgets/student_teacher/access_code_widget.dart';
import 'package:provider/provider.dart';

class AccessCodeContainer extends StatefulWidget {
  const AccessCodeContainer({super.key});

  @override
  State<AccessCodeContainer> createState() => _AccessCodeContainerState();
}

class _AccessCodeContainerState extends State<AccessCodeContainer> {
  bool _isLoading = false;

  void navigateToHomeNavigation() {
    Navigator.of(context).pushNamed(StudentTeacherRoutes.locationUpdated);
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
    return AccessCodeWidget(
      isLoading: _isLoading,
      onInstituteSelection: onInstituteSelection,
    );
  }
}
