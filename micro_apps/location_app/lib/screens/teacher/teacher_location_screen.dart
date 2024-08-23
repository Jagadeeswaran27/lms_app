import 'package:flutter/material.dart';

import 'package:location_app/containers/teacher/teacher_location_container.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class TeacherLocationScreen extends StatelessWidget {
  const TeacherLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.location,
      bottomText: Strings.myLocation,
      child: TeacherLocationContainer(),
    );
  }
}
