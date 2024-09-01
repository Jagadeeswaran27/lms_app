import 'package:location_app/screens/auth/welcome_screen.dart';
import 'package:location_app/utils/error/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:location_app/providers/auth_provider.dart';
import 'package:location_app/resources/strings.dart';

import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatelessWidget {
  const ScreenLayout({
    super.key,
    required this.child,
    required this.topBarText,
    this.bottomText,
    this.icon,
    this.onIconTap,
    this.showBackButton = true,
    this.showBottomBar = true,
  });

  final Widget child;
  final String topBarText;
  final String? bottomText;
  final Widget? icon;
  final void Function()? onIconTap;
  final bool? showBackButton;
  final bool showBottomBar;

  @override
  Widget build(BuildContext context) {
    void logout(BuildContext context) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final response = await authProvider.signOut();
      if (response) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        showSnackbar(context, Strings.errorLoggingOut);
      }
    }

    // Detect the height of the keyboard
    final topInset = MediaQuery.of(context).viewPadding.top + 20;

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
                Positioned(
                  right: 10,
                  top: -5,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.logout_outlined,
                      color: ThemeColors.primary,
                      size: 20,
                    ),
                    onPressed: () => logout(context),
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
          // if (showBottomBar)
          //   Visibility(
          //     visible: bottomInset == 0,
          //     child: Container(
          //       width: double.infinity,
          //       padding: const EdgeInsets.all(16.0),
          //       decoration: BoxDecoration(
          //         color: ThemeColors.primary,
          //         borderRadius: const BorderRadius.only(
          //           topLeft: Radius.circular(20.0),
          //           topRight: Radius.circular(20.0),
          //         ),
          //       ),
          //       child: Center(
          //         child: Text(
          //           bottomText ?? '',
          //           style: Theme.of(context).textTheme.titleLarge,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
