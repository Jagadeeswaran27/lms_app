import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final registrationService = RegistrationService();
    setState(() {
      _isLoading = true;
    });

    final isEmailAlreadyRegistered =
        await authProvider.isEmailAlreadyRegistered(userEmail);
    try {
      if (!isEmailAlreadyRegistered) {
        final HttpsCallable callable =
            FirebaseFunctions.instance.httpsCallable('createUser');
        final result = await callable.call(<String, dynamic>{
          'email': userEmail,
          'password': userPassword,
        });
        final uid = result.data['uid'];
        await authProvider.createLMSUser(
            uid, userName, userEmail, 'student', phone);
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
        instituteId: authProvider.selectedinstituteCode,
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
      print('Error type: ${err.runtimeType}');
      print('Error details: $err');
      if (err is FirebaseFunctionsException) {
        print('Firebase Functions Error: ${err.code} - ${err.message}');
        print('Error details: ${err.details}');
      }
      showSnackbar(
          context, 'Error registering courses for kid: ${err.toString()}');
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
