import 'package:flutter/material.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/teacher_registration_model.dart';

import 'package:registration_app/widgets/admin/teacher_list_widget.dart';

class TeacherListContainer extends StatefulWidget {
  const TeacherListContainer({super.key});

  @override
  State<TeacherListContainer> createState() => _TeacherListContainerState();
}

class _TeacherListContainerState extends State<TeacherListContainer> {
  bool _isLoading = false;
  List<TeacherRegistrationModel> _registrationList = [];

  Future<void> fetchTeacherRegistrationList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await RegistrationService().getTeacherRegistrationList();
      setState(() {
        _registrationList = response;
      });
    } catch (e) {
      print('Error fetching teacher registration list: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTeacherRegistrationList();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherListWidget(
      isLoading: _isLoading,
      registrationList: _registrationList,
    );
  }
}
