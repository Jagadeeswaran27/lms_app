import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class MenuLayout extends StatelessWidget {
  const MenuLayout({
    super.key,
    required this.child,
    this.bottomText,
    required this.topBarText,
  });

  final Widget child;
  final String topBarText;
  final String? bottomText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
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
              child: Center(
                child: Text(
                  topBarText,
                  style: Theme.of(context).textTheme.bodyMediumPrimary,
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification) {
                    // You can add custom behavior here if needed
                  }
                  return false;
                },
                child: child,
              ),
            ),
            Container(
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
                  bottomText != null ? bottomText! : '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
