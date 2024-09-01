import 'package:flutter/material.dart';

import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';
import 'package:registration_app/widgets/admin/student_list_widget.dart';

class StudentListContainer extends StatefulWidget {
  const StudentListContainer({super.key});

  @override
  State<StudentListContainer> createState() => _StudentListContainerState();
}

class _StudentListContainerState extends State<StudentListContainer> {
  bool _isLoading = false;
  List<StudentRegistrationModel> _registrationList = [];

  Future<void> fetchStudentRegistrationList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await RegistrationService().getStudentRegistrationList();
      setState(() {
        _registrationList = response;
      });
    } catch (e) {
      print('Error fetching student registration list: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void onRejectStudent(String registrationId) async {
    try {
      final response =
          await RegistrationService().onRejectStudent(registrationId);
      if (response) {
        setState(() {
          _registrationList = _registrationList
              .where((item) => item.registrationId != registrationId)
              .toList();
        });
      }
    } catch (e) {
      print('Error rejecting student $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentRegistrationList();
  }

  @override
  Widget build(BuildContext context) {
    return StudentListWidget(
      isLoading: _isLoading,
      registrationList: _registrationList,
      onRejectStudent: onRejectStudent,
    );
  }
}
