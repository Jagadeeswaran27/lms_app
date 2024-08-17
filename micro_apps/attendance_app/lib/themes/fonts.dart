import 'package:flutter/material.dart';

import 'package:attendance_app/themes/colors.dart';

class ThemeFonts {
  ThemeFonts._();

  static const String poppins = 'Poppins';
  static final ThemeData baseTheme = ThemeData.light();
  static final TextTheme textTheme = baseTheme.textTheme;

  static TextTheme buildLightTextTheme(BuildContext context) {
    return baseTheme.textTheme
        .copyWith(
          headlineMedium: baseTheme.textTheme.headlineMedium!.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: ThemeColors.authPrimary,
          ),
          bodyLarge: baseTheme.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ThemeColors.brown,
          ),
          bodyMedium: baseTheme.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ThemeColors.white,
          ),
          displaySmall: baseTheme.textTheme.displaySmall!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ThemeColors.brown,
          ),
        )
        .apply(
          fontFamily: poppins,
        );
  }
}

extension ThemeExtension on TextTheme {
  TextStyle get displaySmallPrimary =>
      displaySmall!.copyWith(color: ThemeColors.authPrimary);
  TextStyle get displaySmallSemiBold => displaySmall!
      .copyWith(color: ThemeColors.brown, fontWeight: FontWeight.w500);
  TextStyle get displaySmallBold => displaySmall!
      .copyWith(color: ThemeColors.authPrimary, fontWeight: FontWeight.w600);
}
