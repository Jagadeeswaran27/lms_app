import 'package:flutter/material.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/widgets/admin/category_item_card.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class ItemCategoryWidget extends StatelessWidget {
  const ItemCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void navigateToItemList(String subCategory) {
      Navigator.of(context).pushNamed(
        AdminRoutes.itemList,
        arguments: {
          'category': subCategory,
          'showBack': true,
        },
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: screenSize.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryItemCard(
              icon: icons.Icons.bookIcon,
              title: "Course",
              onTap: () => navigateToItemList("courses"),
            ),
            CategoryItemCard(
              icon: icons.Icons.tailor,
              title: "Tailor",
              onTap: () => navigateToItemList("tailor"),
            ),
            CategoryItemCard(
              icon: icons.Icons.food,
              title: "Food",
              onTap: () => navigateToItemList("food"),
            ),
            CategoryItemCard(
              icon: icons.Icons.food,
              title: "Custom",
              onTap: () => navigateToItemList("custom"),
            ),
          ],
        ),
      ),
    );
  }
}
