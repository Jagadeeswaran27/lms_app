import 'package:flutter/material.dart';
import 'package:registration_app/constants/enums/button_size.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonSize,
    this.isLoading,
    this.buttonTextStyle,
    this.icon,
    this.iconColor,
    this.svgIcon,
    required this.color,
    this.radius,
    required this.iconHorizontalPadding,
  });

  final String text;
  final ButtonSize? buttonSize;
  final bool? isLoading;
  final TextStyle? buttonTextStyle;
  final double? radius;
  final IconData? icon;
  final Color color;
  final double iconHorizontalPadding;
  final Color? iconColor;
  final String? svgIcon;
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
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: iconHorizontalPadding,
            ),
            alignment: Alignment.center,
            child: isLoading == true
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: ThemeColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: buttonTextStyle ??
                              Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      if (icon != null || svgIcon != null)
                        CircleAvatar(
                          radius: radius,
                          backgroundColor: ThemeColors.white,
                          child: icon != null
                              ? Icon(
                                  icon,
                                  color: iconColor,
                                  size: 20,
                                )
                              : SVGLoader(
                                  image: svgIcon!,
                                  width: 25,
                                  height: 25,
                                ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
