import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/svg_lodder.dart';

class AddTitleCard extends StatelessWidget {
  const AddTitleCard({super.key});

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
          const SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SVGLoader(image: icons.Icons.profileBackup),
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
                    text: "",
                    fillColor: ThemeColors.white,
                    borderColor: ThemeColors.cardBorderColor,
                    borderWidth: 0.4,
                    hasShadow: true,
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
