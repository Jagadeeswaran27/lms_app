import 'package:attendance_app/themes/colors.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/constants/enums/button_size.dart';
import 'package:attendance_app/utils/widgets/get_elevated_button_padding.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonSize,
    this.isLoading,
    this.buttonTextStyle,
    required this.color,
  });

  final String text;
  final ButtonSize? buttonSize;
  final bool? isLoading;
  final TextStyle? buttonTextStyle;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: ThemeColors.iconButtonBorderColor,
            width: 0.31,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              color: ThemeColors.black.withOpacity(0.1),
              offset: const Offset(1, 2),
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Container(
            padding: getElevatedButtonPadding(buttonSize),
            alignment: Alignment.center,
            child: Text(
              text,
              style: buttonTextStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
