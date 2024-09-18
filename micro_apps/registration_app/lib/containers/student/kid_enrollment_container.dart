import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/widgets/student/kid_enrollment_widget.dart';

class KidEnrollmentContainer extends StatefulWidget {
  const KidEnrollmentContainer({
    super.key,
    required this.registrationIds,
    required this.courses,
    required this.uid,
  });

  final List<String> registrationIds;
  final List<CourseModel> courses;
  final String uid;

  @override
  State<KidEnrollmentContainer> createState() =>
      _StudentEnrollmentContainerState();
}

class _StudentEnrollmentContainerState extends State<KidEnrollmentContainer> {
  void checkFaceRecognition() {
    Navigator.of(context)
        .pushNamed(StudentRoutes.faceRecognition, arguments: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return KidEnrollmentWidget(
      registrationIds: widget.registrationIds,
      courses: widget.courses,
      onProceedToPayment: checkFaceRecognition,
    );
  }
}
