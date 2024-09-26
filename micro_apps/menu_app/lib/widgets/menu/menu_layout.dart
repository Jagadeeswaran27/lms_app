import 'package:menu_app/screens/common/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_app/constants/enums/user_role_enum.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/resources/strings.dart';

import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';
import 'package:provider/provider.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class MenuLayout extends StatefulWidget {
  const MenuLayout({
    super.key,
    required this.child,
    required this.topBarText,
    this.bottomText,
    this.icon,
    this.onIconTap,
    this.showBackButton = true,
    this.showBottomBar = true,
    this.showAccessCode,
    this.onBack,
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
  final void Function()? onBack;
  final bool showLogout;

  @override
  State<MenuLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<MenuLayout> {
  String instituteName = '';

  @override
  void initState() {
    super.initState();
    handleGetInstitute();
  }

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

  void handleGetInstitute() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final name =
        await authProvider.getInstituteName(authProvider.selectedinstituteCode);

    setState(() {
      instituteName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).viewPadding.top + 20;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
                if (widget.showBackButton == true)
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
                      onPressed:
                          widget.onBack ?? () => Navigator.of(context).pop(),
                    ),
                  ),
                if (widget.showLogout)
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
                        widget.topBarText,
                        style: Theme.of(context).textTheme.bodyMediumPrimary,
                      ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    authProvider.currentUser?.institute.first ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMediumTitleBrownSemiBold,
                                  ),
                                  IconButton(
                                    icon: const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SVGLoader(image: icons.Icons.copy),
                                    ),
                                    onPressed: () => onCopy(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (authProvider.currentUser?.role ==
                          UserRoleEnum.user.roleName)
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                '$instituteName\'s institute',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrown
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (widget.icon != null)
                  Positioned(
                    top: 15,
                    bottom: 0,
                    left: 20,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: widget.onIconTap,
                          child: widget.icon!,
                        ),
                        Text(
                          "Cart",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmallPrimarySemiBold,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Main content area
          Expanded(child: widget.child),
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
