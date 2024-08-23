import 'package:flutter/material.dart';

import 'package:registration_app/containers/teacher/teacher_register_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherRegisterScreen extends StatelessWidget {
  const TeacherRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.register,
      child: TeacherRegisterContainer(),
    );
  }
}
