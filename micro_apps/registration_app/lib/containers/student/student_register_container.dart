import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';

import 'package:registration_app/widgets/student/student_register_widget.dart';

class StudentRegisterContainer extends StatefulWidget {
  const StudentRegisterContainer({super.key});

  @override
  State<StudentRegisterContainer> createState() =>
      _StudentRegisterContainerState();
}

class _StudentRegisterContainerState extends State<StudentRegisterContainer> {
  bool isLoading = false;

  Future<void> registerStudent(
    String email,
    String userName,
    String mobileNumber,
    String selectedOption,
    String batchDay,
    String batchTime,
  ) async {
    final registrationService = RegistrationService();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseIds = authProvider.cart.map((e) => e.courseId).toList();
    setState(() {
      isLoading = true;
    });
    if (selectedOption == 'Self') {
      final response = await registrationService.registerStudent(
        courses: authProvider.cart,
        selectedBatchDay: batchDay,
        selectedBatchTime: batchTime,
        registeredBy: authProvider.currentUser!.uid,
        email: email,
        userName: userName,
        mobileNumber: mobileNumber,
        registeredFor: selectedOption,
      );
      if (response.isNotEmpty) {
        authProvider.updateRegisteredCoursesList(courseIds);
        showSnackbar(context, 'Course registered successfully');
        Navigator.of(context)
            .pushReplacementNamed(StudentRoutes.enrollment, arguments: {
          'registrationIds': response,
          'courses': authProvider.cart,
        });
      } else {
        showSnackbar(context, 'Failed to register course');
      }

      setState(() {
        isLoading = false;
      });
    } else if (selectedOption == 'For kid') {
      Navigator.of(context)
          .pushNamed(StudentRoutes.kidRegistration, arguments: {
        'courses': authProvider.cart,
        'batchDay': batchDay,
        'batchTime': batchTime,
        'email': email,
        'userName': userName,
        'mobileNumber': mobileNumber,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StudentRegisterWidget(
      isLoading: isLoading,
      registerStudent: registerStudent,
    );
  }
}
