import 'package:attendance_app/utils/error/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance_app/constants/enums/user_role_enum.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/screens/common/welcome_screen.dart';

import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/svg_lodder.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app/resources/icons.dart' as icons;

class AttendanceLayout extends StatelessWidget {
  const AttendanceLayout({
    super.key,
    required this.child,
    required this.topBarText,
    this.bottomText,
    this.icon,
    this.onIconTap,
    this.showBackButton = true,
    this.showBottomBar = true,
    this.showAccessCode,
    this.showLogout = true,
  });

  final Widget child;
  final String topBarText;
  final String? bottomText;
  final Widget? icon;
  final void Function()? onIconTap;
  final bool? showBackButton;
  final bool showBottomBar;
  final bool? showAccessCode;
  final bool showLogout;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

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

    void onCopy(BuildContext context) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final currentUser = authProvider.currentUser!;
      final clinicId = currentUser.institute.first;
      await Clipboard.setData(ClipboardData(text: clinicId));
      if (context.mounted) {
        showSnackbar(context, 'AccessCode Code Copied');
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
                if (showLogout)
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
                  child: Column(
                    children: [
                      Text(
                        topBarText,
                        style: Theme.of(context).textTheme.bodyMediumPrimary,
                      ),
                      if (authProvider.currentUser?.role ==
                          UserRoleEnum.admin.roleName)
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              if (authProvider.currentUser?.role ==
                                  UserRoleEnum.admin.roleName)
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        '${authProvider.currentUser!.name.trim()}\'s institute',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMediumTitleBrown,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            authProvider.currentUser?.institute
                                                    .first ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMediumTitleBrownSemiBold,
                                          ),
                                          IconButton(
                                            icon: const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: SVGLoader(
                                                  image: icons.Icons.copy),
                                            ),
                                            onPressed: () => onCopy(context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
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
