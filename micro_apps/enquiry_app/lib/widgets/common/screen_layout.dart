import 'package:flutter/material.dart';

import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';

class ScreenLayout extends StatelessWidget {
  const ScreenLayout({
    super.key,
    required this.child,
    required this.topBarText,
    this.bottomText,
    this.icon,
    this.onIconTap,
  });

  final Widget child;
  final String topBarText;
  final String? bottomText;
  final Widget? icon;
  final void Function()? onIconTap;

  @override
  Widget build(BuildContext context) {
    // Detect the height of the keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Resize to avoid the keyboard
        body: Column(
          children: [
            // Top Bar
            Container(
              width: double.infinity,
              height: 50,
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 7,
                          bottom: 7,
                          left: 12,
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.border2,
                            width: 0.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1.8,
                              spreadRadius: 0,
                              color: ThemeColors.black.withOpacity(0.25),
                              offset: const Offset(-0.4, 0.3),
                            )
                          ],
                          color: ThemeColors.cardColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: InkWell(
                          onTap: onIconTap,
                          child: icon!,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Main content area
            Expanded(
              child: child,
            ),
            // Bottom container
            Visibility(
              visible: bottomInset ==
                  0, // Hide the bottom container when the keyboard is open
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
      ),
    );
  }
}
