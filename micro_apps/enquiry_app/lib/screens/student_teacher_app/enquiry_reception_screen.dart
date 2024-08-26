import 'package:flutter/material.dart';

import 'package:enquiry_app/containers/student_teacher/enquiry_reception_container.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';

class EnquiryReceptionScreen extends StatelessWidget {
  const EnquiryReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.reception,
      child: EnquiryReceptionContainer(),
    );
  }
}
