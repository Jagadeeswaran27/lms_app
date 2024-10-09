import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/form_input.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';

class SettingsScreenWidget extends StatelessWidget {
  const SettingsScreenWidget({
    super.key,
    required this.isInstitute,
    required this.name,
    required this.phone,
    required this.email,
    required this.logout,
    required this.changeRole,
  });

  final bool isInstitute;
  final String name;
  final String phone;
  final String email;
  final void Function() logout;
  final void Function() changeRole;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.9,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: ThemeColors.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              isInstitute
                                  ? Strings.instituteName
                                  : Strings.userNameSettings,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumTitleBrown,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 250,
                              child: FormInput(
                                text: "",
                                readOnly: true,
                                hintText: name,
                                borderColor: ThemeColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              Strings.contactInfo,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumTitleBrown,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: ThemeColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmallTitleBrown,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.mail_rounded,
                              color: ThemeColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                email,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmallTitleBrown,
                              ),
                            )
                          ],
                        ),
                        if (!isInstitute)
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 50,
                                width: screenWidth * 0.8,
                                child: IconTextButton(
                                  text: "Change Role",
                                  onPressed: changeRole,
                                  color: ThemeColors.primary,
                                  iconHorizontalPadding: 0,
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: screenWidth * 0.7,
          height: 50,
          child: IconTextButton(
            text: Strings.logout,
            onPressed: logout,
            color: ThemeColors.primary,
            iconHorizontalPadding: 5,
            icon: Icons.logout,
            iconColor: ThemeColors.primary,
          ),
        )
      ],
    );
  }
}
