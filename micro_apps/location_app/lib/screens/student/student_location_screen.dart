import 'package:flutter/material.dart';

import 'package:location_app/containers/student/student_location_container.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class StudentLocationScreen extends StatelessWidget {
  const StudentLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.location,
      bottomText: Strings.myLocation,
      child: StudentLocationContainer(),
    );
  }
}
