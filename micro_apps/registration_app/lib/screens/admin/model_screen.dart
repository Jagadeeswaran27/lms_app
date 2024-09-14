import 'package:flutter/material.dart';
import 'package:registration_app/containers/admin/model_screen_container.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class ModelScreen extends StatelessWidget {
  const ModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: "Model Screen",
      child: ModelScreenContainer(),
    );
  }
}
