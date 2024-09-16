import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:registration_app/core/services/face_recognition/face_recignition_firebase_service.dart';
import 'package:registration_app/core/services/face_recognition/face_recognition.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/screens/student/student_app.dart';
import 'package:registration_app/widgets/auth/face_recognition_screen_widget.dart';

class FaceRecignitionScreenContainer extends StatefulWidget {
  const FaceRecignitionScreenContainer({super.key});

  @override
  State<FaceRecignitionScreenContainer> createState() =>
      _FaceRecignitionScreenContainerState();
}

class _FaceRecignitionScreenContainerState
    extends State<FaceRecignitionScreenContainer> {
  bool _isLoading = false;
  FaceRecognitionFirebaseService faceRecignitionFirebaseService =
      FaceRecognitionFirebaseService();

  Future<void> onSaveFaceRecognition(List<File?> images) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool response = await saveFaceRecognition(
      images,
      authProvider.currentUser!.uid,
    );
    if (response) {
      await faceRecignitionFirebaseService
          .saveFaceRecognitionFlag(authProvider.currentUser!.uid);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const StudentApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FaceRecognitionScreenWidget(
      isLoading: _isLoading,
      onSaveFaceRecognition: onSaveFaceRecognition,
    );
  }
}
