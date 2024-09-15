import 'package:flutter/material.dart';
import 'package:registration_app/containers/auth/face_recognition_screen_container.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class FaceRecognitionScreen extends StatelessWidget {
  const FaceRecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: "Face Recognition",
      child: FaceRecignitionScreenContainer(),
    );
  }
}
