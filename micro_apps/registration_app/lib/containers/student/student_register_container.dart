import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/widgets/student/student_register_widget.dart';

class StudentRegisterContainer extends StatefulWidget {
  const StudentRegisterContainer({super.key});

  @override
  State<StudentRegisterContainer> createState() =>
      _StudentRegisterContainerState();
}

class _StudentRegisterContainerState extends State<StudentRegisterContainer> {
  Future<void> registerStudent(
    String email,
    String userName,
    String mobileNumber,
    String selectedOption,
  ) async {
    final registrationService = RegistrationService();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (selectedOption == 'self') {
      // registrationService.registerStudent(
      //   email,
      //   userName,
      //   mobileNumber,
      //   selectedOption,
      // );
    }
    // showSuccessModal(context, Strings.verifiedText2, () {
    //   Navigator.of(context).pushNamed(StudentRoutes.enrollment);
    // }, null);
  }

  @override
  Widget build(BuildContext context) {
    return StudentRegisterWidget(
      registerStudent: registerStudent,
    );
  }
}
