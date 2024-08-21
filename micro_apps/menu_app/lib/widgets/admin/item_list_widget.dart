import 'package:flutter/material.dart';

import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/screens/admin/add_item_screen.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/widgets/admin/add_item_card.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  void navigateToAddItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddItemScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                  AddItemCard(
                    onTap: () => navigateToAddItem(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenSize.width * 0.7,
            height: 50,
            child: IconTextButton(
              iconHorizontalPadding: 7,
              radius: 20,
              text: Strings.receptionEnquiry,
              onPressed: () {},
              color: ThemeColors.primary,
              buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              svgIcon: icons.Icons.enquiry,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
