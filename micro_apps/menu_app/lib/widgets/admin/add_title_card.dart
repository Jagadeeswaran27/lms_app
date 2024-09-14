import 'dart:io';

import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/svg_lodder.dart';

class AddTitleCard extends StatelessWidget {
  final Function() onTap;
  final String text;
  final File? image;
  final String? titleError;
  final Function(String) onTitleChange;

  const AddTitleCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    required this.onTitleChange,
    required this.titleError,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: ThemeColors.cardColor,
        border: Border.all(
          color: ThemeColors.cardBorderColor,
          width: 0.3,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: image == null
                    ? const SVGLoader(image: icons.Icons.profileBackup)
                    : ClipOval(
                        child: Image.file(
                          image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.addTitle,
                  style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: screenSize.width * 0.45,
                  child: FormInput(
                    text: '',
                    hintText: text,
                    // initialValue: text,
                    onChanged: onTitleChange,
                    fillColor: ThemeColors.white,
                    borderColor: ThemeColors.cardBorderColor,
                    borderWidth: 0.4,
                    hasShadow: true,
                  ),
                ),
                if (titleError != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      titleError!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: ThemeColors.primary),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
