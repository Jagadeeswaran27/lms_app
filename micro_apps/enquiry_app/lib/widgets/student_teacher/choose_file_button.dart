import 'package:flutter/material.dart';

import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';

class ChooseFileButton extends StatelessWidget {
  const ChooseFileButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: ThemeColors.primary,
            width: 2,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            color: ThemeColors.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            Strings.chooseFile,
            style: Theme.of(context).textTheme.titleSmallWhite,
          ),
        ),
      ),
    );
  }
}
