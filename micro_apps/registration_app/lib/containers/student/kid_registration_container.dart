import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/firebase/firebase_options.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart'
    as AuthenticationProvider;
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/student/kid_registration_widget.dart';

class KidRegistrationContainer extends StatefulWidget {
  const KidRegistrationContainer({
    super.key,
    required this.courses,
    required this.batchDay,
    required this.batchTime,
    required this.email,
    required this.userName,
    required this.mobileNumber,
  });

  final List<CourseModel> courses;
  final String batchDay;
  final String batchTime;
  final String email;
  final String userName;
  final String mobileNumber;

  @override
  State<KidRegistrationContainer> createState() =>
      _KidRegistrationContainerState();
}

class _KidRegistrationContainerState extends State<KidRegistrationContainer> {
  bool _isLoading = false;

  void registerKid(
    String userName,
    String userEmail,
    String phone,
    String userPassword,
  ) async {
    final authProvider = Provider.of<AuthenticationProvider.AuthProvider>(
        context,
        listen: false);
    final registrationService = RegistrationService();
    setState(() {
      _isLoading = true;
    });

    final isEmailAlreadyRegistered =
        await authProvider.isEmailAlreadyRegistered(userEmail);

    try {
      if (!isEmailAlreadyRegistered) {
        // await addNewUser(
        //   userEmail,
        //   userPassword,
        //   userName,
        //   phone,
        // );
      }

      final registrationIds = await registrationService.registerKid(
        courses: widget.courses,
        selectedBatchDay: widget.batchDay,
        selectedBatchTime: widget.batchTime,
        registeredBy: userEmail,
        userName: userName,
        mobileNumber: phone,
        registeredFor: 'Kid',
        email: userEmail,
      );

      if (registrationIds.isNotEmpty) {
        showSnackbar(context, 'Courses registered successfully');
        Navigator.pushNamedAndRemoveUntil(
          context,
          StudentRoutes.itemList,
          (route) => false,
        );
      } else {
        showSnackbar(context, 'Error registering courses for kid');
      }
    } catch (err) {
      showSnackbar(context, 'Error registering courses for kid');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KidRegistrationWidget(
      email: widget.email,
      userName: widget.userName,
      mobileNumber: widget.mobileNumber,
      isLoading: _isLoading,
      registerKid: registerKid,
    );
  }
}
