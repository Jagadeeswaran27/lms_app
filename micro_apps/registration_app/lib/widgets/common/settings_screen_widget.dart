import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({
    super.key,
    required this.isInstitute,
    required this.name,
    required this.phone,
    required this.email,
    required this.logout,
    required this.changeRole,
    required this.isLoading,
    required this.isEditing,
    required this.saveInstituteName,
    required this.setEditing,
  });

  final bool isInstitute;
  final String name;
  final String phone;
  final String email;
  final bool isLoading;
  final bool isEditing;
  final void Function() logout;
  final void Function() changeRole;
  final void Function(String, bool) saveInstituteName;
  final void Function(bool) setEditing;

  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreenWidget> {
  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();

  void saveName() {
    if (_nameController.text.isEmpty) {
      showSnackbar(context, 'Name cannot be empty');
      widget.setEditing(false);
      return;
    }

    if (_nameController.text == widget.name) {
      showSnackbar(context, 'No changes made');
      widget.setEditing(false);
      return;
    }

    widget.saveInstituteName(_nameController.text, widget.isInstitute);
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  void onEdit() {
    widget.setEditing(true);
    FocusScope.of(context).requestFocus(_nameFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
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
                                    widget.isInstitute
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: FormInput(
                                      controller: _nameController,
                                      text: "",
                                      readOnly: !widget.isEditing,
                                      hintText: "",
                                      borderColor: widget.isEditing
                                          ? ThemeColors.primary
                                          : ThemeColors.white,
                                      focusNode: _nameFocusNode,
                                    ),
                                  ),
                                  widget.isLoading
                                      ? const CircularProgressIndicator(
                                          strokeWidth: 3,
                                        )
                                      : SizedBox(
                                          child: widget.isEditing
                                              ? IconButton(
                                                  icon: const Icon(Icons.check),
                                                  onPressed: saveName,
                                                )
                                              : IconButton(
                                                  onPressed: onEdit,
                                                  icon: const Icon(Icons.edit),
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
                                    widget.phone,
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
                                      widget.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmallTitleBrown,
                                    ),
                                  )
                                ],
                              ),
                              if (!widget.isInstitute)
                                Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      height: 50,
                                      width: screenWidth * 0.8,
                                      child: IconTextButton(
                                        text: "Change Role",
                                        onPressed: widget.changeRole,
                                        color: ThemeColors.primary,
                                        iconHorizontalPadding: 0,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          )
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
                  onPressed: widget.logout,
                  color: ThemeColors.primary,
                  iconHorizontalPadding: 5,
                  icon: Icons.logout,
                  iconColor: ThemeColors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
