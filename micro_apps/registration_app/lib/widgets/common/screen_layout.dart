import 'package:flutter/material.dart';

import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class ScreenLayout extends StatelessWidget {
  const ScreenLayout({
    super.key,
    required this.child,
    required this.topBarText,
    this.bottomText,
    this.icon,
    this.onIconTap,
    this.showBackButton = true,
  });

  final Widget child;
  final String topBarText;
  final String? bottomText;
  final Widget? icon;
  final void Function()? onIconTap;
  final bool? showBackButton;

  @override
  Widget build(BuildContext context) {
    // Detect the height of the keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final topInset = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Top Bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: topInset, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Stack(
              children: [
                if (showBackButton == true)
                  Positioned(
                    left: 10,
                    top: -5,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ThemeColors.primary,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    topBarText,
                    style: Theme.of(context).textTheme.bodyMediumPrimary,
                  ),
                ),
                if (icon != null)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 14,
                    child: InkWell(
                      onTap: onIconTap,
                      child: icon!,
                    ),
                  ),
              ],
            ),
          ),
          // Main content area
          Expanded(child: child),
          // Bottom container
          Visibility(
            visible: bottomInset == 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: ThemeColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Center(
                child: Text(
                  bottomText ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
