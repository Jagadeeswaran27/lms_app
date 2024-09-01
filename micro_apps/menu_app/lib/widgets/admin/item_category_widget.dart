import 'package:flutter/material.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/widgets/admin/category_item_card.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class ItemCategoryWidget extends StatelessWidget {
  const ItemCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void navigateToItemList(String category) {
      Navigator.of(context).pushNamed(category);
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: screenSize.width * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryItemCard(
              icon: icons.Icons.bookIcon,
              title: "Study",
              onTap: () => navigateToItemList(AdminRoutes.itemList),
            ),
            const CategoryItemCard(
              icon: icons.Icons.tailor,
              title: "Tailor",
            ),
            const CategoryItemCard(
              icon: icons.Icons.food,
              title: "Food",
            ),
          ],
        ),
      ),
    );
  }
}
